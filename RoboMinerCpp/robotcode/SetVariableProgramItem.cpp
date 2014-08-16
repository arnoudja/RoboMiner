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

#include "SetVariableProgramItem.h"
#include "ValueProgramItem.h"
#include "CallAction.h"
#include "SetVariableAction.h"
#include "ReturnAction.h"
#include "CompileInput.h"

#include <sstream>


using namespace std;
using namespace robotcode;


CSetVariableProgramItem::CSetVariableProgramItem(const string& variableName, CValueProgramItem* valueProgramItem) :
    m_variableName(variableName),
    m_create(false),
    m_variableCreateType(CValue::eUndefinedValue),
    m_valueProgramItem(valueProgramItem)
{
}


CSetVariableProgramItem::CSetVariableProgramItem(const string& variableName, CValue::EValueType variableCreateType, CValueProgramItem* valueProgramItem) :
m_variableName(variableName),
m_create(true),
m_variableCreateType(variableCreateType),
m_valueProgramItem(valueProgramItem)
{
}


CSetVariableProgramItem::~CSetVariableProgramItem()
{
}


CProgramAction* CSetVariableProgramItem::getNextAction(const CRobot* robot, CProgramItemStatus*& status) const
{
    CProgramAction* action = NULL;

    if (!status)
    {
        status = new CProgramItemStatus();

        if (m_valueProgramItem)
        {
            action = new CCallAction(m_valueProgramItem);
        }
        else if (m_create)
        {
            action = new CSetVariableAction(m_variableName, m_variableCreateType, CValue());
        }
        else
        {
            action = new CReturnAction();
        }
    }
    else if (dynamic_cast<CCallAction*>(status->getProgramAction()))
    {
        if (m_create)
        {
            action = new CSetVariableAction(m_variableName, m_variableCreateType, status->getValue());
        }
        else
        {
            action = new CSetVariableAction(m_variableName, status->getValue());
        }
    }
    else
    {
        action = new CReturnAction();
    }

    status->adoptProgramAction(action);

    return action;
}


int CSetVariableProgramItem::size() const
{
    return 1 + (m_valueProgramItem ? m_valueProgramItem->size() : 0);
}


CSetVariableProgramItem* CSetVariableProgramItem::compile(CCompileInput& input, bool& terminated)
{
    CSetVariableProgramItem* result = NULL;

    if (input.useNextWord("int"))
    {
        result = compileVariableCreation(input, terminated, CValue::eIntValue);
    }
    else if (input.useNextWord("double"))
    {
        result = compileVariableCreation(input, terminated, CValue::eDoubleValue);
    }
    else if (input.useNextWord("bool"))
    {
        result = compileVariableCreation(input, terminated, CValue::eBoolValue);
    }
    else
    {
        result = compileVariableAssignment(input, terminated);
    }

    return result;
}


CSetVariableProgramItem* CSetVariableProgramItem::compileVariableCreation(CCompileInput& input, bool& terminated, CValue::EValueType valueType)
{
    string variableName = input.useNextWord();

    if (variableName.empty())
    {
        stringstream error;
        error << "Syntax error at line " << input.getCurrentLine() << ". Identifier expected";
        throw error.str();
    }

    if (input.getVariableStorage().variableExistsAtCurrentLevel(variableName))
    {
        stringstream error;
        error << "Duplicate variable declaration at line " << input.getCurrentLine() << ": " << variableName;
        throw error.str();
    }

    CValueProgramItem* valueProgramItem = NULL;

    if (input.eatChar('='))
    {
        valueProgramItem = CValueProgramItem::compile(input);
    }

    terminated = input.eatChar(';');

    input.getVariableStorage().addVariable(variableName, valueType);

    return new CSetVariableProgramItem(variableName, valueType, valueProgramItem);
}


CSetVariableProgramItem* CSetVariableProgramItem::compileVariableAssignment(CCompileInput& input, bool& terminated)
{
    CSetVariableProgramItem* result = NULL;

    list<string> variableNames = input.getVariableStorage().getVariableList();

    for (list<string>::const_iterator iter = variableNames.begin(); !result && iter != variableNames.end(); ++iter)
    {
        if (input.useNextWord(*iter))
        {
            if (!input.eatChar('='))
            {
                stringstream error;
                error << "Syntax error at line " << input.getCurrentLine() << ". '=' expected";
                throw error.str();
            }

            CValueProgramItem* valueProgramItem = CValueProgramItem::compile(input);

            if (!valueProgramItem)
            {
                stringstream error;
                error << "Syntax error at line " << input.getCurrentLine() << ". Expression expected";
                throw error.str();
            }

            result = new CSetVariableProgramItem(*iter, valueProgramItem);
        }
    }

    return result;
}
