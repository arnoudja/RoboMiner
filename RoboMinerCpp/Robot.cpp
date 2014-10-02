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
#include "Robot.h"

#include <algorithm>
#include <cassert>


static const int MAX_ORE_TYPES = 10;


CRobot::CRobot(int robotId, int maxTurns, int maxOre,
               int miningSpeed, int cpuSpeed,
               double forwardSpeed, double backwardSpeed, int rotateSpeed,
               double robotSize) :
    m_robotId(robotId),
    m_maxTurns(maxTurns),
    m_maxOre(maxOre),
    m_lastMined(0),
    m_timeFraction(.0),
    m_currentSpeed(.0),
    m_targetRotation(0),
    m_size(robotSize),
    m_miningSpeed(miningSpeed),
    m_forwardSpeed(forwardSpeed),
    m_backwardSpeed(backwardSpeed),
    m_rotateSpeed(rotateSpeed),
    m_cpuSpeed(cpuSpeed),
    m_minXPos(.0),
    m_minYPos(.0),
    m_maxXPos(.0),
    m_maxYPos(.0)
{
    m_ore.resize(MAX_ORE_TYPES);
    m_targetMining.resize(MAX_ORE_TYPES);
    for (int i = 0; i < MAX_ORE_TYPES; ++i)
    {
        m_ore[i]          = 0;
        m_targetMining[i] = 0;
    }

    for (int action = eUndefined; action <= eDump; ++action)
    {
        m_actionsDone[(EAction)action] = 0;
    }
}


CRobot::RobotAction CRobot::getNextRobotAction()
{
    RobotAction result = getNextAction();

    ++(m_actionsDone[result.action]);

    return result;
}


void CRobot::prepareForAction(int currentStep, int maxSteps)
{
    setTimeLeft(std::min(getMaxTurns(), maxSteps) - currentStep);
    setDestination(getPosition());
    setTimeFraction(1.);
    setCurrentSpeed(.0);
    setTargetRotation(0);

    for (int i = 0; i < 10; ++i)
    {
        m_targetMining[i] = 0;
    }
}


void CRobot::applyRotation()
{
    int angle = (int)(m_timeFraction * m_targetRotation);
    m_position.rotate(angle);
}


int CRobot::getTotalOre() const
{
    int amount = 0;
    
    for (CGroundUnit::TOreAmount::const_iterator iter = m_ore.begin(); iter != m_ore.end(); ++iter)
    {
        amount += *iter;
    }
    
    return amount;
}


void CRobot::addOre(int type, int amount)
{
    m_ore[type] += amount;
    m_lastMined += amount;
}


CPosition CRobot::getCenterPosition() const
{
    return CPosition(m_position.getXPos() + m_size / 2, m_position.getYPos() + m_size / 2);
}


void CRobot::setTargetMining(const CGroundUnit& groundUnit)
{
    m_lastMined = 0;

    int totalAllowed = std::min(m_miningSpeed, m_maxOre - getTotalOre());

    int oreTypes = groundUnit.nrOreTypes();
    for (int i = 0; i < 10; ++i)
    {
        if (groundUnit.getOre(i) > 0)
        {
            int maxAllowed = std::min(totalAllowed, ((totalAllowed - 1) / oreTypes) + 1);
            int available = (groundUnit.getOre(i) - 1) / 2 + 1;

            m_targetMining[i] = std::min(available, maxAllowed);
            totalAllowed -= m_targetMining[i];
            --oreTypes;
        }
    }
}


double CRobot::calculateScore() const
{
    double score  = .0;
    double factor = 1.;

    for (int i = 0; i < MAX_ORE_TYPES; ++i)
    {
        score += factor * m_ore[i];
        factor *= 10.;
    }
    
    return score * 10. / (m_maxOre + 5.);
}
