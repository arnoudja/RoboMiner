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

#include <ctime>
#include <iostream>


using namespace std;
using namespace robotcode;


void verifyCode(int id)
{
    CDatabase database;

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
        srand((unsigned int)time(NULL));
        
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
            robots[iRobot] = new CRobotProgram(iter->sourceCode, iter->maxTurns, iter->maxOre,
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
                robots[iRobot] = new CRobotProgram(aiRobotData.sourceCode, aiRobotData.maxTurns, aiRobotData.maxOre,
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
                        database.addMiningOreResult(miningQueueIds[iRobot], rally.getOreId(iOre), robots[iRobot]->getOre()[iOre]);
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


int main(int argc, char* argv[])
{
    string command(argc > 1 ? argv[1] : "");
    
    if (command.compare("verify") == 0)
    {
        if (argc > 2)
        {
            verifyCode(atol(argv[2]));
        }
    }
    else
    {
        CDatabase database;

        list<CDatabase::MiningArea> miningAreas = database.getMiningAreas();
        
        while (true)
        {
            if (!processMiningQueues(database, miningAreas))
            {
                sleep(5);
            }
        }
    }

    return 0;
}
