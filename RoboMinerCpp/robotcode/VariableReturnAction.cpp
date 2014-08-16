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


CVariableReturnAction::CVariableReturnAction(const string& variableName) :
    m_variableName(variableName)
{
}


CVariableReturnAction::~CVariableReturnAction()
{
}


CValue CVariableReturnAction::getValue(const CRobotProgram& robot) const
{
    const CVariable* variable = robot.getVariableStorage().getVariable(m_variableName);
    return variable ? variable->getValue() : CValue();
}
