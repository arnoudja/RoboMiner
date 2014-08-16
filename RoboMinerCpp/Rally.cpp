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
#include "Rally.h"
#include "Robot.h"
#include "Animation.h"
#include "GroundUnit.h"

#include <algorithm>
#include <cassert>

using namespace std;


CRally::CRally(const CDatabase::MiningArea& miningArea) :
m_ground(miningArea.sizeX, miningArea.sizeY),
m_totalMoves(miningArea.maxMoves),
m_time(0)
{
    m_robots.reserve(10);
    
    std::list<CDatabase::MiningAreaOreSupply>::const_iterator iter;
    for (iter = miningArea.oreSupply.begin(); iter != miningArea.oreSupply.end(); ++iter)
    {
        addOreHeap(iter->oreId, iter->amount, iter->radius);
    }
}


CRally::~CRally()
{
}


void CRally::addRobot(CRobot& robot)
{
    assert(m_robots.size() < m_robots.capacity());
    m_robots.push_back(&robot);
}


void CRally::start()
{
    int maxRobotTurns = 0;
    for (unsigned int i = 0; i < m_robots.size(); ++i)
    {
        maxRobotTurns = std::max(maxRobotTurns, m_robots[i]->getMaxTurns());
    }
    
    if (m_totalMoves > maxRobotTurns)
    {
        m_totalMoves = maxRobotTurns;
    }
    
    initGround();
    initRobotPositions();

    for (m_time = 0; m_time < m_totalMoves; ++m_time)
    {
        processStep();
    }

    m_animationData = m_animation.getAnimationData(m_robots, m_ground, m_oreNumberToId);
}


void CRally::addOreHeap(int oreId, int amount, int radius)
{
    int number = -1;
    
    for (map<int, int>::const_iterator iter = m_oreNumberToId.begin(); iter != m_oreNumberToId.end(); ++iter)
    {
        if (iter->second == oreId)
        {
            number = iter->first;
        }
    }
    
    if (number < 0)
    {
        number = m_oreNumberToId.size();
        m_oreNumberToId[number] = oreId;
    }
    
    m_ground.addOreHeap(m_ground.getSizeX() / 4 + rand() % (m_ground.getSizeX() / 2),
                    m_ground.getSizeY() / 4 + rand() % (m_ground.getSizeY() / 2),
                    number, amount, radius);
}


void CRally::initRobotPositions()
{
    assert(m_robots.size() <= 4);

    if (m_robots.size() >= 1)
    {
        CRobot* robot = m_robots[0];

        robot->setSize(1.5);
        robot->setMinXPos(robot->getSize() / 2 - .5);
        robot->setMinYPos(robot->getSize() / 2 - .5);
        robot->setMaxXPos(m_ground.getSizeX() - robot->getSize() / 2 - .5);
        robot->setMaxYPos(m_ground.getSizeY() - robot->getSize() / 2 - .5);

        robot->getPosition().setPosition(robot->getMinXPos(), robot->getMinYPos());
        robot->getPosition().setOrientation(45);
    }

    if (m_robots.size() >= 2)
    {
        CRobot* robot = m_robots[1];

        robot->setSize(1.5);
        robot->setMinXPos(robot->getSize() / 2 - .5);
        robot->setMinYPos(robot->getSize() / 2 - .5);
        robot->setMaxXPos(m_ground.getSizeX() - robot->getSize() / 2 - .5);
        robot->setMaxYPos(m_ground.getSizeY() - robot->getSize() / 2 - .5);

        robot->getPosition().setPosition(robot->getMinXPos(), robot->getMaxYPos());
        robot->getPosition().setOrientation(135);
    }

    if (m_robots.size() >= 3)
    {
        CRobot* robot = m_robots[2];

        robot->setSize(1.5);
        robot->setMinXPos(robot->getSize() / 2 - .5);
        robot->setMinYPos(robot->getSize() / 2 - .5);
        robot->setMaxXPos(m_ground.getSizeX() - robot->getSize() / 2 - .5);
        robot->setMaxYPos(m_ground.getSizeY() - robot->getSize() / 2 - .5);

        robot->getPosition().setPosition(robot->getMaxXPos(), robot->getMinYPos());
        robot->getPosition().setOrientation(315);
    }

    if (m_robots.size() >= 4)
    {
        CRobot* robot = m_robots[3];

        robot->setSize(1.5);
        robot->setMinXPos(robot->getSize() / 2 - .5);
        robot->setMinYPos(robot->getSize() / 2 - .5);
        robot->setMaxXPos(m_ground.getSizeX() - robot->getSize() / 2 - .5);
        robot->setMaxYPos(m_ground.getSizeY() - robot->getSize() / 2 - .5);

        robot->getPosition().setPosition(robot->getMaxXPos(), robot->getMaxYPos());
        robot->getPosition().setOrientation(225);
    }
}


void CRally::initGround()
{
    for (int x = 0; x < m_ground.getSizeX(); ++x)
    {
        for (int y = 0; y < m_ground.getSizeY(); ++y)
        {
            CPosition position(x, y);
            CGroundUnit& groundUnit = m_ground.getAt(position);

            if (groundUnit.hasOre())
            {
                m_animation.addGroundChange(CPosition(x, y), CGroundChangeStep(m_time, groundUnit.getOre()));
            }
        }
    }
}


void CRally::processStep()
{
    for (unsigned int i = 0; i < m_robots.size(); ++i)
    {
        m_robots[i]->prepareForAction();
    }

    if (m_time > 0)
    {
        for (unsigned int i = 0; i < m_robots.size(); ++i)
        {
            if (m_robots[i]->getMaxTurns() > m_time)
            {
                processRobotMove(*m_robots[i]);
            }
        }

        checkCollisions();
    }

    for (unsigned int i = 0; i < m_robots.size(); ++i)
    {
        CRobot& robot = *m_robots[i];
        robot.setPosition(robot.getDestination());
        robot.applyRotation();
        applyMining(robot);

        m_animation.addStep(i, robot);
    }
}


void CRally::processRobotMove(CRobot& robot)
{
    CRobot::EAction action = robot.getNextAction();

    switch (action)
    {
    case CRobot::eForward:
        processMove(robot, robot.getForwardSpeed(), robot.getTimeFraction());
        break;

    case CRobot::eBackward:
        processMove(robot, -robot.getBackwardSpeed(), robot.getTimeFraction());
        break;

    case CRobot::eRotateLeft:
        robot.setTargetRotation(-robot.getRotateSpeed() * robot.getTimeFraction());
        break;

    case CRobot::eRotateRight:
        robot.setTargetRotation(robot.getRotateSpeed() * robot.getTimeFraction());
        break;

    case CRobot::eMine:
        processMine(robot);
        break;

    default:
        break;
    }

    checkWallCollision(robot);
}


void CRally::processMove(CRobot& robot, double speed, double timefraction)
{
    robot.setDestination(robot.getPosition().calculateMovePosition(speed * timefraction));
    robot.setTimeFraction(timefraction);
    robot.setCurrentSpeed(speed);
}


void CRally::checkWallCollision(CRobot& robot)
{
    const CPosition oldPosition = robot.getPosition();
    CPosition newPosition = robot.getDestination();

    if (newPosition.getXPos() < robot.getMinXPos())
    {
        if (oldPosition.getXPos() <= robot.getMinXPos())
        {
            newPosition = oldPosition;
        }
        else
        {
            double targetDeltaX = oldPosition.getXPos() - newPosition.getXPos();
            double realDeltaX = oldPosition.getXPos() - robot.getMinXPos();
            
            if (targetDeltaX > .01)
            {
                double relative = realDeltaX / targetDeltaX;
                assert(relative <= 1.);

                double targetDeltaY = newPosition.getYPos() - oldPosition.getYPos();
                double realDeltaY = relative * targetDeltaY;

                newPosition.setYPos(oldPosition.getYPos() + realDeltaY);
            }

            newPosition.setXPos(robot.getMinXPos());
        }
    }
    else if (newPosition.getXPos() > robot.getMaxXPos())
    {
        if (oldPosition.getXPos() >= robot.getMaxXPos())
        {
            newPosition = oldPosition;
        }
        else
        {
            double targetDeltaX = newPosition.getXPos() - oldPosition.getXPos();
            double realDeltaX = robot.getMaxXPos() - oldPosition.getXPos();

            if (targetDeltaX > .01)
            {
                double relative = realDeltaX / targetDeltaX;
                assert(relative <= 1.);

                double targetDeltaY = newPosition.getYPos() - oldPosition.getYPos();
                double realDeltaY = relative * targetDeltaY;

                newPosition.setYPos(oldPosition.getYPos() + realDeltaY);
            }

            newPosition.setXPos(robot.getMaxXPos());
        }
    }

    if (newPosition.getYPos() < robot.getMinYPos())
    {
        if (oldPosition.getYPos() <= robot.getMinYPos())
        {
            newPosition = oldPosition;
        }
        else
        {
            double targetDeltaY = oldPosition.getYPos() - newPosition.getYPos();
            double realDeltaY = oldPosition.getYPos() - robot.getMinYPos();

            if (targetDeltaY > .01)
            {
                double relative = realDeltaY / targetDeltaY;
                assert(relative <= 1.);

                double targetDeltaX = newPosition.getXPos() - oldPosition.getXPos();
                double realDeltaX = relative * targetDeltaX;

                newPosition.setXPos(oldPosition.getXPos() + realDeltaX);
            }

            newPosition.setYPos(robot.getMinYPos());
        }
    }
    else if (newPosition.getYPos() > robot.getMaxYPos())
    {
        if (oldPosition.getYPos() >= robot.getMaxYPos())
        {
            newPosition = oldPosition;
        }
        else
        {
            double targetDeltaY = newPosition.getYPos() - oldPosition.getYPos();
            double realDeltaY = robot.getMaxYPos() - oldPosition.getYPos();

            if (targetDeltaY > .01)
            {
                double relative = realDeltaY / targetDeltaY;
                assert(relative <= 1.);

                double targetDeltaX = newPosition.getXPos() - oldPosition.getXPos();
                double realDeltaX = relative * targetDeltaX;

                newPosition.setXPos(oldPosition.getXPos() + realDeltaX);
            }

            newPosition.setYPos(robot.getMaxYPos());
        }
    }

    if (newPosition != robot.getDestination())
    {
        double targetDistance = oldPosition.distance(robot.getDestination());
        double actualDistance = oldPosition.distance(newPosition);

        robot.setDestination(newPosition);

        if (newPosition == oldPosition)
        {
            robot.setTimeFraction(.0);
        }
        else if (targetDistance > .0)
        {
            robot.adjustTimeFraction(actualDistance / targetDistance);
        }
    }
}


void CRally::processMine(CRobot& robot)
{
    robot.setTargetMining(m_ground.getAt(robot.getCenterPosition()));
}


void CRally::applyMining(CRobot& robot)
{
    CPosition position = robot.getCenterPosition();
    CGroundUnit& groundUnit = m_ground.getAt(position);

    bool mined = false;

    for (int i = 0; i < 10; ++i)
    {
        int miningAmount = std::min(robot.getMiningAmount(i), groundUnit.getOre(i));

        if (miningAmount > 0)
        {
            groundUnit.removeOre(i, miningAmount);
            robot.addOre(i, miningAmount);
            mined = true;
        }
    }

    if (mined)
    {
        m_animation.addGroundChange(position, CGroundChangeStep(m_time, groundUnit.getOre()));
    }
}


void CRally::checkCollisions()
{
    bool collisionFound;
    double minCollisionTime = .0;

    do
    {
        collisionFound = false;

        double collisionTime = 1.;
        unsigned int robot1 = 0;
        unsigned int robot2 = 0;

        for (unsigned int i = 0; i < m_robots.size() - 1; ++i)
        {
            for (unsigned int j = i + 1; j < m_robots.size(); ++j)
            {
                double newCollisionTime = findCollisionTime(*m_robots[i], *m_robots[j], minCollisionTime, collisionTime);

                if (newCollisionTime < collisionTime)
                {
                    collisionTime = newCollisionTime;
                    robot1 = i;
                    robot2 = j;
                }
            }
        }

        if (collisionTime < 1.)
        {
            collisionFound = true;
            minCollisionTime = collisionTime;

            CRobot& firstRobot = *m_robots[robot1];
            CRobot& secondRobot = *m_robots[robot2];

            if (firstRobot.getTimeFraction() > collisionTime)
            {
                firstRobot.setDestination(positionAtTime(firstRobot.getPosition(), firstRobot.getDestination(), firstRobot.getTimeFraction(), collisionTime));
                firstRobot.setTimeFraction(collisionTime);
            }

            if (secondRobot.getTimeFraction() > collisionTime)
            {
                secondRobot.setDestination(positionAtTime(secondRobot.getPosition(), secondRobot.getDestination(), secondRobot.getTimeFraction(), collisionTime));
                secondRobot.setTimeFraction(collisionTime);
            }
        }
    } while (collisionFound);
}


double CRally::findCollisionTime(CRobot& robot1, CRobot& robot2, double minCollisionTime, double maxCollisionTime)
{
    assert(minCollisionTime <= maxCollisionTime);

    double collisionTime = 1.;

    CPosition robot1StartPosition = positionAtTime(robot1.getPosition(), robot1.getDestination(), robot1.getTimeFraction(), std::min(minCollisionTime, robot1.getTimeFraction()));
    CPosition robot2StartPosition = positionAtTime(robot2.getPosition(), robot2.getDestination(), robot2.getTimeFraction(), std::min(minCollisionTime, robot2.getTimeFraction()));

    CPosition robot1EndPosition = positionAtTime(robot1.getPosition(), robot1.getDestination(), robot1.getTimeFraction(), std::min(maxCollisionTime, robot1.getTimeFraction()));
    CPosition robot2EndPosition = positionAtTime(robot2.getPosition(), robot2.getDestination(), robot2.getTimeFraction(), std::min(maxCollisionTime, robot2.getTimeFraction()));

    double startDistance = robot1StartPosition.distance(robot2StartPosition) - (robot1.getSize() / 2.) - (robot2.getSize() / 2.);
    double endDistance = robot1EndPosition.distance(robot2EndPosition) - (robot1.getSize() / 2.) - (robot2.getSize() / 2.);

    double robot1TravelDistance = robot1StartPosition.distance(robot1EndPosition);
    double robot2TravelDistance = robot2StartPosition.distance(robot2EndPosition);
    double totalTravelDistance = robot1TravelDistance + robot2TravelDistance;

    if (totalTravelDistance > startDistance && totalTravelDistance > endDistance)
    {
        double robot1Speed = robot1.getTimeFraction() > minCollisionTime ? abs(robot1.getCurrentSpeed()) : .0;
        double robot2Speed = robot2.getTimeFraction() > minCollisionTime ? abs(robot2.getCurrentSpeed()) : .0;
        double totalSpeed = robot1Speed + robot2Speed;

        if (totalSpeed > .0)
        {
            double minCollisionTimeIncrease = std::max(.0, startDistance / totalSpeed);
            double maxCollisionTimeDecrease = std::max(.0, endDistance / totalSpeed);

            if (minCollisionTimeIncrease + maxCollisionTimeDecrease > maxCollisionTime - minCollisionTime)
            {
                // No collision
            }
            else if (minCollisionTimeIncrease > .01 || maxCollisionTimeDecrease > .1)
            {
                collisionTime = findCollisionTime(robot1, robot2, minCollisionTime + minCollisionTimeIncrease, maxCollisionTime - maxCollisionTimeDecrease);
            }
            else
            {
                CPosition robot1TestPosition = positionAtTime(robot1.getPosition(), robot1.getDestination(), robot1.getTimeFraction(), std::min(minCollisionTime + .01, robot1.getTimeFraction()));
                CPosition robot2TestPosition = positionAtTime(robot2.getPosition(), robot2.getDestination(), robot2.getTimeFraction(), std::min(minCollisionTime + .01, robot2.getTimeFraction()));

                double testDistance = robot1TestPosition.distance(robot2TestPosition) - (robot1.getSize() / 2.) - (robot2.getSize() / 2.);

                if (testDistance < .0 && testDistance < startDistance)
                {
                    collisionTime = minCollisionTime + minCollisionTimeIncrease;
                }
                else
                {
                    collisionTime = findCollisionTime(robot1, robot2, minCollisionTime + .01, std::max(maxCollisionTime - maxCollisionTimeDecrease, minCollisionTime + .01));
                }
            }
        }
    }

    return collisionTime;
}


CPosition CRally::positionAtTime(const CPosition& startPosition, const CPosition& endPosition, double travelTime, double time)
{
    assert(time <= travelTime);

    CPosition position = startPosition;

    if (time > .0)
    {
        double deltaX = (endPosition.getXPos() - startPosition.getXPos()) * time / travelTime;
        double deltaY = (endPosition.getYPos() - startPosition.getYPos()) * time / travelTime;

        position.setXPos(position.getXPos() + deltaX);
        position.setYPos(position.getYPos() + deltaY);
    }

    return position;
}
