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

// RoboMine.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"

#include "Rally.h"
#include "robotcode/RobotProgram.h"
#include "robotcode/CompileInput.h"
#include "robotcode/ProgramItem.h"
#include "Database.h"
#include "ConfigFile.h"

#include <ctime>
#include <iostream>


using namespace std;
using namespace robotcode;


void verifyCode(CDatabase& database, int id)
{
    try
    {
        bool terminated;
        CCompileInput source(database.getSource(id));

        CProgramItem* program = CProgramItem::compile(source, terminated);

        database.setValidSource(id, program->size());

        delete program;
    }
    catch (string error)
    {
        database.updateError(id, error);
    }
}


bool processMiningQueue(CDatabase& database, const CDatabase::MiningArea& miningArea)
{
    list<CDatabase::MiningRallyItem> miningRallyItems;

    miningRallyItems = database.getNextMiningRally(miningArea.miningAreaId);

    if (miningRallyItems.size() > 4)
    {
        list<CDatabase::MiningRallyItem>::iterator iter = miningRallyItems.begin();
        for (int i = 0; i < 4; ++i)
        {
            ++iter;
        }

        miningRallyItems.erase(iter, miningRallyItems.end());
    }

    bool result = false;

    if (!miningRallyItems.empty() &&
        (miningRallyItems.size() >= 4 || miningRallyItems.front().secondsLeft < 10))
    {
        CRally rally(miningArea);

        CRobotProgram* robots[4];
        int miningQueueIds[4];
        
        time_t now = time(NULL);
        cout << ctime(&now) << " Staring rally in area " << miningArea.miningAreaId << " for users: ";
        
        int iRobot = 0;
        for (list<CDatabase::MiningRallyItem>::const_iterator iter = miningRallyItems.begin(); iter != miningRallyItems.end() && iRobot < 4; ++iter, ++iRobot)
        {
            if (iRobot > 0)
            {
                cout << ", ";
            }
            cout << iter->usersId;
            robots[iRobot] = new CRobotProgram(iter->robotId, iter->sourceCode, iter->maxTurns, iter->maxOre,
                                               iter->miningSpeed, iter->cpuSpeed,
                                               iter->forwardSpeed, iter->backwardSpeed, iter->rotateSpeed,
                                               iter->robotSize);
            miningQueueIds[iRobot] = iter->miningQueueId;

            rally.addRobot(*robots[iRobot]);
        }

        cout << std::endl;
        
        if (iRobot < 4)
        {
            // Add AI robots
            CDatabase::RobotData aiRobotData = database.getRobotData(miningArea.aiRobotId);

            for (; iRobot < 4; ++iRobot)
            {
                robots[iRobot] = new CRobotProgram(-1,
                                                   aiRobotData.sourceCode, aiRobotData.maxTurns, aiRobotData.maxOre,
                                                   aiRobotData.miningSpeed, aiRobotData.cpuSpeed,
                                                   aiRobotData.forwardSpeed, aiRobotData.backwardSpeed, aiRobotData.rotateSpeed,
                                                   aiRobotData.robotSize);
                miningQueueIds[iRobot] = 0;

                rally.addRobot(*robots[iRobot]);
            }
        }

        rally.start();
        
        int rallyResultId = database.addAnimation(rally.getAnimationData());

        database.updateMiningRally(miningRallyItems, rallyResultId);

        for (iRobot = 0; iRobot < 4; ++iRobot)
        {
            if (miningQueueIds[iRobot] > 0)
            {
                for (unsigned int iOre = 0; iOre < robots[iRobot]->getOre().size(); ++iOre)
                {
                    if (robots[iRobot]->getOre()[iOre] > 0)
                    {
                        database.updateRobotScore(robots[iRobot]->getRobotId(), miningQueueIds[iRobot], miningArea.miningAreaId, robots[iRobot]->calculateScore());
                        database.addMiningOreResult(miningQueueIds[iRobot], rally.getOreId(iOre), robots[iRobot]->getOre()[iOre]);
                    }
                }

                const map<CRobot::EAction, int>& actionsDoneMap = robots[iRobot]->getActionsDone();
                for (map<CRobot::EAction, int>::const_iterator iter = actionsDoneMap.begin(); iter != actionsDoneMap.end(); ++iter)
                {
                    if (iter->second > 0)
                    {
                        database.addRobotActionsDone(miningQueueIds[iRobot], iter->first, iter->second);
                    }
                }
            }

            delete robots[iRobot];
        }

        result = true;
        
        now = time(NULL);
        cout << ctime(&now) << " Finished rally " << rallyResultId << std::endl;
    }
    
    return result;
}


bool processMiningQueues(CDatabase& database, const list<CDatabase::MiningArea>& miningAreas)
{
    bool result = false;

    for (list<CDatabase::MiningArea>::const_iterator iter = miningAreas.begin(); iter != miningAreas.end(); ++iter)
    {
        if (processMiningQueue(database, *iter))
        {
            result = true;
        }
    }
    
    return result;
}


void runRallies(CDatabase& database)
{
    list<CDatabase::MiningArea> miningAreas = database.getMiningAreas();

    while (true)
    {
        if (!processMiningQueues(database, miningAreas))
        {
            sleep(5);
        }
    }
}


void runPoolRally(CDatabase& database,
                  const list<CDatabase::PoolRallyItem>& poolRallyItemList,
                  const CDatabase::MiningArea& miningArea)
{
    CRally rally(miningArea);

    CRobotProgram* robots[4];

    int iRobot = 0;
    for (list<CDatabase::PoolRallyItem>::const_iterator iter = poolRallyItemList.begin(); iter != poolRallyItemList.end(); ++iter, ++iRobot)
    {
        robots[iRobot] = new CRobotProgram(-1,
                                           iter->sourceCode, iter->maxTurns, iter->maxOre,
                                           iter->miningSpeed, iter->cpuSpeed,
                                           iter->forwardSpeed, iter->backwardSpeed, iter->rotateSpeed,
                                           iter->robotSize);

        rally.addRobot(*robots[iRobot]);
    }

    if (iRobot < 4)
    {
        // Add AI robots
        CDatabase::RobotData aiRobotData = database.getRobotData(miningArea.aiRobotId);

        for (; iRobot < 4; ++iRobot)
        {
            robots[iRobot] = new CRobotProgram(-1,
                                               aiRobotData.sourceCode, aiRobotData.maxTurns, aiRobotData.maxOre,
                                               aiRobotData.miningSpeed, aiRobotData.cpuSpeed,
                                               aiRobotData.forwardSpeed, aiRobotData.backwardSpeed, aiRobotData.rotateSpeed,
                                               aiRobotData.robotSize);

            rally.addRobot(*robots[iRobot]);
        }
    }

    rally.start();

    list<CDatabase::PoolRallyItem>::const_iterator iter = poolRallyItemList.begin();
    for (iRobot = 0; iRobot < 4; ++iRobot)
    {
        if (iter != poolRallyItemList.end())
        {
            for (unsigned int iOre = 0; iOre < robots[iRobot]->getOre().size(); ++iOre)
            {
                if (robots[iRobot]->getOre()[iOre] > 0)
                {
                    database.updatePoolItemMiningTotals(iter->poolItemId, rally.getOreId(iOre), robots[iRobot]->getOre()[iOre]);
                }
            }

            database.updatePoolItem(iter->poolItemId, robots[iRobot]->calculateScore());

            ++iter;
        }

        delete robots[iRobot];
    }
}


void runPool(CDatabase& database, int poolId)
{
    CDatabase::PoolData poolData = database.getPoolData(poolId);

    if (poolData.poolId == poolId)
    {
        time_t now = time(NULL);
        cout << ctime(&now) << " Staring pool rallies in area " << poolData.miningAreaId << std::endl;;

        CDatabase::MiningArea miningArea = database.getMiningArea(poolData.miningAreaId);

        bool ready = false;

        int ralliesDone = 0;

        do
        {
            list<CDatabase::PoolRallyItem> poolRallyItemList = database.getNextPoolRally(poolId);

            if (!poolRallyItemList.empty() && poolRallyItemList.front().runsDone < poolData.requiredRuns)
            {
                if (ralliesDone % 100 == 0)
                {
                    now = time(NULL);
                    cout << ctime(&now) << " Progress: "
                                        << poolRallyItemList.front().runsDone << " / " << poolData.requiredRuns
                                        << std::endl;
                }

                runPoolRally(database, poolRallyItemList, miningArea);
                ++ralliesDone;
            }
            else
            {
                ready = true;
            }
        }
        while (!ready);

        now = time(NULL);
        cout << ctime(&now) << " Finished pool, rallies done: " << ralliesDone << std::endl;
    }
}


int main(int argc, char* argv[])
{
    CConfigFile configFile(argc, argv);

    CDatabase database(configFile);

    srand((unsigned int)time(NULL));

    string command(argc > 1 ? argv[1] : "");
    
    if (command.compare("verify") == 0)
    {
        if (argc > 2)
        {
            verifyCode(database, atol(argv[2]));
        }
    }
    else if (command.compare("runpool") == 0)
    {
        if (argc > 2)
        {
            runPool(database, atoi(argv[2]));
        }
    }
    else
    {
        runRallies(database);
    }

    return 0;
}
