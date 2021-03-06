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

#include "MoveProgramItem.h"
#include "ProgramItemStatus.h"
#include "CallAction.h"
#include "MoveAction.h"
#include "ConstReturnAction.h"
#include "CompileInput.h"

#include "../Robot.h"


using namespace std;
using namespace robotcode;


CMoveProgramItem::CMoveProgramItem(CValueProgramItem* valueProgramItem) :
    m_valueProgramItem(valueProgramItem)
{
}


CMoveProgramItem::~CMoveProgramItem()
{
    delete m_valueProgramItem;
}


CProgramAction* CMoveProgramItem::getNextAction(const CRobot* robot, CProgramItemStatus*& status) const
{
    CProgramAction* action = NULL;

    if (!status)
    {
        status = new CProgramItemStatus();
        action = new CCallAction(m_valueProgramItem);
    }
    else if (dynamic_cast<CCallAction*>(status->getProgramAction()))
    {
        action = new CMoveAction(robot->getPosition(), status->getValue());
    }
    else
    {
        CMoveAction* moveAction = dynamic_cast<CMoveAction*>(status->getProgramAction());
        assert(moveAction);

        if (moveAction->getDistance() != .0)
        {
            action = moveAction;
        }
        else
        {
            action = new CConstReturnAction(robot->getPosition().distance(moveAction->getStartPosition()));
        }
    }

    if (action != status->getProgramAction())
    {
        status->adoptProgramAction(action);
    }

    return action;
}


int CMoveProgramItem::size() const
{
    return 1 + (m_valueProgramItem ? m_valueProgramItem->size() : 0);
}


CMoveProgramItem* CMoveProgramItem::compile(CCompileInput& input)
{
    CMoveProgramItem* result = NULL;

    if (input.useNextWord("move"))
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

        result = new CMoveProgramItem(value);
    }

    return result;
}
