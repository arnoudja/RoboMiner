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

#include "Variable.h"

#include <string>
#include <list>
#include <map>


namespace robotcode
{
    class CVariableStorage
    {
    public:
        CVariableStorage();
        virtual ~CVariableStorage()                 {}

        void setScopeDepth(int depth);
        int getScopeDepth() const                   { return m_currentScopeLevel; }

        CVariable* getVariable(const std::string& variableName);

        void addVariable(const std::string& variableName, CValue::EValueType variableType, const CValue& value);
        void declareVariable(const std::string& variableName, CValue::EValueType variableType, bool isConst);
        void updateValue(const std::string& variableName, const CValue& value);

        bool variableExistsAtCurrentLevel(const std::string& variableName) const;

        std::list<std::string> getVariableList() const;

    private:
        typedef std::map<std::string, CVariable>    TVariables;
        typedef std::map<int, TVariables>           TScopedVariables;

        int                 m_currentScopeLevel;
        TScopedVariables    m_variables;
    };
}
