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

#include "VariableValueProgramItem.h"
#include "VariableReturnAction.h"
#include "CompileInput.h"


using namespace std;
using namespace robotcode;


CVariableValueProgramItem::CVariableValueProgramItem(const string& variableName, EVariableOperator variableOperator) :
    m_variableName(variableName),
    m_variableOperator(variableOperator)
{
}


CProgramAction* CVariableValueProgramItem::getNextAction(const CRobot* robot, CProgramItemStatus*& status) const
{
    CProgramAction* action = NULL;

    if (!status)
    {
        status = new CProgramItemStatus();

        if (m_variableOperator == eNone)
        {
            action = new CVariableReturnAction(m_variableName);
            status->adoptProgramAction(action);
        }
    }
    else
    {
        action = new CVariableReturnAction(m_variableName, m_variableOperator);
        status->adoptProgramAction(action);
    }

    return action;
}


CVariableValueProgramItem* CVariableValueProgramItem::compile(CCompileInput& input)
{
    CVariableValueProgramItem* result = NULL;

    EVariableOperator variableOperator = eNone;

    if (input.eatSequence("++"))
    {
        variableOperator = ePreIncrement;
    }
    else if (input.eatSequence("--"))
    {
        variableOperator = ePreDecrement;
    }

    string variableName;
    list<string> variableNames = input.getVariableStorage().getVariableList();

    for (list<string>::const_iterator iter = variableNames.begin(); !result && iter != variableNames.end(); ++iter)
    {
        if (input.useNextWord(*iter))
        {
            variableName = *iter;
        }
    }

    if (!variableName.empty() && variableOperator == eNone)
    {
        if (input.eatSequence("++"))
        {
            variableOperator = ePostIncrement;
        }
        else if (input.eatSequence("--"))
        {
            variableOperator = ePostDecrement;
        }
    }

    if (!variableName.empty())
    {
        result = new CVariableValueProgramItem(variableName, variableOperator);
    }
    else if (variableOperator != eNone)
    {
        stringstream error;
        error << "Syntax error at line " << input.getCurrentLine() << ". Variable expected";
        throw error.str();
    }

    return result;
}
