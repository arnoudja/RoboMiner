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

#include "DumpProgramItem.h"
#include "ProgramItemStatus.h"
#include "CallAction.h"
#include "DumpAction.h"
#include "ConstReturnAction.h"
#include "CompileInput.h"

#include "../Robot.h"


using namespace std;
using namespace robotcode;


CDumpProgramItem::CDumpProgramItem(CValueProgramItem* valueProgramItem) :
    m_valueProgramItem(valueProgramItem)
{
}


CDumpProgramItem::~CDumpProgramItem()
{
    delete m_valueProgramItem;
}


CProgramAction* CDumpProgramItem::getNextAction(const CRobot* robot, CProgramItemStatus*& status) const
{
    CProgramAction* action = NULL;

    if (!status)
    {
        status = new CProgramItemStatus();
        action = new CCallAction(m_valueProgramItem);
    }
    else if (dynamic_cast<CCallAction*>(status->getProgramAction()))
    {
        int amount  = 0;
        int oreType = status->getValue().getIntValue();

        if (oreType > 0 && oreType <= (int)robot->getOre().size())
        {
            amount = robot->getOre(oreType - 1);
        }
        else
        {
            amount = robot->getTotalOre();
        }

        action = new CDumpAction(status->getValue(), amount);
    }
    else
    {
        CDumpAction* dumpAction = dynamic_cast<CDumpAction*>(status->getProgramAction());
        assert(dumpAction);

        action = new CConstReturnAction(dumpAction->getAmount());
    }

    status->adoptProgramAction(action);

    return action;
}


int CDumpProgramItem::size() const
{
    return 1 + (m_valueProgramItem ? m_valueProgramItem->size() : 0);
}


CDumpProgramItem* CDumpProgramItem::compile(CCompileInput& input)
{
    CDumpProgramItem* result = NULL;

    if (input.useNextWord("dump"))
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

        result = new CDumpProgramItem(value);
    }

    return result;
}
