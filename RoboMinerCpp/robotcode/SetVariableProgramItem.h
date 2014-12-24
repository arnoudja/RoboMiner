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

#include "ProgramItem.h"

#include <string>

namespace robotcode
{
    class CValueProgramItem;

    class CSetVariableProgramItem :
        public CProgramItem
    {
    public:
        CSetVariableProgramItem(const std::string& variableName, CValueProgramItem* valueProgramItem);
        CSetVariableProgramItem(const std::string& variableName, CValue::EValueType variableCreateType, CValueProgramItem* valueProgramItem);
        virtual ~CSetVariableProgramItem()                              {}

        virtual CProgramAction* getNextAction(const CRobot* robot, CProgramItemStatus*& status) const;

        virtual int size() const;

        static CSetVariableProgramItem* compile(CCompileInput& input, bool& terminated);

    protected:
        static CSetVariableProgramItem* compileVariableCreation(CCompileInput& input, bool& terminated,
                                                                CValue::EValueType valueType, bool isConst);
        static CSetVariableProgramItem* compileVariableAssignment(CCompileInput& input, bool& terminated);

    private:
        std::string        m_variableName;
        bool               m_create;
        CValue::EValueType m_variableCreateType;
        CValueProgramItem* m_valueProgramItem;
    };
}
