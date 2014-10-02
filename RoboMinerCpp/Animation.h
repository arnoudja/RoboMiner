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

#include "AnimationStep.h"
#include "GroundChangeStep.h"
#include "Ground.h"
#include "Robot.h"

#include <string>
#include <sstream>
#include <vector>
#include <list>
#include <map>

class CAnimation
{
public:
    struct OreData
    {
        int id;
        int maxAmount;
    };
    
    CAnimation();
    ~CAnimation()                                           {}

    void addStep(unsigned int robotNr, const CRobot& robot);
    void addGroundChange(const CPosition& position, const CGroundChangeStep step);

    std::string getAnimationData(const TRobots& robotList, const CGround& ground, const std::map<int, OreData>& oreData);

protected:
    void writeRobotsData(const TRobots& robotList);
    void writeGroundData(const CGround& ground);
    void writeOreData(const std::map<int, OreData>& oreData);

private:
    typedef std::list<CAnimationStep>       TAnimationStepList;
    typedef std::vector<TAnimationStepList> TRobotSteps;

    typedef std::list<CGroundChangeStep>                TGroundChangeStepList;
    typedef std::map<int, TGroundChangeStepList>        TGroundRowChanges;
    typedef std::map<int, TGroundRowChanges>            TGroundChanges;

    std::stringstream   m_output;
    TRobotSteps         m_robotSteps;
    TGroundChanges      m_groundChanges;
};
