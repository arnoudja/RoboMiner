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

#include "ValueProgramItem.h"

#include <string>

namespace robotcode
{
    class CVariableValueProgramItem :
        public CValueProgramItem
    {
    public:
        enum EVariableOperator {
            eNone,
            ePreIncrement,
            ePreDecrement,
            ePostIncrement,
            ePostDecrement
        };

        CVariableValueProgramItem(const std::string& variableName, EVariableOperator variableOperator);
        virtual ~CVariableValueProgramItem()                    {}

        virtual CProgramAction* getNextAction(const CRobot* robot, CProgramItemStatus*& status) const;

        virtual int size() const                                { return (m_variableOperator == eNone) ? 1 : 2; }

        static CVariableValueProgramItem* compile(CCompileInput& input);

    private:
        std::string         m_variableName;
        EVariableOperator   m_variableOperator;
    };
}
