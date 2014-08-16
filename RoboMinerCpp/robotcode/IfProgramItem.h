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

#include "ProgramItem.h"
#include "ValueProgramItem.h"

namespace robotcode
{
    class CIfProgramItem :
        public CProgramItem
    {
    public:
        CIfProgramItem(const CValueProgramItem* condition, const CProgramItem* trueBody, const CProgramItem* falseBody = NULL);
        virtual ~CIfProgramItem();

        virtual CProgramAction* getNextAction(CProgramItemStatus*& status) const;

        virtual int size() const;

        static CIfProgramItem* compile(CCompileInput& input, bool& terminated);

    private:
        const CValueProgramItem*    m_condition;
        const CProgramItem*         m_trueBody;
        const CProgramItem*         m_falseBody;
    };
}
