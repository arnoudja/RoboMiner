/*
 * Copyright (C) 2014 Arnoud Jagerman
 *
 * This file is part of RoboMiner.
 *
 * RoboMiner is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * RoboMiner is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include "stdafx.h"

#include "Database.h"
#include "DatabaseStatement.h"
#include "ConfigFile.h"

#include <cstring>
#include <list>

using namespace std;

namespace
{
    static const int    cMaxSourceCodeLength = 10240;
    static const double cScoreHistoryFactor  = 5.;
    static const double cScoreStartFactor    = 1.4;
}


CDatabase::CDatabase(CConfigFile& configFile)
{
    mysql_init(&m_mysql);

    m_connection = mysql_real_connect(&m_mysql,
                                      configFile.getConfigValue("dbserver").c_str(),
                                      configFile.getConfigValue("dbuser").c_str(),
                                      configFile.getConfigValue("dbpassword").c_str(),
                                      configFile.getConfigValue("dbdatabase").c_str(),
                                      0, 0, 0);

    assert(m_connection);
}


CDatabase::~CDatabase()
{
    mysql_close(m_connection);
}


string CDatabase::getSource(int id)
{
    string query("SELECT sourceCode "
                 "FROM ProgramSource "
                 "WHERE id = ?");

    CDatabaseStatement statement(m_connection, query);

    statement.addIntParameterValue(id);

    statement.execute();    

    char sourceCode[cMaxSourceCodeLength];

    statement.bindStringResult(sourceCode, cMaxSourceCodeLength);

    bool found = statement.fetch();
    assert(found);

    return sourceCode;
}


void CDatabase::updateError(int id, const string& error)
{
    string query("UPDATE ProgramSource "
                 "SET errorDescription = ?, verified = false, compiledSize = -1 "
                 "WHERE id = ? ");

    CDatabaseStatement statement(m_connection, query);

    statement.addStringParameterValue(error.c_str(), error.size());
    statement.addIntParameterValue(id);

    statement.execute();
}


void CDatabase::setValidSource(int id, int compiledSize)
{
    string query("UPDATE ProgramSource "
                 "SET errorDescription = '', verified = true, compiledSize = ? "
                 "WHERE id = ? ");

    CDatabaseStatement statement(m_connection, query);

    statement.addIntParameterValue(compiledSize);
    statement.addIntParameterValue(id);

    statement.execute();
}


CDatabase::MiningArea CDatabase::getMiningArea(int miningAreaId)
{
    string query("SELECT sizeX, sizeY, maxMoves, miningTime, taxRate, aiRobotId "
                 "FROM MiningArea "
                 "WHERE MiningArea.id = ? ");

    CDatabaseStatement statement(m_connection, query);

    statement.addIntParameterValue(miningAreaId);

    statement.execute();

    MiningArea result;
    result.miningAreaId = miningAreaId;

    statement.bindIntResult(&result.sizeX);
    statement.bindIntResult(&result.sizeY);
    statement.bindIntResult(&result.maxMoves);
    statement.bindIntResult(&result.miningTime);
    statement.bindIntResult(&result.taxRate);
    statement.bindIntResult(&result.aiRobotId);

    if (statement.fetch())
    {
        result.oreSupply = getMiningAreaOreSupply(result.miningAreaId);
    }
    else
    {
        result.miningAreaId = -1;
    }

    return result;
}


list<CDatabase::MiningArea> CDatabase::getMiningAreas()
{
    string query("SELECT id, sizeX, sizeY, maxMoves, miningTime, taxRate, aiRobotId "
                 "FROM MiningArea ");

    CDatabaseStatement statement(m_connection, query);

    statement.execute();

    MiningArea item;

    statement.bindIntResult(&item.miningAreaId);
    statement.bindIntResult(&item.sizeX);
    statement.bindIntResult(&item.sizeY);
    statement.bindIntResult(&item.maxMoves);
    statement.bindIntResult(&item.miningTime);
    statement.bindIntResult(&item.taxRate);
    statement.bindIntResult(&item.aiRobotId);

    list<CDatabase::MiningArea> result;

    while (statement.fetch())
    {
        item.oreSupply = getMiningAreaOreSupply(item.miningAreaId);

        result.push_back(item);
    }

    return result;
}


list<CDatabase::MiningAreaOreSupply> CDatabase::getMiningAreaOreSupply(int miningAreaId)
{
    string query("SELECT oreId, supply, radius "
                 "FROM MiningAreaOreSupply "
                 "WHERE miningAreaId = ? "
                 "ORDER BY oreId DESC ");

    CDatabaseStatement statement(m_connection, query);

    statement.addIntParameterValue(miningAreaId);

    statement.execute();

    MiningAreaOreSupply item;

    statement.bindIntResult(&item.oreId);
    statement.bindIntResult(&item.amount);
    statement.bindIntResult(&item.radius);

    list<MiningAreaOreSupply> result;

    while (statement.fetch())
    {
        result.push_back(item);
    }

    return result;
}


CDatabase::RobotData CDatabase::getRobotData(int robotId)
{
    string query("SELECT Robot.usersId, Robot.sourceCode, Robot.maxOre, "
                 "Robot.miningSpeed, Robot.maxTurns, Robot.cpuSpeed, "
                 "Robot.forwardSpeed, Robot.backwardSpeed, Robot.rotateSpeed, "
                 "Robot.robotSize "
                 "FROM Robot "
                 "WHERE Robot.id = ? ");

    CDatabaseStatement statement(m_connection, query);

    statement.addIntParameterValue(robotId);

    statement.execute();

    RobotData result;
    result.robotId = robotId;

    char sourceCode[cMaxSourceCodeLength];

    statement.bindIntResult(&result.usersId);
    statement.bindStringResult(sourceCode, cMaxSourceCodeLength);
    statement.bindIntResult(&result.maxOre);
    statement.bindIntResult(&result.miningSpeed);
    statement.bindIntResult(&result.maxTurns);
    statement.bindIntResult(&result.cpuSpeed);
    statement.bindDoubleResult(&result.forwardSpeed);
    statement.bindDoubleResult(&result.backwardSpeed);
    statement.bindIntResult(&result.rotateSpeed);
    statement.bindDoubleResult(&result.robotSize);

    bool found = statement.fetch();
    assert(found);

    result.sourceCode = sourceCode;

    return result;
}


list<CDatabase::MiningRallyItem> CDatabase::getNextMiningRally(int miningAreaId)
{
    string query("SELECT MiningQueue.id, "
                 "TIMESTAMPADD(SECOND, MiningArea.miningTime, "
                              "IF (Robot.rechargeEndTime < MiningQueue.creationTime, "
                                  "MiningQueue.creationTime, "
                                  "Robot.rechargeEndTime)) AS miningEndTime, "
                 "TIMESTAMPDIFF(SECOND, NOW(), "
                               "TIMESTAMPADD(SECOND, MiningArea.miningTime, "
                                            "IF (Robot.rechargeEndTime < MiningQueue.creationTime, "
                                                "MiningQueue.creationTime, "
                                                "Robot.rechargeEndTime))) AS timeLeft, "
                 "Robot.id, Robot.usersId, Robot.sourceCode, Robot.maxOre, "
                 "Robot.miningSpeed, Robot.maxTurns, Robot.cpuSpeed, "
                 "Robot.forwardSpeed, Robot.backwardSpeed, Robot.rotateSpeed, "
                 "Robot.robotSize "
                 "FROM MiningQueue, Robot, MiningArea "
                 "WHERE MiningQueue.miningAreaId = ? "
                 "AND MiningQueue.rallyResultId IS NULL "
                 "AND Robot.id = MiningQueue.robotId "
                 "AND (Robot.rechargeEndTime IS NULL OR Robot.rechargeEndTime <= NOW()) "
                 "AND (Robot.miningEndTime IS NULL OR Robot.miningEndTime <= NOW()) "
                 "AND MiningArea.id = MiningQueue.miningAreaId "
                 "AND NOT EXISTS ("
                    "SELECT prev.id "
                    "FROM MiningQueue prev "
                    "WHERE prev.id < MiningQueue.id "
                    "AND prev.robotId = MiningQueue.robotId "
                    "AND prev.rallyResultId IS NULL "
                 ")"
                 "ORDER BY miningEndTime ");

    CDatabaseStatement statement(m_connection, query);

    statement.addIntParameterValue(miningAreaId);

    statement.execute();

    MiningRallyItem item;
    char sourceCode[cMaxSourceCodeLength];

    statement.bindIntResult(&item.miningQueueId);
    statement.bindTimestampResult(&item.miningEndTime);
    statement.bindIntResult(&item.secondsLeft);
    statement.bindIntResult(&item.robotId);
    statement.bindIntResult(&item.usersId);
    statement.bindStringResult(sourceCode, cMaxSourceCodeLength);
    statement.bindIntResult(&item.maxOre);
    statement.bindIntResult(&item.miningSpeed);
    statement.bindIntResult(&item.maxTurns);
    statement.bindIntResult(&item.cpuSpeed);
    statement.bindDoubleResult(&item.forwardSpeed);
    statement.bindDoubleResult(&item.backwardSpeed);
    statement.bindIntResult(&item.rotateSpeed);
    statement.bindDoubleResult(&item.robotSize);

    list<MiningRallyItem> result;

    while (statement.fetch())
    {
        item.sourceCode = sourceCode;

        bool sameUserFound(false);
        for (list<MiningRallyItem>::const_iterator iter = result.begin();
             !sameUserFound && iter != result.end(); ++iter)
        {
            if (item.usersId == iter->usersId)
            {
                sameUserFound = true;
            }
        }

        if (!sameUserFound)
        {
            result.push_back(item);
        }
    }

    return result;
}


int CDatabase::addAnimation(const string& animation)
{
    string query("INSERT INTO RallyResult "
                 "(resultData) "
                 "VALUES (?)");

    CDatabaseStatement statement(m_connection, query);

    statement.addStringParameterValue(animation.c_str(), animation.size());

    statement.execute();

    return statement.getInsertId();
}


void CDatabase::updateMiningRally(const list<MiningRallyItem>& miningRallyItems, int rallyResultId)
{
    int playerNumber = 0;
    for (list<MiningRallyItem>::const_iterator iter = miningRallyItems.begin(); iter != miningRallyItems.end(); ++iter, ++playerNumber)
    {
        updateRobot(iter->robotId, iter->miningEndTime);
        updateMiningQueue(iter->miningQueueId, playerNumber, rallyResultId, iter->miningEndTime);
        applyRobotPendingChanges(iter->robotId, iter->miningEndTime);
        removeOldMiningQueueItems(iter->robotId);
    }
}


void CDatabase::updateMiningQueue(int miningQueueId, int playerNumber, int rallyResultId, MYSQL_TIME miningEndTime)
{
    string query("UPDATE MiningQueue "
                 "SET rallyResultId = ?, miningEndTime = ?, playerNumber = ? "
                 "WHERE id = ? ");

    CDatabaseStatement statement(m_connection, query);

    statement.addIntParameterValue(rallyResultId);
    statement.addTimestampParameterValue(miningEndTime);
    statement.addIntParameterValue(playerNumber);
    statement.addIntParameterValue(miningQueueId);

    statement.execute();
}


void CDatabase::addMiningOreResult(int miningQueueId, int oreId, int amount)
{
    string query("INSERT INTO MiningOreResult "
                 "(miningQueueId, oreId, amount) "
                 "VALUES "
                 "(?, ?, ?) ");

    CDatabaseStatement statement(m_connection, query);

    statement.addIntParameterValue(miningQueueId);
    statement.addIntParameterValue(oreId);
    statement.addIntParameterValue(amount);

    statement.execute();
}


void CDatabase::addRobotActionsDone(int miningQueueId, int actionType, int amount)
{
    string query("INSERT INTO RobotActionsDone "
                 "(miningQueueId, actionType, amount) "
                 "VALUES "
                 "(?, ?, ?) ");

    CDatabaseStatement statement(m_connection, query);

    statement.addIntParameterValue(miningQueueId);
    statement.addIntParameterValue(actionType);
    statement.addIntParameterValue(amount);

    statement.execute();
}


void CDatabase::updateRobot(int robotId, MYSQL_TIME miningEndTime)
{
    string query("UPDATE Robot "
                 "SET miningEndTime = ?, rechargeEndTime = TIMESTAMPADD(SECOND, rechargeTime, ?) "
                 "WHERE id = ? ");

    CDatabaseStatement statement(m_connection, query);

    statement.addTimestampParameterValue(miningEndTime);
    statement.addTimestampParameterValue(miningEndTime);
    statement.addIntParameterValue(robotId);

    statement.execute();
}


void CDatabase::updateRobotScore(int robotId, int miningQueueId, int miningAreaId, double score)
{
    updateMiningQueueScore(miningQueueId, score);

    int totalRuns = 0;
    double previousScore = .0;

    if (getRobotScoreDatabaseValue(robotId, miningAreaId, totalRuns, previousScore))
    {
        double newScore = ((cScoreHistoryFactor - 1.) * previousScore + score) / cScoreHistoryFactor;
        updateRobotScoreDatabaseValue(robotId, miningAreaId, newScore);
    }
    else
    {
        // Start with a low value to avoid robots with a low number of high luck runs getting a top score.
        double newScore = score / cScoreStartFactor;
        insertRobotScoreDatabaseValue(robotId, miningAreaId, newScore);
    }
}


void CDatabase::updateMiningQueueScore(int miningQueueId, double score)
{
    string query("UPDATE MiningQueue "
                 "SET score = ? "
                 "WHERE id = ? ");

    CDatabaseStatement statement(m_connection, query);

    statement.addDoubleParameterValue(score);
    statement.addIntParameterValue(miningQueueId);

    statement.execute();
}


bool CDatabase::getRobotScoreDatabaseValue(int robotId, int miningAreaId, int& totalRuns, double& score)
{
    string query("SELECT totalRuns, score "
                 "FROM RobotMiningAreaScore "
                 "WHERE robotId = ? "
                 "AND miningAreaId = ? ");

    CDatabaseStatement statement(m_connection, query);

    statement.addIntParameterValue(robotId);
    statement.addIntParameterValue(miningAreaId);

    statement.execute();

    statement.bindIntResult(&totalRuns);
    statement.bindDoubleResult(&score);

    bool found = false;

    if (statement.fetch())
    {
        found = true;
    }

    return found;
}


void CDatabase::insertRobotScoreDatabaseValue(int robotId, int miningAreaId, double score)
{
    string query("INSERT INTO RobotMiningAreaScore "
                 "(robotId, miningAreaId, totalRuns, score) "
                 "VALUES "
                 "(?, ?, 1, ?) ");

    CDatabaseStatement statement(m_connection, query);

    statement.addIntParameterValue(robotId);
    statement.addIntParameterValue(miningAreaId);
    statement.addDoubleParameterValue(score);

    statement.execute();
}


void CDatabase::updateRobotScoreDatabaseValue(int robotId, int miningAreaId, double score)
{
    string query("UPDATE RobotMiningAreaScore "
                 "SET score = ?, totalRuns = totalRuns + 1 "
                 "WHERE robotId = ? "
                 "AND miningAreaId = ? ");

    CDatabaseStatement statement(m_connection, query);

    statement.addDoubleParameterValue(score);
    statement.addIntParameterValue(robotId);
    statement.addIntParameterValue(miningAreaId);

    statement.execute();
}


void CDatabase::applyRobotPendingChanges(int robotId, MYSQL_TIME miningEndTime)
{
    string query("UPDATE Robot "
                 "INNER JOIN PendingRobotChanges "
                 "ON PendingRobotChanges.robotId = Robot.id "
                 "SET Robot.sourceCode = PendingRobotChanges.sourceCode, "
                 " Robot.oreContainerId = PendingRobotChanges.oreContainerId, "
                 " Robot.miningUnitId = PendingRobotChanges.miningUnitId, "
                 " Robot.batteryId = PendingRobotChanges.batteryId, "
                 " Robot.memoryModuleId = PendingRobotChanges.memoryModuleId, "
                 " Robot.cpuId = PendingRobotChanges.cpuId, "
                 " Robot.engineId = PendingRobotChanges.engineId, "
                 " Robot.rechargeTime = PendingRobotChanges.rechargeTime, "
                 " Robot.maxOre = PendingRobotChanges.maxOre, "
                 " Robot.miningSpeed = PendingRobotChanges.miningSpeed, "
                 " Robot.maxTurns = PendingRobotChanges.maxTurns, "
                 " Robot.memorySize = PendingRobotChanges.memorySize, "
                 " Robot.cpuSpeed = PendingRobotChanges.cpuSpeed, "
                 " Robot.forwardSpeed = PendingRobotChanges.forwardSpeed, "
                 " Robot.backwardSpeed = PendingRobotChanges.backwardSpeed, "
                 " Robot.rotateSpeed = PendingRobotChanges.rotateSpeed, "
                 " Robot.robotSize = PendingRobotChanges.robotSize, "
                 " PendingRobotChanges.changesCommitTime = ? "
                 "WHERE Robot.id = ? ");

    CDatabaseStatement statement(m_connection, query);

    statement.addTimestampParameterValue(miningEndTime);
    statement.addIntParameterValue(robotId);

    statement.execute();
}


void CDatabase::removeOldMiningQueueItems(int robotId)
{
    list<OldMiningQueueItem> idList = findOldMiningQueueItems(robotId);

    for (list<OldMiningQueueItem>::const_iterator iter = idList.begin(); iter != idList.end(); ++iter)
    {
        removeMiningOreResultEntries(iter->miningQueueId);
        removeRobotActionsDoneEntries(iter->miningQueueId);
        removeMiningQueueEntry(iter->miningQueueId);

        if (!rallyResultInUse(iter->rallyResultId))
        {
            removeRallyResultEntry(iter->rallyResultId);
        }
    }
}


list<CDatabase::OldMiningQueueItem> CDatabase::findOldMiningQueueItems(int robotId)
{
    string query("SELECT id, rallyResultId "
                 "FROM MiningQueue "
                 "WHERE robotId = ? "
                 "AND claimed = true "
                 "ORDER BY MiningQueue.id DESC "
                 "LIMIT 100, 100000 ");

    CDatabaseStatement statement(m_connection, query);

    statement.addIntParameterValue(robotId);

    statement.execute();

    OldMiningQueueItem miningQueueItem;

    statement.bindIntResult(&miningQueueItem.miningQueueId);
    statement.bindIntResult(&miningQueueItem.rallyResultId);

    list<OldMiningQueueItem> result;

    while (statement.fetch())
    {
        result.push_back(miningQueueItem);
    }

    return result;
}


void CDatabase::removeMiningQueueEntry(int miningQueueId)
{
    string query("DELETE "
                 "FROM MiningQueue "
                 "WHERE id = ? ");

    CDatabaseStatement statement(m_connection, query);

    statement.addIntParameterValue(miningQueueId);

    statement.execute();
}


void CDatabase::removeMiningOreResultEntries(int miningQueueId)
{
    string query("DELETE "
                 "FROM MiningOreResult "
                 "WHERE miningQueueId = ? ");

    CDatabaseStatement statement(m_connection, query);

    statement.addIntParameterValue(miningQueueId);

    statement.execute();
}


void CDatabase::removeRobotActionsDoneEntries(int miningQueueId)
{
    string query("DELETE "
                 "FROM RobotActionsDone "
                 "WHERE miningQueueId = ? ");

    CDatabaseStatement statement(m_connection, query);

    statement.addIntParameterValue(miningQueueId);

    statement.execute();
}


bool CDatabase::rallyResultInUse(int rallyResultId)
{
    string query("SELECT id "
                 "FROM MiningQueue "
                 "WHERE rallyResultId = ? ");

    CDatabaseStatement statement(m_connection, query);

    statement.addIntParameterValue(rallyResultId);

    statement.execute();

    int miningQueueId;

    statement.bindIntResult(&miningQueueId);

    bool result = false;

    while (statement.fetch())
    {
        result = true;
    }

    return result;
}


void CDatabase::removeRallyResultEntry(int rallyResultId)
{
    string query("DELETE "
                 "FROM RallyResult "
                 "WHERE id = ? ");

    CDatabaseStatement statement(m_connection, query);

    statement.addIntParameterValue(rallyResultId);

    statement.execute();
}


CDatabase::PoolData CDatabase::getPoolData(int poolId)
{
    string query("SELECT Pool.miningAreaId, Pool.requiredRuns "
                 "FROM Pool "
                 "WHERE Pool.id = ? ");

    CDatabaseStatement statement(m_connection, query);

    statement.addIntParameterValue(poolId);

    statement.execute();

    PoolData result;
    result.poolId = poolId;

    statement.bindIntResult(&result.miningAreaId);
    statement.bindIntResult(&result.requiredRuns);
    
    if (!statement.fetch())
    {
        result.poolId = -1;
    }

    return result;
}


list<CDatabase::PoolRallyItem> CDatabase::getNextPoolRally(int poolId)
{
    string query("SELECT PoolItem.id, PoolItem.sourceCode, PoolItem.runsDone, "
                 "Robot.maxOre, Robot.miningSpeed, Robot.maxTurns, "
                 "Robot.cpuSpeed, "
                 "Robot.forwardSpeed, Robot.backwardSpeed, Robot.rotateSpeed, "
                 "Robot.robotSize "
                 "FROM PoolItem, Robot "
                 "WHERE PoolItem.poolId = ? "
                 "AND Robot.id = PoolItem.robotId "
                 "ORDER BY PoolItem.runsDone ASC, PoolItem.totalScore DESC, PoolItem.id ASC "
                 "LIMIT 4 ");

    CDatabaseStatement statement(m_connection, query);

    statement.addIntParameterValue(poolId);

    statement.execute();

    PoolRallyItem item;
    char sourceCode[cMaxSourceCodeLength];

    list<PoolRallyItem> result;

    statement.bindIntResult(&item.poolItemId);
    statement.bindStringResult(sourceCode, cMaxSourceCodeLength);
    statement.bindIntResult(&item.runsDone);
    statement.bindIntResult(&item.maxOre);
    statement.bindIntResult(&item.miningSpeed);
    statement.bindIntResult(&item.maxTurns);
    statement.bindIntResult(&item.cpuSpeed);
    statement.bindDoubleResult(&item.forwardSpeed);
    statement.bindDoubleResult(&item.backwardSpeed);
    statement.bindIntResult(&item.rotateSpeed);
    statement.bindDoubleResult(&item.robotSize);

    while (statement.fetch())
    {
        item.sourceCode = sourceCode;

        bool sameRunsDone(true);

        if (!result.empty() && result.front().runsDone != item.runsDone)
        {
            sameRunsDone = false;
        }

        if (sameRunsDone)
        {
            result.push_back(item);
        }
    }

    return result;
}


void CDatabase::updatePoolItem(int poolItemId, double score)
{
    string query("UPDATE PoolItem "
                 "SET totalScore = totalScore + ?, runsDone = runsDone + 1 "
                 "WHERE id = ? ");

    CDatabaseStatement statement(m_connection, query);

    statement.addIntParameterValue(score);
    statement.addIntParameterValue(poolItemId);

    statement.execute();
}


void CDatabase::updatePoolItemMiningTotals(int poolItemId, int oreId, int amount)
{
    string query("INSERT INTO PoolItemMiningTotals "
                 "(poolItemId, oreId, totalMined) "
                 "values "
                 "(?, ?, ?) "
                 "ON DUPLICATE KEY UPDATE "
                 "totalMined = totalMined + VALUES(totalMined) ");

    CDatabaseStatement statement(m_connection, query);

    statement.addIntParameterValue(poolItemId);
    statement.addIntParameterValue(oreId);
    statement.addIntParameterValue(amount);

    statement.execute();
}
