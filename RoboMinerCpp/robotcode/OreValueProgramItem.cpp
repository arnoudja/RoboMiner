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

#include <vector>

#include "../stdafx.h"

#include "OreValueProgramItem.h"
#include "CallAction.h"
#include "ConstReturnAction.h"
#include "CompileInput.h"
#include "../Robot.h"


using namespace std;
using namespace robotcode;


COreValueProgramItem::COreValueProgramItem(CValueProgramItem* valueProgramItem) :
    m_valueProgramItem(valueProgramItem)
{
}


COreValueProgramItem::~COreValueProgramItem()
{
    delete m_valueProgramItem;
}


CProgramAction* COreValueProgramItem::getNextAction(const CRobot* robot, CProgramItemStatus*& status) const
{
    CProgramAction* action = NULL;

    if (!status)
    {
        status = new CProgramItemStatus();
        action = new CCallAction(m_valueProgramItem);
    }
    else
    {
        int oreType   = status->getValue().getIntValue();
        int oreAmount = 0;

        if (oreType == 0)
        {
            oreAmount = robot->getTotalOre();
        }
        else if (oreType > 0 && oreType <= (int)robot->getOre().size())
        {
            oreAmount = robot->getOre(oreType - 1);
        }

        action = new CConstReturnAction(oreAmount);
    }

    status->adoptProgramAction(action);

    return action;
}


int COreValueProgramItem::size() const
{
    return 1 + (m_valueProgramItem ? m_valueProgramItem->size() : 0);
}


COreValueProgramItem* COreValueProgramItem::compile(CCompileInput& input)
{
    COreValueProgramItem* result = NULL;

    if (input.useNextWord("ore"))
    {
        if (!input.eatChar('('))
        {
            stringstream error;
            error << "Syntax error at line " << input.getCurrentLine() << ". '(' expected";
            throw error.str();
        }

        CValueProgramItem* value = CValueProgramItem::compile(input);

        if (!value || !input.eatChar(')'))
        {
            delete value;

            stringstream error;
            error << "Syntax error at line " << input.getCurrentLine() << ". " << (value ? "')'" : "value") << " expected";
            throw error.str();
        }

        result = new COreValueProgramItem(value);
    }

    return result;
}
