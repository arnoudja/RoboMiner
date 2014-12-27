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

#include "Value.h"

#include <string>

namespace robotcode
{
    class CVariable
    {
    public:
        CVariable();
        CVariable(const std::string& name, CValue::EValueType variableType, const CValue& value, bool isConst = false);
        virtual ~CVariable()                            {}

        const CValue& getValue() const                  { return m_value; }
        void setValue(const CValue& value);

        void incrementValue()                           { m_value.incrementValue(); }
        void decrementValue()                           { m_value.decrementValue(); }

        bool isConst() const                            { return m_isConst; }

    private:
        std::string         m_variableName;
        CValue::EValueType  m_variableType;
        CValue              m_value;
        bool                m_isConst;
    };
}
