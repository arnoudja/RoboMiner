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

#pragma once

#include <mysql.h>

#include <string>
#include <list>

class CDatabase
{
public:
    struct MiningAreaOreSupply
    {
        int oreId;
        int amount;
        int radius;
    };
    
    struct MiningArea
    {
        int miningAreaId;
        int sizeX;
        int sizeY;
        int maxMoves;
        int miningTime;
        int taxRate;
        int aiRobotId;
        std::list<MiningAreaOreSupply> oreSupply;
    };
    
    struct RobotData
    {
        int     usersId;
        int     robotId;
        int     maxOre;
        int     miningSpeed;
        int     maxTurns;
        int     cpuSpeed;
        double  forwardSpeed;
        double  backwardSpeed;
        int     rotateSpeed;
        double  robotSize;
        std::string sourceCode;
    };

    struct MiningRallyItem
    {
        int         miningQueueId;
        int         usersId;
        int         robotId;
        int         maxOre;
        int         miningSpeed;
        int         maxTurns;
        int         cpuSpeed;
        double      forwardSpeed;
        double      backwardSpeed;
        int         rotateSpeed;
        double      robotSize;
        MYSQL_TIME  miningEndTime;
        int         secondsLeft;
        std::string sourceCode;
    };

    struct OldMiningQueueItem
    {
        int miningQueueId;
        int rallyResultId;
    };

    struct PoolData
    {
        int poolId;
        int miningAreaId;
        int requiredRuns;
    };

    struct PoolRallyItem
    {
        int         poolItemId;
        int         runsDone;
        int         maxOre;
        int         miningSpeed;
        int         maxTurns;
        int         cpuSpeed;
        double      forwardSpeed;
        double      backwardSpeed;
        int         rotateSpeed;
        double      robotSize;
        std::string sourceCode;
    };

public:
    CDatabase();
    ~CDatabase();

    std::string getSource(int id);
    void updateError(int id, const std::string& errorDescription);
    void setValidSource(int id, int compiledSize);

    MiningArea getMiningArea(int miningAreaId);
    std::list<MiningArea> getMiningAreas();
    std::list<MiningAreaOreSupply> getMiningAreaOreSupply(int miningAreaId);
    RobotData getRobotData(int robotId);

    std::list<MiningRallyItem> getNextMiningRally(int miningAreaId);
    int addAnimation(const std::string& animation);
    void updateMiningRally(const std::list<MiningRallyItem>& miningRallyItems, int rallyResultId);
    void updateMiningQueue(int miningQueueId, int playerNumber, int rallyResultId, MYSQL_TIME miningEndTime);
    void addMiningOreResult(int miningQueueId, int oreId, int amount);
    void addRobotActionsDone(int miningQueueId, int actionType, int amount);
    void updateRobot(int robotId, MYSQL_TIME miningEndTime);
    void updateRobotScore(int robotId, int miningAreaId, double score);

    void removeOldMiningQueueItems(int robotId);
    std::list<OldMiningQueueItem> findOldMiningQueueItems(int robotId);
    void removeMiningQueueEntry(int miningQueueId);
    bool rallyResultInUse(int rallyResultId);
    void removeRallyResultEntry(int rallyResultId);

    PoolData getPoolData(int poolId);
    std::list<PoolRallyItem> getNextPoolRally(int poolId);
    void updatePoolItem(int poolItemId, double score);
    void updatePoolItemMiningTotals(int poolItemId, int oreId, int amount);

private:
    void removeMiningOreResultEntries(int miningQueueId);
    void removeRobotActionsDoneEntries(int miningQueueId);

    bool getRobotScoreDatabaseValue(int robotId, int miningAreaId, int& totalRuns, double& score);
    void insertRobotScoreDatabaseValue(int robotId, int miningAreaId, double score);
    void updateRobotScoreDatabaseValue(int robotId, int miningAreaId, double score);

private:
    MYSQL   m_mysql;
    MYSQL*  m_connection;
};
