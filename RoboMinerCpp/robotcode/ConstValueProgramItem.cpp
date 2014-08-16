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

#include "ConstValueProgramItem.h"
#include "ProgramItemStatus.h"
#include "ConstReturnAction.h"
#include "CompileInput.h"


using namespace robotcode;


CConstValueProgramItem::CConstValueProgramItem(const CValue& value) :
    m_value(value)
{
}


CConstValueProgramItem::~CConstValueProgramItem()
{
}


CProgramAction* CConstValueProgramItem::getNextAction(CProgramItemStatus*& status) const
{
    if (!status)
    {
        status = new CProgramItemStatus();
    }

    CConstReturnAction* action = new CConstReturnAction(m_value);
    status->adoptProgramAction(action);

    return action;
}


CConstValueProgramItem* CConstValueProgramItem::compile(CCompileInput& input)
{
    CConstValueProgramItem* result = NULL;

    CValue value;

    if (input.extractConstValue(value))
    {
        result = new CConstValueProgramItem(value);
    }

    return result;
}
