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

#include <cstring>
#include <list>

using namespace std;

namespace
{
    static const int cMaxSourceCodeLength = 10240;
}

CDatabase::CDatabase()
{
    mysql_init(&m_mysql);

    m_connection = mysql_real_connect(&m_mysql, "localhost", "root", "", "RoboMiner", 0, 0, 0);

    assert(m_connection);
}


CDatabase::~CDatabase()
{
    mysql_close(m_connection);
}


string CDatabase::getSource(int id)
{
    MYSQL_STMT* statement = mysql_stmt_init(m_connection);
    assert(statement);

    string query("SELECT sourceCode FROM ProgramSource WHERE id = ?");
    int status = mysql_stmt_prepare(statement, query.c_str(), query.size());
    assert(status == 0);

    MYSQL_BIND bind[1];
    memset(bind, 0, sizeof(bind));
    bind[0].buffer_type = MYSQL_TYPE_LONG;
    bind[0].buffer_length = sizeof(id);
    bind[0].buffer = &id;

    status = mysql_stmt_bind_param(statement, bind);
    assert(status == 0);

    status = mysql_stmt_execute(statement);
    assert(status == 0);
    
    char sourceCode[cMaxSourceCodeLength];
    unsigned long length = 0;
    my_bool isNull;
    my_bool isError;
    
    MYSQL_BIND bindResult[1];
    memset(bindResult, 0, sizeof(bindResult));
    bindResult[0].buffer_type = MYSQL_TYPE_STRING;
    bindResult[0].buffer_length = sizeof(sourceCode);
    bindResult[0].buffer = sourceCode;
    bindResult[0].length = &length;
    bindResult[0].is_null = &isNull;
    bindResult[0].error = &isError;
    
    status = mysql_stmt_bind_result(statement, bindResult);
    assert(status == 0);
    
    status = mysql_stmt_store_result(statement);
    assert(status == 0);
    
    status = mysql_stmt_fetch(statement);
    assert(status == 0);
    
    string source;
    
    if (!isNull && !isError)
    {
        source = sourceCode;
    }
    
    mysql_stmt_close(statement);

    return source;
}


void CDatabase::updateError(int id, const string& error)
{
    MYSQL_STMT* statement = mysql_stmt_init(m_connection);
    assert(statement);

    string query("UPDATE ProgramSource SET errorDescription = ?, verified = false, compiledSize = -1 WHERE id = ?");
    int status = mysql_stmt_prepare(statement, query.c_str(), query.size());
    assert(status == 0);

    MYSQL_BIND bind[2];
    memset(bind, 0, sizeof(bind));
    bind[0].buffer_type = MYSQL_TYPE_STRING;
    bind[0].buffer_length = error.size();
    bind[0].buffer = const_cast<char*>(error.c_str());
    bind[1].buffer_type = MYSQL_TYPE_LONG;
    bind[1].buffer_length = sizeof(id);
    bind[1].buffer = &id;

    status = mysql_stmt_bind_param(statement, bind);
    assert(status == 0);

    status = mysql_stmt_execute(statement);
    assert(status == 0);

    mysql_stmt_close(statement);
}


void CDatabase::setValidSource(int id, int compiledSize)
{
    MYSQL_STMT* statement = mysql_stmt_init(m_connection);
    assert(statement);

    string query("UPDATE ProgramSource SET errorDescription = '', verified = true, compiledSize = ? WHERE id = ?");
    int status = mysql_stmt_prepare(statement, query.c_str(), query.size());
    assert(status == 0);

    MYSQL_BIND bind[2];
    memset(bind, 0, sizeof(bind));
    bind[0].buffer_type = MYSQL_TYPE_LONG;
    bind[0].buffer_length = sizeof(compiledSize);
    bind[0].buffer = &compiledSize;
    bind[1].buffer_type = MYSQL_TYPE_LONG;
    bind[1].buffer_length = sizeof(id);
    bind[1].buffer = &id;

    status = mysql_stmt_bind_param(statement, bind);
    assert(status == 0);

    status = mysql_stmt_execute(statement);
    assert(status == 0);

    mysql_stmt_close(statement);
}


CDatabase::MiningArea CDatabase::getMiningArea(int miningAreaId)
{
    MYSQL_STMT* statement = mysql_stmt_init(m_connection);
    assert(statement);

    string query("SELECT sizeX, sizeY, maxMoves, miningTime, taxRate, aiRobotId "
                 "FROM MiningArea "
                 "WHERE MiningArea.id = ? ");
    int status = mysql_stmt_prepare(statement, query.c_str(), query.size());
    assert(status == 0);

    MYSQL_BIND bind[1];
    memset(bind, 0, sizeof(bind));
    bind[0].buffer_type = MYSQL_TYPE_LONG;
    bind[0].buffer_length = sizeof(miningAreaId);
    bind[0].buffer = &miningAreaId;

    status = mysql_stmt_bind_param(statement, bind);
    assert(status == 0);

    status = mysql_stmt_execute(statement);
    assert(status == 0);

    MiningArea result;
    result.miningAreaId = miningAreaId;

    MYSQL_BIND bindResult[6];
    memset(bindResult, 0, sizeof(bindResult));
    
    bindResult[0].buffer_type = MYSQL_TYPE_LONG;
    bindResult[0].buffer_length = sizeof(result.sizeX);
    bindResult[0].buffer = &result.sizeX;
    
    bindResult[1].buffer_type = MYSQL_TYPE_LONG;
    bindResult[1].buffer_length = sizeof(result.sizeY);
    bindResult[1].buffer = &result.sizeY;

    bindResult[2].buffer_type = MYSQL_TYPE_LONG;
    bindResult[2].buffer_length = sizeof(result.maxMoves);
    bindResult[2].buffer = &result.maxMoves;

    bindResult[3].buffer_type = MYSQL_TYPE_LONG;
    bindResult[3].buffer_length = sizeof(result.miningTime);
    bindResult[3].buffer = &result.miningTime;

    bindResult[4].buffer_type = MYSQL_TYPE_LONG;
    bindResult[4].buffer_length = sizeof(result.taxRate);
    bindResult[4].buffer = &result.taxRate;

    bindResult[5].buffer_type = MYSQL_TYPE_LONG;
    bindResult[5].buffer_length = sizeof(result.aiRobotId);
    bindResult[5].buffer = &result.aiRobotId;

    status = mysql_stmt_bind_result(statement, bindResult);
    assert(status == 0);
    
    status = mysql_stmt_store_result(statement);
    assert(status == 0);

    if (mysql_stmt_fetch(statement) == 0)
    {
        result.oreSupply = getMiningAreaOreSupply(result.miningAreaId);
    }
    else
    {
        result.miningAreaId = -1;
    }

    mysql_stmt_close(statement);

    return result;
}


list<CDatabase::MiningArea> CDatabase::getMiningAreas()
{
    MYSQL_STMT* statement = mysql_stmt_init(m_connection);
    assert(statement);

    string query("SELECT id, sizeX, sizeY, maxMoves, miningTime, taxRate, aiRobotId "
                 "FROM MiningArea ");
    int status = mysql_stmt_prepare(statement, query.c_str(), query.size());
    assert(status == 0);

    status = mysql_stmt_execute(statement);
    assert(status == 0);

    MiningArea item;

    MYSQL_BIND bindResult[7];
    memset(bindResult, 0, sizeof(bindResult));
    
    bindResult[0].buffer_type = MYSQL_TYPE_LONG;
    bindResult[0].buffer_length = sizeof(item.miningAreaId);
    bindResult[0].buffer = &item.miningAreaId;
    
    bindResult[1].buffer_type = MYSQL_TYPE_LONG;
    bindResult[1].buffer_length = sizeof(item.sizeX);
    bindResult[1].buffer = &item.sizeX;
    
    bindResult[2].buffer_type = MYSQL_TYPE_LONG;
    bindResult[2].buffer_length = sizeof(item.sizeY);
    bindResult[2].buffer = &item.sizeY;
    
    bindResult[3].buffer_type = MYSQL_TYPE_LONG;
    bindResult[3].buffer_length = sizeof(item.maxMoves);
    bindResult[3].buffer = &item.maxMoves;
    
    bindResult[4].buffer_type = MYSQL_TYPE_LONG;
    bindResult[4].buffer_length = sizeof(item.miningTime);
    bindResult[4].buffer = &item.miningTime;
    
    bindResult[5].buffer_type = MYSQL_TYPE_LONG;
    bindResult[5].buffer_length = sizeof(item.taxRate);
    bindResult[5].buffer = &item.taxRate;
    
    bindResult[6].buffer_type = MYSQL_TYPE_LONG;
    bindResult[6].buffer_length = sizeof(item.aiRobotId);
    bindResult[6].buffer = &item.aiRobotId;
    
    status = mysql_stmt_bind_result(statement, bindResult);
    assert(status == 0);
    
    status = mysql_stmt_store_result(statement);
    assert(status == 0);
    
    list<CDatabase::MiningArea> result;
    while (mysql_stmt_fetch(statement) == 0)
    {
        item.oreSupply = getMiningAreaOreSupply(item.miningAreaId);
    
        result.push_back(item);
    }
    
    mysql_stmt_close(statement);

    return result;
}


list<CDatabase::MiningAreaOreSupply> CDatabase::getMiningAreaOreSupply(int miningAreaId)
{
    list<MiningAreaOreSupply> result;
    
    MYSQL_STMT* statement = mysql_stmt_init(m_connection);
    assert(statement);

    string query("SELECT oreId, supply, radius "
                 "FROM MiningAreaOreSupply "
                 "WHERE miningAreaId = ? "
                 "ORDER BY oreId DESC ");
    int status = mysql_stmt_prepare(statement, query.c_str(), query.size());
    assert(status == 0);

    MYSQL_BIND bind[1];
    memset(bind, 0, sizeof(bind));
    bind[0].buffer_type = MYSQL_TYPE_LONG;
    bind[0].buffer_length = sizeof(miningAreaId);
    bind[0].buffer = &miningAreaId;

    status = mysql_stmt_bind_param(statement, bind);
    assert(status == 0);

    status = mysql_stmt_execute(statement);
    assert(status == 0);
    
    MiningAreaOreSupply item;
    
    MYSQL_BIND bindResult[3];
    memset(bindResult, 0, sizeof(bindResult));
    
    bindResult[0].buffer_type = MYSQL_TYPE_LONG;
    bindResult[0].buffer_length = sizeof(item.oreId);
    bindResult[0].buffer = &item.oreId;
    
    bindResult[1].buffer_type = MYSQL_TYPE_LONG;
    bindResult[1].buffer_length = sizeof(item.amount);
    bindResult[1].buffer = &item.amount;
    
    bindResult[2].buffer_type = MYSQL_TYPE_LONG;
    bindResult[2].buffer_length = sizeof(item.radius);
    bindResult[2].buffer = &item.radius;
    
    status = mysql_stmt_bind_result(statement, bindResult);
    assert(status == 0);
    
    status = mysql_stmt_store_result(statement);
    assert(status == 0);
    
    while (mysql_stmt_fetch(statement) == 0)
    {
        result.push_back(item);
    }
    
    mysql_stmt_close(statement);
    
    return result;
}


CDatabase::RobotData CDatabase::getRobotData(int robotId)
{
    RobotData result;
    result.robotId = robotId;
    
    MYSQL_STMT* statement = mysql_stmt_init(m_connection);
    assert(statement);

    string query("SELECT Robot.usersId, Robot.sourceCode, Robot.maxOre, "
                 "Robot.miningSpeed, Robot.maxTurns, Robot.cpuSpeed, "
                 "Robot.forwardSpeed, Robot.backwardSpeed, Robot.rotateSpeed, "
                 "Robot.robotSize "
                 "FROM Robot "
                 "WHERE Robot.id = ? ");
    int status = mysql_stmt_prepare(statement, query.c_str(), query.size());
    assert(status == 0);

    MYSQL_BIND bind[1];
    memset(bind, 0, sizeof(bind));
    bind[0].buffer_type = MYSQL_TYPE_LONG;
    bind[0].buffer_length = sizeof(robotId);
    bind[0].buffer = &robotId;

    status = mysql_stmt_bind_param(statement, bind);
    assert(status == 0);

    status = mysql_stmt_execute(statement);
    assert(status == 0);

    char sourceCode[cMaxSourceCodeLength];
    unsigned long length = 0;
    my_bool isNull;
    my_bool isError;

    MYSQL_BIND bindResult[10];
    memset(bindResult, 0, sizeof(bindResult));
    
    bindResult[0].buffer_type = MYSQL_TYPE_LONG;
    bindResult[0].buffer_length = sizeof(result.usersId);
    bindResult[0].buffer = &result.usersId;
    
    bindResult[1].buffer_type = MYSQL_TYPE_STRING;
    bindResult[1].buffer_length = sizeof(sourceCode);
    bindResult[1].buffer = sourceCode;
    bindResult[1].length = &length;
    bindResult[1].is_null = &isNull;
    bindResult[1].error = &isError;

    bindResult[2].buffer_type = MYSQL_TYPE_LONG;
    bindResult[2].buffer_length = sizeof(result.maxOre);
    bindResult[2].buffer = &result.maxOre;
    
    bindResult[3].buffer_type = MYSQL_TYPE_LONG;
    bindResult[3].buffer_length = sizeof(result.miningSpeed);
    bindResult[3].buffer = &result.miningSpeed;

    bindResult[4].buffer_type = MYSQL_TYPE_LONG;
    bindResult[4].buffer_length = sizeof(result.maxTurns);
    bindResult[4].buffer = &result.maxTurns;

    bindResult[5].buffer_type = MYSQL_TYPE_LONG;
    bindResult[5].buffer_length = sizeof(result.cpuSpeed);
    bindResult[5].buffer = &result.cpuSpeed;

    bindResult[6].buffer_type = MYSQL_TYPE_DOUBLE;
    bindResult[6].buffer_length = sizeof(result.forwardSpeed);
    bindResult[6].buffer = &result.forwardSpeed;

    bindResult[7].buffer_type = MYSQL_TYPE_DOUBLE;
    bindResult[7].buffer_length = sizeof(result.backwardSpeed);
    bindResult[7].buffer = &result.backwardSpeed;

    bindResult[8].buffer_type = MYSQL_TYPE_LONG;
    bindResult[8].buffer_length = sizeof(result.rotateSpeed);
    bindResult[8].buffer = &result.rotateSpeed;

    bindResult[9].buffer_type = MYSQL_TYPE_LONG;
    bindResult[9].buffer_length = sizeof(result.robotSize);
    bindResult[9].buffer = &result.robotSize;

    status = mysql_stmt_bind_result(statement, bindResult);
    assert(status == 0);
    
    status = mysql_stmt_store_result(statement);
    assert(status == 0);
    
    status = mysql_stmt_fetch(statement);
    assert(status == 0);

    if (!isNull && !isError)
    {
        result.sourceCode = sourceCode;
    }
    
    return result;
}


list<CDatabase::MiningRallyItem> CDatabase::getNextMiningRally(int miningAreaId)
{
    list<MiningRallyItem> result;
    
    MYSQL_STMT* statement = mysql_stmt_init(m_connection);
    assert(statement);

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
    int status = mysql_stmt_prepare(statement, query.c_str(), query.size());
    assert(status == 0);

    MYSQL_BIND bind[1];
    memset(bind, 0, sizeof(bind));
    bind[0].buffer_type = MYSQL_TYPE_LONG;
    bind[0].buffer_length = sizeof(miningAreaId);
    bind[0].buffer = &miningAreaId;

    status = mysql_stmt_bind_param(statement, bind);
    assert(status == 0);

    status = mysql_stmt_execute(statement);
    assert(status == 0);
    
    MiningRallyItem item;
    char sourceCode[cMaxSourceCodeLength];
    unsigned long length = 0;
    my_bool isNull;
    my_bool isError;
    
    MYSQL_BIND bindResult[14];
    memset(bindResult, 0, sizeof(bindResult));
    
    bindResult[0].buffer_type = MYSQL_TYPE_LONG;
    bindResult[0].buffer_length = sizeof(item.miningQueueId);
    bindResult[0].buffer = &item.miningQueueId;

    bindResult[1].buffer_type = MYSQL_TYPE_TIMESTAMP;
    bindResult[1].buffer_length = sizeof(item.miningEndTime);
    bindResult[1].buffer = &item.miningEndTime;

    bindResult[2].buffer_type = MYSQL_TYPE_LONG;
    bindResult[2].buffer_length = sizeof(item.secondsLeft);
    bindResult[2].buffer = &item.secondsLeft;

    bindResult[3].buffer_type = MYSQL_TYPE_LONG;
    bindResult[3].buffer_length = sizeof(item.robotId);
    bindResult[3].buffer = &item.robotId;
    
    bindResult[4].buffer_type = MYSQL_TYPE_LONG;
    bindResult[4].buffer_length = sizeof(item.usersId);
    bindResult[4].buffer = &item.usersId;

    bindResult[5].buffer_type = MYSQL_TYPE_STRING;
    bindResult[5].buffer_length = sizeof(sourceCode);
    bindResult[5].buffer = sourceCode;
    bindResult[5].length = &length;
    bindResult[5].is_null = &isNull;
    bindResult[5].error = &isError;

    bindResult[6].buffer_type = MYSQL_TYPE_LONG;
    bindResult[6].buffer_length = sizeof(item.maxOre);
    bindResult[6].buffer = &item.maxOre;
    
    bindResult[7].buffer_type = MYSQL_TYPE_LONG;
    bindResult[7].buffer_length = sizeof(item.miningSpeed);
    bindResult[7].buffer = &item.miningSpeed;

    bindResult[8].buffer_type = MYSQL_TYPE_LONG;
    bindResult[8].buffer_length = sizeof(item.maxTurns);
    bindResult[8].buffer = &item.maxTurns;

    bindResult[9].buffer_type = MYSQL_TYPE_LONG;
    bindResult[9].buffer_length = sizeof(item.cpuSpeed);
    bindResult[9].buffer = &item.cpuSpeed;

    bindResult[10].buffer_type = MYSQL_TYPE_DOUBLE;
    bindResult[10].buffer_length = sizeof(item.forwardSpeed);
    bindResult[10].buffer = &item.forwardSpeed;

    bindResult[11].buffer_type = MYSQL_TYPE_DOUBLE;
    bindResult[11].buffer_length = sizeof(item.backwardSpeed);
    bindResult[11].buffer = &item.backwardSpeed;

    bindResult[12].buffer_type = MYSQL_TYPE_LONG;
    bindResult[12].buffer_length = sizeof(item.rotateSpeed);
    bindResult[12].buffer = &item.rotateSpeed;

    bindResult[13].buffer_type = MYSQL_TYPE_LONG;
    bindResult[13].buffer_length = sizeof(item.robotSize);
    bindResult[13].buffer = &item.robotSize;

    status = mysql_stmt_bind_result(statement, bindResult);
    assert(status == 0);
    
    status = mysql_stmt_store_result(statement);
    assert(status == 0);

    while (mysql_stmt_fetch(statement) == 0)
    {
        if (!isNull && !isError)
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
    }
    
    mysql_stmt_close(statement);
    
    return result;
}


int CDatabase::addAnimation(const string& animation)
{
    int result = 0;
    
    MYSQL_STMT* statement = mysql_stmt_init(m_connection);
    assert(statement);

    string query("INSERT INTO RallyResult (resultData) VALUES (?)");
    int status = mysql_stmt_prepare(statement, query.c_str(), query.size());
    assert(status == 0);

    MYSQL_BIND bind[1];
    memset(bind, 0, sizeof(bind));
    bind[0].buffer_type = MYSQL_TYPE_STRING;
    bind[0].buffer_length = animation.size();
    bind[0].buffer = const_cast<char*>(animation.c_str());

    status = mysql_stmt_bind_param(statement, bind);
    assert(status == 0);

    status = mysql_stmt_execute(statement);
    assert(status == 0);

    result = mysql_stmt_insert_id(statement);
    
    mysql_stmt_close(statement);
    
    return result;
}


void CDatabase::updateMiningRally(const list<MiningRallyItem>& miningRallyItems, int rallyResultId)
{
    int playerNumber = 0;
    for (list<MiningRallyItem>::const_iterator iter = miningRallyItems.begin(); iter != miningRallyItems.end(); ++iter, ++playerNumber)
    {
        updateRobot(iter->robotId, iter->miningEndTime);
        updateMiningQueue(iter->miningQueueId, playerNumber, rallyResultId, iter->miningEndTime);
        removeOldMiningQueueItems(iter->robotId);
    }
}


void CDatabase::updateMiningQueue(int miningQueueId, int playerNumber, int rallyResultId, MYSQL_TIME miningEndTime)
{
    MYSQL_STMT* statement = mysql_stmt_init(m_connection);
    assert(statement);

    string query("UPDATE MiningQueue SET rallyResultId = ?, miningEndTime = ?, playerNumber = ? WHERE id = ?");
    int status = mysql_stmt_prepare(statement, query.c_str(), query.size());
    assert(status == 0);

    MYSQL_BIND bind[4];
    memset(bind, 0, sizeof(bind));
    bind[0].buffer_type = MYSQL_TYPE_LONG;
    bind[0].buffer_length = sizeof(rallyResultId);
    bind[0].buffer = &rallyResultId;

    bind[1].buffer_type = MYSQL_TYPE_TIMESTAMP;
    bind[1].buffer_length = sizeof(miningEndTime);
    bind[1].buffer = &miningEndTime;

    bind[2].buffer_type = MYSQL_TYPE_LONG;
    bind[2].buffer_length = sizeof(playerNumber);
    bind[2].buffer = &playerNumber;

    bind[3].buffer_type = MYSQL_TYPE_LONG;
    bind[3].buffer_length = sizeof(miningQueueId);
    bind[3].buffer = &miningQueueId;

    status = mysql_stmt_bind_param(statement, bind);
    assert(status == 0);

    status = mysql_stmt_execute(statement);
    assert(status == 0);

    mysql_stmt_close(statement);
}


void CDatabase::addMiningOreResult(int miningQueueId, int oreId, int amount)
{
    MYSQL_STMT* statement = mysql_stmt_init(m_connection);
    assert(statement);

    string query("INSERT INTO MiningOreResult "
                 "(miningQueueId, oreId, amount) "
                 "VALUES "
                 "(?, ?, ?) ");
    int status = mysql_stmt_prepare(statement, query.c_str(), query.size());
    assert(status == 0);

    MYSQL_BIND bind[3];
    memset(bind, 0, sizeof(bind));
    bind[0].buffer_type = MYSQL_TYPE_LONG;
    bind[0].buffer_length = sizeof(miningQueueId);
    bind[0].buffer = &miningQueueId;

    bind[1].buffer_type = MYSQL_TYPE_LONG;
    bind[1].buffer_length = sizeof(oreId);
    bind[1].buffer = &oreId;

    bind[2].buffer_type = MYSQL_TYPE_LONG;
    bind[2].buffer_length = sizeof(amount);
    bind[2].buffer = &amount;

    status = mysql_stmt_bind_param(statement, bind);
    assert(status == 0);

    status = mysql_stmt_execute(statement);
    assert(status == 0);

    mysql_stmt_close(statement);    
}


void CDatabase::updateRobot(int robotId, MYSQL_TIME miningEndTime)
{
    MYSQL_STMT* statement = mysql_stmt_init(m_connection);
    assert(statement);

    string query("UPDATE Robot "
                 "SET miningEndTime = ?, rechargeEndTime = TIMESTAMPADD(SECOND, rechargeTime, ?) "
                 "WHERE id = ? ");
    int status = mysql_stmt_prepare(statement, query.c_str(), query.size());
    assert(status == 0);

    MYSQL_BIND bind[3];
    memset(bind, 0, sizeof(bind));
    bind[0].buffer_type = MYSQL_TYPE_TIMESTAMP;
    bind[0].buffer_length = sizeof(miningEndTime);
    bind[0].buffer = &miningEndTime;

    bind[1].buffer_type = MYSQL_TYPE_TIMESTAMP;
    bind[1].buffer_length = sizeof(miningEndTime);
    bind[1].buffer = &miningEndTime;

    bind[2].buffer_type = MYSQL_TYPE_LONG;
    bind[2].buffer_length = sizeof(robotId);
    bind[2].buffer = &robotId;

    status = mysql_stmt_bind_param(statement, bind);
    assert(status == 0);

    status = mysql_stmt_execute(statement);
    assert(status == 0);

    mysql_stmt_close(statement);
}


void CDatabase::updateRobotScore(int robotId, int miningAreaId, double score)
{
    int totalRuns = 0;
    double previousScore = .0;

    if (getRobotScoreDatabaseValue(robotId, miningAreaId, totalRuns, previousScore))
    {
        double newScore = (4. * previousScore + score) / 5.;
        updateRobotScoreDatabaseValue(robotId, miningAreaId, newScore);
    }
    else
    {
        // Start with a low value to avoid robots with a low number of high luck runs getting a top score.
        double newScore = score / 2.;
        insertRobotScoreDatabaseValue(robotId, miningAreaId, newScore);
    }
}


bool CDatabase::getRobotScoreDatabaseValue(int robotId, int miningAreaId, int& totalRuns, double& score)
{
    MYSQL_STMT* statement = mysql_stmt_init(m_connection);
    assert(statement);

    string query("SELECT totalRuns, score "
                 "FROM RobotMiningAreaScore "
                 "WHERE robotId = ? "
                 "AND miningAreaId = ? ");

    int status = mysql_stmt_prepare(statement, query.c_str(), query.size());
    assert(status == 0);

    MYSQL_BIND bind[2];
    memset(bind, 0, sizeof(bind));

    bind[0].buffer_type = MYSQL_TYPE_LONG;
    bind[0].buffer_length = sizeof(robotId);
    bind[0].buffer = &robotId;

    bind[1].buffer_type = MYSQL_TYPE_LONG;
    bind[1].buffer_length = sizeof(miningAreaId);
    bind[1].buffer = &miningAreaId;

    status = mysql_stmt_bind_param(statement, bind);
    assert(status == 0);

    status = mysql_stmt_execute(statement);
    assert(status == 0);

    MYSQL_BIND bindResult[2];
    memset(bindResult, 0, sizeof(bindResult));

    bindResult[0].buffer_type = MYSQL_TYPE_LONG;
    bindResult[0].buffer_length = sizeof(totalRuns);
    bindResult[0].buffer = &totalRuns;

    bindResult[1].buffer_type = MYSQL_TYPE_DOUBLE;
    bindResult[1].buffer_length = sizeof(score);
    bindResult[1].buffer = &score;

    status = mysql_stmt_bind_result(statement, bindResult);
    assert(status == 0);

    status = mysql_stmt_store_result(statement);
    assert(status == 0);

    bool found = false;

    if (mysql_stmt_fetch(statement) == 0)
    {
        found = true;
    }

    mysql_stmt_close(statement);
    
    return found;
}


void CDatabase::insertRobotScoreDatabaseValue(int robotId, int miningAreaId, double score)
{
    MYSQL_STMT* statement = mysql_stmt_init(m_connection);
    assert(statement);

    string query("INSERT INTO RobotMiningAreaScore "
                 "(robotId, miningAreaId, totalRuns, score) "
                 "VALUES "
                 "(?, ?, 1, ?) ");
    int status = mysql_stmt_prepare(statement, query.c_str(), query.size());
    assert(status == 0);

    MYSQL_BIND bind[3];
    memset(bind, 0, sizeof(bind));

    bind[0].buffer_type = MYSQL_TYPE_LONG;
    bind[0].buffer_length = sizeof(robotId);
    bind[0].buffer = &robotId;

    bind[1].buffer_type = MYSQL_TYPE_LONG;
    bind[1].buffer_length = sizeof(miningAreaId);
    bind[1].buffer = &miningAreaId;

    bind[2].buffer_type = MYSQL_TYPE_DOUBLE;
    bind[2].buffer_length = sizeof(score);
    bind[2].buffer = &score;

    status = mysql_stmt_bind_param(statement, bind);
    assert(status == 0);

    status = mysql_stmt_execute(statement);
    assert(status == 0);

    mysql_stmt_close(statement);
}


void CDatabase::updateRobotScoreDatabaseValue(int robotId, int miningAreaId, double score)
{
    MYSQL_STMT* statement = mysql_stmt_init(m_connection);
    assert(statement);

    string query("UPDATE RobotMiningAreaScore "
                 "SET score = ?, totalRuns = totalRuns + 1 "
                 "WHERE robotId = ? "
                 "AND miningAreaId = ? ");
    int status = mysql_stmt_prepare(statement, query.c_str(), query.size());
    assert(status == 0);

    MYSQL_BIND bind[3];
    memset(bind, 0, sizeof(bind));

    bind[0].buffer_type = MYSQL_TYPE_DOUBLE;
    bind[0].buffer_length = sizeof(score);
    bind[0].buffer = &score;

    bind[1].buffer_type = MYSQL_TYPE_LONG;
    bind[1].buffer_length = sizeof(robotId);
    bind[1].buffer = &robotId;

    bind[2].buffer_type = MYSQL_TYPE_LONG;
    bind[2].buffer_length = sizeof(miningAreaId);
    bind[2].buffer = &miningAreaId;

    status = mysql_stmt_bind_param(statement, bind);
    assert(status == 0);

    status = mysql_stmt_execute(statement);
    assert(status == 0);

    mysql_stmt_close(statement);
}


void CDatabase::removeOldMiningQueueItems(int robotId)
{
    list<OldMiningQueueItem> idList = findOldMiningQueueItems(robotId);

    for (list<OldMiningQueueItem>::const_iterator iter = idList.begin(); iter != idList.end(); ++iter)
    {
        removeMiningQueueEntry(iter->miningQueueId);
        removeMiningOreResultEntries(iter->miningQueueId);

        if (!rallyResultInUse(iter->rallyResultId))
        {
            removeRallyResultEntry(iter->rallyResultId);
        }
    }
}


list<CDatabase::OldMiningQueueItem> CDatabase::findOldMiningQueueItems(int robotId)
{
    MYSQL_STMT* statement = mysql_stmt_init(m_connection);
    assert(statement);

    string query("SELECT id, rallyResultId "
                 "FROM MiningQueue "
                 "WHERE robotId = ? "
                 "AND claimed = true "
                 "ORDER BY MiningQueue.id DESC "
                 "LIMIT 100, 100000 ");

    int status = mysql_stmt_prepare(statement, query.c_str(), query.size());
    assert(status == 0);

    MYSQL_BIND bind[1];
    memset(bind, 0, sizeof(bind));
    bind[0].buffer_type = MYSQL_TYPE_LONG;
    bind[0].buffer_length = sizeof(robotId);
    bind[0].buffer = &robotId;

    status = mysql_stmt_bind_param(statement, bind);
    assert(status == 0);

    status = mysql_stmt_execute(statement);
    assert(status == 0);

    MYSQL_BIND bindResult[2];
    memset(bindResult, 0, sizeof(bindResult));

    OldMiningQueueItem miningQueueItem;

    bindResult[0].buffer_type = MYSQL_TYPE_LONG;
    bindResult[0].buffer_length = sizeof(miningQueueItem.miningQueueId);
    bindResult[0].buffer = &miningQueueItem.miningQueueId;
    bindResult[1].buffer_type = MYSQL_TYPE_LONG;
    bindResult[1].buffer_length = sizeof(miningQueueItem.rallyResultId);
    bindResult[1].buffer = &miningQueueItem.rallyResultId;

    status = mysql_stmt_bind_result(statement, bindResult);
    assert(status == 0);

    status = mysql_stmt_store_result(statement);
    assert(status == 0);

    list<OldMiningQueueItem> result;

    while (mysql_stmt_fetch(statement) == 0)
    {
        result.push_back(miningQueueItem);
    }

    mysql_stmt_close(statement);
    
    return result;
}


void CDatabase::removeMiningQueueEntry(int miningQueueId)
{
    MYSQL_STMT* statement = mysql_stmt_init(m_connection);
    assert(statement);

    string query("DELETE "
                 "FROM MiningQueue "
                 "WHERE id = ? ");
    int status = mysql_stmt_prepare(statement, query.c_str(), query.size());
    assert(status == 0);

    MYSQL_BIND bind[1];
    memset(bind, 0, sizeof(bind));
    bind[0].buffer_type = MYSQL_TYPE_LONG;
    bind[0].buffer_length = sizeof(miningQueueId);
    bind[0].buffer = &miningQueueId;

    status = mysql_stmt_bind_param(statement, bind);
    assert(status == 0);

    status = mysql_stmt_execute(statement);
    assert(status == 0);

    mysql_stmt_close(statement);    
}


void CDatabase::removeMiningOreResultEntries(int miningQueueId)
{
    MYSQL_STMT* statement = mysql_stmt_init(m_connection);
    assert(statement);

    string query("DELETE "
                 "FROM MiningOreResult "
                 "WHERE miningQueueId = ? ");
    int status = mysql_stmt_prepare(statement, query.c_str(), query.size());
    assert(status == 0);

    MYSQL_BIND bind[1];
    memset(bind, 0, sizeof(bind));
    bind[0].buffer_type = MYSQL_TYPE_LONG;
    bind[0].buffer_length = sizeof(miningQueueId);
    bind[0].buffer = &miningQueueId;

    status = mysql_stmt_bind_param(statement, bind);
    assert(status == 0);

    status = mysql_stmt_execute(statement);
    assert(status == 0);

    mysql_stmt_close(statement);    
}


bool CDatabase::rallyResultInUse(int rallyResultId)
{
    MYSQL_STMT* statement = mysql_stmt_init(m_connection);
    assert(statement);

    string query("SELECT id "
                 "FROM MiningQueue "
                 "WHERE rallyResultId = ? ");

    int status = mysql_stmt_prepare(statement, query.c_str(), query.size());
    assert(status == 0);

    MYSQL_BIND bind[1];
    memset(bind, 0, sizeof(bind));
    bind[0].buffer_type = MYSQL_TYPE_LONG;
    bind[0].buffer_length = sizeof(rallyResultId);
    bind[0].buffer = &rallyResultId;

    status = mysql_stmt_bind_param(statement, bind);
    assert(status == 0);

    status = mysql_stmt_execute(statement);
    assert(status == 0);

    MYSQL_BIND bindResult[1];
    memset(bindResult, 0, sizeof(bindResult));

    int miningQueueId;

    bindResult[0].buffer_type = MYSQL_TYPE_LONG;
    bindResult[0].buffer_length = sizeof(miningQueueId);
    bindResult[0].buffer = &miningQueueId;

    status = mysql_stmt_bind_result(statement, bindResult);
    assert(status == 0);

    status = mysql_stmt_store_result(statement);
    assert(status == 0);

    bool result = false;

    while (mysql_stmt_fetch(statement) == 0)
    {
        result = true;
    }

    mysql_stmt_close(statement);
    
    return result;
}


void CDatabase::removeRallyResultEntry(int rallyResultId)
{
    MYSQL_STMT* statement = mysql_stmt_init(m_connection);
    assert(statement);

    string query("DELETE "
                 "FROM RallyResult "
                 "WHERE id = ? ");
    int status = mysql_stmt_prepare(statement, query.c_str(), query.size());
    assert(status == 0);

    MYSQL_BIND bind[1];
    memset(bind, 0, sizeof(bind));
    bind[0].buffer_type = MYSQL_TYPE_LONG;
    bind[0].buffer_length = sizeof(rallyResultId);
    bind[0].buffer = &rallyResultId;

    status = mysql_stmt_bind_param(statement, bind);
    assert(status == 0);

    status = mysql_stmt_execute(statement);
    assert(status == 0);

    mysql_stmt_close(statement);    
}


CDatabase::PoolData CDatabase::getPoolData(int poolId)
{
    PoolData result;
    result.poolId = poolId;
    
    MYSQL_STMT* statement = mysql_stmt_init(m_connection);
    assert(statement);

    string query("SELECT Pool.miningAreaId, Pool.requiredRuns "
                 "FROM Pool "
                 "WHERE Pool.id = ? ");
    int status = mysql_stmt_prepare(statement, query.c_str(), query.size());
    assert(status == 0);

    MYSQL_BIND bind[1];
    memset(bind, 0, sizeof(bind));
    bind[0].buffer_type = MYSQL_TYPE_LONG;
    bind[0].buffer_length = sizeof(poolId);
    bind[0].buffer = &poolId;

    status = mysql_stmt_bind_param(statement, bind);
    assert(status == 0);

    status = mysql_stmt_execute(statement);
    assert(status == 0);

    MYSQL_BIND bindResult[2];
    memset(bindResult, 0, sizeof(bindResult));

    bindResult[0].buffer_type = MYSQL_TYPE_LONG;
    bindResult[0].buffer_length = sizeof(result.miningAreaId);
    bindResult[0].buffer = &result.miningAreaId;
    
    bindResult[1].buffer_type = MYSQL_TYPE_LONG;
    bindResult[1].buffer_length = sizeof(result.requiredRuns);
    bindResult[1].buffer = &result.requiredRuns;

    status = mysql_stmt_bind_result(statement, bindResult);
    assert(status == 0);

    status = mysql_stmt_store_result(statement);
    assert(status == 0);

    if (mysql_stmt_fetch(statement) != 0)
    {
        result.poolId = -1;
    }

    return result;
}


list<CDatabase::PoolRallyItem> CDatabase::getNextPoolRally(int poolId)
{
    list<PoolRallyItem> result;

    MYSQL_STMT* statement = mysql_stmt_init(m_connection);
    assert(statement);

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
    int status = mysql_stmt_prepare(statement, query.c_str(), query.size());
    assert(status == 0);

    MYSQL_BIND bind[1];
    memset(bind, 0, sizeof(bind));
    bind[0].buffer_type = MYSQL_TYPE_LONG;
    bind[0].buffer_length = sizeof(poolId);
    bind[0].buffer = &poolId;

    status = mysql_stmt_bind_param(statement, bind);
    assert(status == 0);

    status = mysql_stmt_execute(statement);
    assert(status == 0);
    
    PoolRallyItem item;
    char sourceCode[cMaxSourceCodeLength];
    unsigned long length = 0;
    my_bool isNull;
    my_bool isError;

    MYSQL_BIND bindResult[11];
    memset(bindResult, 0, sizeof(bindResult));
    
    bindResult[0].buffer_type = MYSQL_TYPE_LONG;
    bindResult[0].buffer_length = sizeof(item.poolItemId);
    bindResult[0].buffer = &item.poolItemId;

    bindResult[1].buffer_type = MYSQL_TYPE_STRING;
    bindResult[1].buffer_length = sizeof(sourceCode);
    bindResult[1].buffer = sourceCode;
    bindResult[1].length = &length;
    bindResult[1].is_null = &isNull;
    bindResult[1].error = &isError;

    bindResult[2].buffer_type = MYSQL_TYPE_LONG;
    bindResult[2].buffer_length = sizeof(item.runsDone);
    bindResult[2].buffer = &item.runsDone;

    bindResult[3].buffer_type = MYSQL_TYPE_LONG;
    bindResult[3].buffer_length = sizeof(item.maxOre);
    bindResult[3].buffer = &item.maxOre;
    
    bindResult[4].buffer_type = MYSQL_TYPE_LONG;
    bindResult[4].buffer_length = sizeof(item.miningSpeed);
    bindResult[4].buffer = &item.miningSpeed;

    bindResult[5].buffer_type = MYSQL_TYPE_LONG;
    bindResult[5].buffer_length = sizeof(item.maxTurns);
    bindResult[5].buffer = &item.maxTurns;
    
    bindResult[6].buffer_type = MYSQL_TYPE_LONG;
    bindResult[6].buffer_length = sizeof(item.cpuSpeed);
    bindResult[6].buffer = &item.cpuSpeed;

    bindResult[7].buffer_type = MYSQL_TYPE_DOUBLE;
    bindResult[7].buffer_length = sizeof(item.forwardSpeed);
    bindResult[7].buffer = &item.forwardSpeed;

    bindResult[8].buffer_type = MYSQL_TYPE_DOUBLE;
    bindResult[8].buffer_length = sizeof(item.backwardSpeed);
    bindResult[8].buffer = &item.backwardSpeed;

    bindResult[9].buffer_type = MYSQL_TYPE_LONG;
    bindResult[9].buffer_length = sizeof(item.rotateSpeed);
    bindResult[9].buffer = &item.rotateSpeed;

    bindResult[10].buffer_type = MYSQL_TYPE_LONG;
    bindResult[10].buffer_length = sizeof(item.robotSize);
    bindResult[10].buffer = &item.robotSize;

    status = mysql_stmt_bind_result(statement, bindResult);
    assert(status == 0);
    
    status = mysql_stmt_store_result(statement);
    assert(status == 0);

    while (mysql_stmt_fetch(statement) == 0)
    {
        if (!isNull && !isError)
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
    }

    mysql_stmt_close(statement);

    return result;
}


void CDatabase::updatePoolItem(int poolItemId, double score)
{
    MYSQL_STMT* statement = mysql_stmt_init(m_connection);
    assert(statement);

    string query("UPDATE PoolItem "
                 "SET totalScore = totalScore + ?, runsDone = runsDone + 1 "
                 "WHERE id = ? ");
    int status = mysql_stmt_prepare(statement, query.c_str(), query.size());
    assert(status == 0);

    MYSQL_BIND bind[2];
    memset(bind, 0, sizeof(bind));
    bind[0].buffer_type = MYSQL_TYPE_DOUBLE;
    bind[0].buffer_length = sizeof(score);
    bind[0].buffer = &score;

    bind[1].buffer_type = MYSQL_TYPE_LONG;
    bind[1].buffer_length = sizeof(poolItemId);
    bind[1].buffer = &poolItemId;

    status = mysql_stmt_bind_param(statement, bind);
    assert(status == 0);

    status = mysql_stmt_execute(statement);
    assert(status == 0);

    mysql_stmt_close(statement);
}


void CDatabase::updatePoolItemMiningTotals(int poolItemId, int oreId, int amount)
{
    MYSQL_STMT* statement = mysql_stmt_init(m_connection);
    assert(statement);

    string query("INSERT INTO PoolItemMiningTotals "
                 "(poolItemId, oreId, totalMined) "
                 "values "
                 "(?, ?, ?) "
                 "ON DUPLICATE KEY UPDATE "
                 "totalMined = totalMined + VALUES(totalMined) ");
    int status = mysql_stmt_prepare(statement, query.c_str(), query.size());
    assert(status == 0);

    MYSQL_BIND bind[3];
    memset(bind, 0, sizeof(bind));
    bind[0].buffer_type = MYSQL_TYPE_LONG;
    bind[0].buffer_length = sizeof(poolItemId);
    bind[0].buffer = &poolItemId;

    bind[1].buffer_type = MYSQL_TYPE_LONG;
    bind[1].buffer_length = sizeof(oreId);
    bind[1].buffer = &oreId;

    bind[2].buffer_type = MYSQL_TYPE_LONG;
    bind[2].buffer_length = sizeof(amount);
    bind[2].buffer = &amount;

    status = mysql_stmt_bind_param(statement, bind);
    assert(status == 0);

    status = mysql_stmt_execute(statement);
    assert(status == 0);

    mysql_stmt_close(statement);
}
