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

#include "Ground.h"
#include "Robot.h"
#include "Animation.h"
#include "Database.h"

#include <string>
#include <list>
#include <map>

class CRally
{
public:
    CRally(const CDatabase::MiningArea& miningArea);
    virtual ~CRally()                                   {}

    void addRobot(CRobot& robot);

    void start();
    const std::string& getAnimationData() const         { return m_animationData; }

    int getOreId(int oreNumber)                         { return m_oreData[oreNumber].id; }
    
protected:
    void addOreHeap(int oreId, int amount, int radius);
    void initRobotPositions();
    void initGround();

    void processStep();
    void processRobotMove(CRobot& robot);

    void processMove(CRobot& robot, double speed, double timefraction);
    void processMine(CRobot& robot);
    void applyMining(CRobot& robot);
    void processDump(CRobot& robot, int oreType);

    void checkWallCollision(CRobot& robot);
    void checkCollisions();

    double findCollisionTime(CRobot& robot1, CRobot& robot2, double minCollisionTime, double maxCollisionTime);
    CPosition positionAtTime(const CPosition& startPosition, const CPosition& endPosition, double travelTime, double time);

private:
    CGround     m_ground;
    TRobots     m_robots;

    int         m_totalMoves;
    int         m_time;

    CAnimation  m_animation;
    std::string m_animationData;
    
    std::map<int, CAnimation::OreData>  m_oreData;
};
