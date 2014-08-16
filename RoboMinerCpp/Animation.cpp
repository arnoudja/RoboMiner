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

#include "Animation.h"
#include "Position.h"
#include "Robot.h"
#include "Rally.h"

#include <cassert>

using namespace std;

CAnimation::CAnimation()
{
    m_robotSteps.reserve(10);
}


CAnimation::~CAnimation()
{
}


void CAnimation::addStep(unsigned int robotNr, const CRobot& robot)
{
    if (m_robotSteps.size() < (robotNr + 1))
    {
        assert(m_robotSteps.size() < m_robotSteps.capacity());
        m_robotSteps.resize(robotNr + 1);
    }

    CAnimationStep step(robot.getPosition(), robot.getOre(), robot.getTimeFraction());
    m_robotSteps[robotNr].push_back(step);
}


void CAnimation::addGroundChange(const CPosition& position, const CGroundChangeStep step)
{
    m_groundChanges[(int)position.getXPos()][(int)position.getYPos()].push_back(step);
}


string CAnimation::getAnimationData(const TRobots& robotList, const CGround& ground, const map<int, OreData>& oreData)
{
    m_output.clear();

    writeRobotsData(robotList);
    writeGroundData(ground);
    writeOreData(oreData);

    return m_output.str();
}


void CAnimation::writeRobotsData(const TRobots& robotList)
{
    m_output << "var myRobots = {"
        << "robot: [";

    for (unsigned int iRobot = 0; iRobot < m_robotSteps.size(); ++iRobot)
    {
        TAnimationStepList& stepList(m_robotSteps[iRobot]);
        CRobot& robot(*robotList[iRobot]);

        assert(!stepList.empty());

        if (iRobot != 0)
        {
            m_output << ",";
        }

        m_output << "{"
            << "robotnr:" << iRobot << ","
            << "x:" << stepList.begin()->getPosition().getXPos() << ","
            << "y:" << stepList.begin()->getPosition().getYPos() << ","
            << "o:" << stepList.begin()->getPosition().getOrientation() << ","
            << "A:" << stepList.begin()->getOre(0) << ","
            << "B:" << stepList.begin()->getOre(1) << ","
            << "C:" << stepList.begin()->getOre(2) << ","
            << "size:" << robot.getSize() << ","
            << "maxore:" << robot.getMaxOre() << ","
            << "color:" << getRobotColor(iRobot).c_str() << ","
            << "locations:[";

        bool first = true;
        double lastXPos = .0;
        double lastYPos = .0;
        int lastOrientation = 0;
        int lastOreA = 0;
        int lastOreB = 0;
        int lastOreC = 0;
        
        for (TAnimationStepList::iterator iter = stepList.begin(); iter != stepList.end(); ++iter)
        {
            if (iter != stepList.begin())
            {
                m_output << ",";
            }

            m_output << "{";
            
            if (first || iter->getPosition().getXPos() != lastXPos)
            {
                m_output << "x:" << iter->getPosition().getXPos() << ",";
                lastXPos = iter->getPosition().getXPos();
            }
            
            if (first || iter->getPosition().getYPos() != lastYPos)
            {
                m_output << "y:" << iter->getPosition().getYPos() << ",";
                lastYPos = iter->getPosition().getYPos();
            }
            
            if (first || iter->getPosition().getOrientation() != lastOrientation)
            {
                m_output << "o:" << iter->getPosition().getOrientation() << ",";
                lastOrientation = iter->getPosition().getOrientation() ;
            }
            
            if (first || iter->getOre(0) != lastOreA)
            {
                m_output << "A:" << iter->getOre(0) << ",";
                lastOreA = iter->getOre(0);
            }
            
            if (first || iter->getOre(1) != lastOreB)
            {
                m_output << "B:" << iter->getOre(1) << ",";
                lastOreB = iter->getOre(1);
            }
            
            if (first || iter->getOre(2) != lastOreC)
            {
                m_output << "C:" << iter->getOre(2) << ",";
                lastOreC = iter->getOre(2);
            }
            
            m_output << "t:" << iter->getTimeFraction() << "}";
            
            first = false;
        }

        m_output << "]}" << std::endl;
    }

    m_output << "]};" << std::endl;
}


void CAnimation::writeGroundData(const CGround& ground)
{
    m_output << "var myGround = {"
        << "sizeX:" << ground.getSizeX() << ","
        << "sizeY:" << ground.getSizeY() << ","
        << "positions:[";

    bool first(true);
    for (TGroundChanges::iterator iterRow = m_groundChanges.begin(); iterRow != m_groundChanges.end(); ++iterRow)
    {
        for (TGroundRowChanges::iterator iterPos = iterRow->second.begin(); iterPos != iterRow->second.end(); ++iterPos)
        {
            if (!first)
            {
                m_output << ",";
            }
            else
            {
                first = false;
            }

            m_output << "{x:" << iterRow->first << ","
                << "y:" << iterPos->first << ","
                << "changes:[";

            TGroundChangeStepList& changesList = iterPos->second;

            for (TGroundChangeStepList::iterator iterChanges = changesList.begin(); iterChanges != changesList.end(); ++iterChanges)
            {
                if (iterChanges != changesList.begin())
                {
                    m_output << ",";
                }

                m_output << "{t:" << iterChanges->getTime() << ","
                    << "A:" << iterChanges->getOre(0) << ","
                    << "B:" << iterChanges->getOre(1) << ","
                    << "C:" << iterChanges->getOre(2) << "}";
            }

            m_output << "]}" << std::endl;
        }
    }

    m_output << "]};" << std::endl;
}


void CAnimation::writeOreData(const map<int, OreData>& oreData)
{
    m_output << "var myOreTypes = {";

    for (map<int, OreData>::const_iterator iter = oreData.begin(); iter != oreData.end(); ++iter)
    {
        if (iter != oreData.begin())
        {
            m_output << ",";
        }

        m_output << (char)('A' + iter->first) << ":";
        m_output << "{id:" << iter->second.id << ",max:" << iter->second.maxAmount << "}";
    }
    
    m_output << "};" << std::endl;
}


string CAnimation::getRobotColor(int iRobot)
{
    string result;

    switch (iRobot)
    {
    case 0:
        result = "'green'";
        break;

    case 1:
        result = "'blue'";
        break;

    case 2:
        result = "'red'";
        break;

    case 3:
        result = "'yellow'";
        break;

    default:
        assert(false);
        break;
    }

    return result;
}
