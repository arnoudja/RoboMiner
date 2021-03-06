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

namespace robotcode
{
    class CValue
    {
    public:
        enum EValueType
        {
            eUndefinedValue,
            eBoolValue,
            eIntValue,
            eDoubleValue
        };

        CValue();
        CValue(bool value);
        CValue(int value);
        CValue(double value);
        virtual ~CValue()                       {}

        EValueType  getValueType() const        { return m_valueType; }
        double      getDoubleValue() const;
        int         getIntValue() const;
        bool        getBoolValue() const;

        void        incrementValue();
        void        decrementValue();

    private:
        EValueType  m_valueType;
        bool        m_boolValue;
        int         m_intValue;
        double      m_doubleValue;
    };
}
