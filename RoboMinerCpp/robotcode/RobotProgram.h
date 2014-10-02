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

#include "../Robot.h"
#include "VariableStorage.h"

#include <string>
#include <stack>
#include <utility>

namespace robotcode
{
    class CProgramItem;
    class CProgramItemStatus;

    class CRobotProgram :
        public CRobot
    {
    public:
        CRobotProgram(int robotId,
                      const std::string& source,
                      int maxTurns, int maxOre,
                      int miningSpeed, int cpuSpeed,
                      double forwardSpeed, double backwardSpeed, int rotateSpeed,
                      double robotSize);
        virtual ~CRobotProgram();

        virtual RobotAction getNextAction();

        CVariableStorage& getVariableStorage()          { return m_variableStorage; }

    private:
        CProgramItem* m_program;

        const CProgramItem* m_currentStep;
        CProgramItemStatus* m_currentStatus;

        typedef std::pair<const CProgramItem*, CProgramItemStatus*> TStackItem;
        typedef std::stack<TStackItem>                              TStack;

        TStack              m_stack;
        CVariableStorage    m_variableStorage;
    };
}
