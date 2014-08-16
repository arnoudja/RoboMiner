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

#include "ProgramItem.h"

#include "CompileInput.h"
#include "SequenceProgramItem.h"
#include "WhileProgramItem.h"
#include "IfProgramItem.h"
#include "RotateProgramItem.h"
#include "SetVariableProgramItem.h"
#include "ValueProgramItem.h"


using namespace robotcode;


CProgramItem::CProgramItem()
{
}


CProgramItem::~CProgramItem()
{
}


CProgramItem* CProgramItem::compile(CCompileInput& input, bool& terminated)
{
    CProgramItem* result = NULL;

    if (!input.eatChar(';', true))
    {
        if (!result)
        {
            result = CWhileProgramItem::compile(input, terminated);
        }

        if (!result)
        {
            result = CIfProgramItem::compile(input, terminated);
        }

        if (!result)
        {
            result = CRotateProgramItem::compile(input, terminated);
        }

        if (!result)
        {
            result = CSetVariableProgramItem::compile(input, terminated);
        }

        if (!result)
        {
            result     = CValueProgramItem::compile(input);
            terminated = false;
        }

        // This one must be last
        if (!result)
        {
            result = CSequenceProgramItem::compile(input, terminated);
        }
    }

    return result;
}
