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

#include "VariableReturnAction.h"

#include "Value.h"
#include "Variable.h"
#include "RobotProgram.h"
#include "VariableStorage.h"


using namespace std;
using namespace robotcode;


CVariableReturnAction::CVariableReturnAction(const string& variableName,
                                             CVariableValueProgramItem::EVariableOperator variableOperator) :
    m_variableName(variableName),
    m_variableOperator(variableOperator)
{
}


CValue CVariableReturnAction::getValue(CRobotProgram& robot) const
{
    CValue result;

    CVariable* variable = robot.getVariableStorage().getVariable(m_variableName);
    if (variable)
    {
        switch (m_variableOperator)
        {
        case CVariableValueProgramItem::eNone:
            result = variable->getValue();
            break;

        case CVariableValueProgramItem::ePreIncrement:
            variable->incrementValue();
            result = variable->getValue();
            break;

        case CVariableValueProgramItem::ePreDecrement:
            variable->decrementValue();
            result = variable->getValue();
            break;

        case CVariableValueProgramItem::ePostIncrement:
            result = variable->getValue();
            variable->incrementValue();
            break;

        case CVariableValueProgramItem::ePostDecrement:
            result = variable->getValue();
            variable->decrementValue();
            break;

        default:
            assert(false);
            break;
        }
    }

    return result;
}
