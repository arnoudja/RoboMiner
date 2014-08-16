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


CVariableValueProgramItem::CVariableValueProgramItem(const string& variableName) :
    m_variableName(variableName)
{
}


CVariableValueProgramItem::~CVariableValueProgramItem()
{
}


CProgramAction* CVariableValueProgramItem::getNextAction(CProgramItemStatus*& status) const
{
    if (!status)
    {
        status = new CProgramItemStatus();
    }

    CVariableReturnAction* action = new CVariableReturnAction(m_variableName);
    status->adoptProgramAction(action);

    return action;
}


CVariableValueProgramItem* CVariableValueProgramItem::compile(CCompileInput& input)
{
    CVariableValueProgramItem* result = NULL;

    list<string> variableNames = input.getVariableStorage().getVariableList();

    for (list<string>::const_iterator iter = variableNames.begin(); !result && iter != variableNames.end(); ++iter)
    {
        if (input.useNextWord(*iter))
        {
            result = new CVariableValueProgramItem(*iter);
        }
    }

    return result;
}
