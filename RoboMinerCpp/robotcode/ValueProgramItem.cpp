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

#include "ValueProgramItem.h"

#include "ConstValueProgramItem.h"
#include "VariableValueProgramItem.h"
#include "MineProgramItem.h"
#include "MoveProgramItem.h"
#include "RotateProgramItem.h"
#include "OreValueProgramItem.h"
#include "DumpProgramItem.h"
#include "OperatorProgramItem.h"
#include "CompileInput.h"


using namespace robotcode;


CValueProgramItem* CValueProgramItem::compile(CCompileInput& input)
{
    CValueProgramItem* result = NULL;

    result = COperatorProgramItem::compile(input);

    if (!result)
    {
        result = compileSingleValue(input);
    }

    return result;
}


CValueProgramItem* CValueProgramItem::compileSingleValue(CCompileInput& input)
{
    CValueProgramItem* result = NULL;

    result = CConstValueProgramItem::compile(input);

    if (!result)
    {
        result = CMineProgramItem::compile(input);
    }

    if (!result)
    {
        result = CMoveProgramItem::compile(input);
    }

    if (!result)
    {
        result = CRotateProgramItem::compile(input);
    }

    if (!result)
    {
        result = COreValueProgramItem::compile(input);
    }

    if (!result)
    {
        result = CDumpProgramItem::compile(input);
    }

    if (!result)
    {
        result = CVariableValueProgramItem::compile(input);
    }

    return result;
}
