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

#include "ProgramAction.h"
#include "Value.h"

#include <string>


namespace robotcode
{
    class CSetVariableAction :
        public CProgramAction
    {
    public:
        CSetVariableAction(const std::string& variableName, CValue::EValueType variableType, const CValue& value);
        CSetVariableAction(const std::string& variableName, const CValue& value);
        virtual ~CSetVariableAction();

        const std::string& getVariableName() const          { return m_variableName; }
        const CValue& getValue() const                      { return m_value; }
        bool isCreate() const                               { return m_create; }
        CValue::EValueType getVariableCreateType() const    { return m_variableType; }

    private:
        std::string         m_variableName;
        CValue              m_value;
        bool                m_create;
        CValue::EValueType  m_variableType;
    };
}
