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

#include "MineProgramItem.h"
#include "ProgramItemStatus.h"
#include "MineAction.h"
#include "MineReturnAction.h"
#include "CompileInput.h"


using namespace std;
using namespace robotcode;


CMineProgramItem::CMineProgramItem()
{
}


CMineProgramItem::~CMineProgramItem()
{
}


CProgramAction* CMineProgramItem::getNextAction(const CRobot* robot, CProgramItemStatus*& status) const
{
    CProgramAction* action = NULL;

    if (status)
    {
        action = new CMineReturnAction();
    }
    else
    {
        status = new CProgramItemStatus();
        action = new CMineAction();
    }

    status->adoptProgramAction(action);

    return action;
}


CMineProgramItem* CMineProgramItem::compile(CCompileInput& input)
{
    CMineProgramItem* result = NULL;

    if (input.useNextWord("mine"))
    {
        if (!input.eatChar('(') || !input.eatChar(')'))
        {
            stringstream error;
            error << "Syntax error at line " << input.getCurrentLine() << ". '()' expected";
            throw error.str();
        }
        
        result = new CMineProgramItem();
    }

    return result;
}
