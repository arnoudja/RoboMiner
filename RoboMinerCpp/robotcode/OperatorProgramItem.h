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

#include "ValueProgramItem.h"
#include "Value.h"

namespace robotcode
{
    class COperatorProgramItem :
        public CValueProgramItem
    {
    public:
        enum EOperatorType
        {
            eAddition,
            eSubtraction,
            eMultiply,
            eDivision,
            eLarger,
            eSmaller,
            eLargerEqual,
            eSmallerEqual,
            eEqual,
            eAnd,
            eOr,
            eNot,
            eUndefinedOperator
        };

        COperatorProgramItem(EOperatorType operatorType, const CValueProgramItem* left, CValueProgramItem* right);
        virtual ~COperatorProgramItem();

        virtual CProgramAction* getNextAction(const CRobot* robot, CProgramItemStatus*& status) const;

        virtual int size() const;

        static CValueProgramItem* compile(CCompileInput& input);

    private:
        static CValueProgramItem* compileSingleValue(CCompileInput& input);

        static int operatorPriority(EOperatorType operatorType);

        EOperatorType               m_operatorType;
        const CValueProgramItem*    m_leftValueProgramItem;
        const CValueProgramItem*    m_rightValueProgramItem;
    };
}
