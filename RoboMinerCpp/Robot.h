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

#include "Position.h"
#include "GroundUnit.h"

#include <vector>
#include <map>

class CRobot;

typedef std::vector<CRobot*>  TRobots;

class CRobot
{
public:
    enum EAction
    {
        eUndefined   = 0,
        eWait        = 1,
        eForward     = 2,
        eBackward    = 3,
        eRotateRight = 4,
        eRotateLeft  = 5,
        eMine        = 6,
        eDump        = 7
    };

    struct RobotAction
    {
        EAction action;
        int     parameter;
    };

public:
    CRobot(int robotId, int maxTurns, int maxOre,
           int miningSpeed, int cpuSpeed,
           double forwardSpeed, double backwardSpeed, int rotateSpeed,
           double robotSize);
    virtual ~CRobot()                                           {}

    RobotAction getNextRobotAction();

    void prepareForAction(int currentStep, int maxSteps);
    void applyRotation();

    int getRobotId() const                                      { return m_robotId; }

    int getTimeLeft() const                                     { return m_timeLeft; }
    void setTimeLeft(int timeLeft)                              { m_timeLeft = timeLeft; }
    
    CPosition& getPosition()                                    { return m_position; }
    const CPosition& getPosition() const                        { return m_position; }
    CPosition getCenterPosition() const;
    void setPosition(const CPosition& position)                 { m_position = position; }

    int getOre(int type) const                                  { return m_ore[type]; }
    const CGroundUnit::TOreAmount& getOre() const               { return m_ore; }
    int getTotalOre() const;
    int getLastMined() const                                    { return m_lastMined; }
    void addOre(int type, int amount);
    void clearOre(int type)                                     { m_ore[type] = 0; }

    CPosition& getDestination()                                 { return m_destination; }
    const CPosition& getDestination() const                     { return m_destination; }
    void setDestination(const CPosition& destination)           { m_destination = destination; }

    double getTimeFraction() const                              { return m_timeFraction; }
    void setTimeFraction(double timeFraction)                   { m_timeFraction = timeFraction; }
    void adjustTimeFraction(double adjustment)                  { m_timeFraction *= adjustment; }

    double getCurrentSpeed() const                              { return m_currentSpeed; }
    void setCurrentSpeed(double speed)                          { m_currentSpeed = speed; }

    double getSize() const                                      { return m_size; }
    void setSize(double size)                                   { m_size = size; }

    double getForwardSpeed() const                              { return m_forwardSpeed; }
    void setForwardSpeed(double speed)                          { m_forwardSpeed = speed; }

    double getBackwardSpeed() const                             { return m_backwardSpeed; }
    void setBackwardSpeed(double speed)                         { m_backwardSpeed = speed; }

    int getRotateSpeed() const                                  { return m_rotateSpeed; }
    void setRotateSpeed(int speed)                              { m_rotateSpeed = speed; }

    int getTargetRotation() const                               { return m_targetRotation; }
    void setTargetRotation(int angle)                           { m_targetRotation = angle; }

    const CGroundUnit::TOreAmount& getTargetMining() const      { return m_targetMining; }
    int getMiningAmount(int type) const                         { return (int)(m_targetMining[type] * m_timeFraction); }
    void setTargetMining(const CGroundUnit& groundUnit);

    int getMaxTurns() const                                     { return m_maxTurns; }
    int getCpuSpeed() const                                     { return m_cpuSpeed; }
    int getMaxOre() const                                       { return m_maxOre; }
    
    double getMinXPos() const                                   { return m_minXPos; }
    double getMinYPos() const                                   { return m_minYPos; }
    double getMaxXPos() const                                   { return m_maxXPos; }
    double getMaxYPos() const                                   { return m_maxYPos; }

    void setMinXPos(double min)                                 { m_minXPos = min; }
    void setMinYPos(double min)                                 { m_minYPos = min; }
    void setMaxXPos(double max)                                 { m_maxXPos = max; }
    void setMaxYPos(double max)                                 { m_maxYPos = max; }

    const std::map<EAction, int>& getActionsDone() const        { return m_actionsDone; }

    double calculateScore() const;

protected:
    virtual RobotAction getNextAction() = 0;

private:
    void increaseActionsDone(EAction action)                    { ++(m_actionsDone[action]); }

private:
    int                     m_robotId;
    int                     m_timeLeft;
    CPosition               m_position;
    CGroundUnit::TOreAmount m_ore;
    int                     m_maxTurns;
    int                     m_maxOre;
    int                     m_lastMined;

    CPosition               m_destination;
    double                  m_timeFraction;
    double                  m_currentSpeed;
    int                     m_targetRotation;
    CGroundUnit::TOreAmount m_targetMining;

    std::map<EAction, int>  m_actionsDone;

    double      m_size;
    int         m_miningSpeed;
    double      m_forwardSpeed;
    double      m_backwardSpeed;
    int         m_rotateSpeed;
    int         m_cpuSpeed;

    double      m_minXPos;
    double      m_minYPos;
    double      m_maxXPos;
    double      m_maxYPos;
};
