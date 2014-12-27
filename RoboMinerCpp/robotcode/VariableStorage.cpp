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

#include "../stdafx.h"
#include "VariableStorage.h"

#include <iostream>

using namespace std;
using namespace robotcode;


CVariableStorage::CVariableStorage() :
    m_currentScopeLevel(0)
{
}


void CVariableStorage::setScopeDepth(int depth)
{
    m_currentScopeLevel = depth;

    TScopedVariables::iterator iter = m_variables.find(m_currentScopeLevel + 1);

    if (iter != m_variables.end())
    {
        m_variables.erase(iter);
    }
}


CVariable* CVariableStorage::getVariable(const string& variableName)
{
    CVariable* result = NULL;
    int        scopeLevel = -1;

    for (TScopedVariables::iterator scopeIter = m_variables.begin(); scopeIter != m_variables.end(); ++scopeIter)
    {
        TVariables::iterator iter = scopeIter->second.find(variableName);

        if (iter != scopeIter->second.end())
        {
            if (scopeLevel < scopeIter->first)
            {
                result = &(iter->second);
            }
        }
    }

    return result;
}


void CVariableStorage::addVariable(const string& variableName, CValue::EValueType variableType, const CValue& value)
{
    m_variables[m_currentScopeLevel - 1][variableName] = CVariable(variableName, variableType, value);
}


void CVariableStorage::declareVariable(const string& variableName, CValue::EValueType variableType, bool isConst)
{
    m_variables[m_currentScopeLevel][variableName] = CVariable(variableName, variableType, CValue(), isConst);
}


void CVariableStorage::updateValue(const std::string& variableName, const CValue& value)
{
    CVariable* variable = getVariable(variableName);

    if (variable)
    {
        variable->setValue(value);
    }
    else
    {
        cout << "Unexpected error: Variable not found!\n";
    }
}


bool CVariableStorage::variableExistsAtCurrentLevel(const std::string& variableName) const
{
    TScopedVariables::const_iterator scopeIter = m_variables.find(m_currentScopeLevel);

    return (scopeIter != m_variables.end() && scopeIter->second.find(variableName) != scopeIter->second.end());
}


list<string> CVariableStorage::getVariableList() const
{
    list<string> result;

    for (TScopedVariables::const_iterator scopeIter = m_variables.begin(); scopeIter != m_variables.end(); ++scopeIter)
    {
        for (TVariables::const_iterator variableIter = scopeIter->second.begin(); variableIter != scopeIter->second.end(); ++variableIter)
        {
            result.push_back(variableIter->first);
        }
    }

    return result;
}
