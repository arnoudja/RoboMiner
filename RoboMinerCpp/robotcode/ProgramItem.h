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

#pragma once

#include "ProgramItemStatus.h"

class CRobot;

namespace robotcode
{
    class CProgramAction;
    class CProgramItemStatus;
    class CValue;
    class CCompileInput;

    class CProgramItem
    {
    public:
        CProgramItem();
        virtual ~CProgramItem();

        virtual CProgramAction* getNextAction(const CRobot* robot, CProgramItemStatus*& status) const = 0;
        virtual void processReturnValue(CProgramItemStatus* status, const CValue& value) const      { if (status) status->processReturnValue(value); }

        virtual int size() const = 0;

        static CProgramItem* compile(CCompileInput& input, bool& terminated);
    };
}
