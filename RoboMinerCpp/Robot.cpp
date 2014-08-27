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

CRobot::CRobot(int maxTurns, int maxOre,
               int miningSpeed, int cpuSpeed,
               double forwardSpeed, double backwardSpeed, int rotateSpeed,
               int robotSize) :
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
    m_ore.resize(10);
    m_targetMining.resize(10);
    for (int i = 0; i < 10; ++i)
    {
        m_ore[i]          = 0;
        m_targetMining[i] = 0;
    }
}


CRobot::~CRobot()
{
}


void CRobot::prepareForAction()
{
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

    int freeSpace = m_maxOre - getTotalOre();
    
    for (int i = 0; i < 10; ++i)
    {
        int target = std::min(m_miningSpeed, std::min(freeSpace, (groundUnit.getOre(i) + 9) / 10));

        m_targetMining[i] = target;
        freeSpace -= target;
    }
}