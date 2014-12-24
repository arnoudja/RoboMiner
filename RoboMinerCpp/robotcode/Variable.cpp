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
#include "Variable.h"


using namespace std;
using namespace robotcode;


CVariable::CVariable() :
    m_variableType(CValue::eUndefinedValue),
    m_isConst(false)
{
}


CVariable::CVariable(const string& name, CValue::EValueType variableType, const CValue& value, bool isConst) :
    m_variableName(name),
    m_variableType(variableType),
    m_isConst(isConst)
{
    setValue(value);
}


void CVariable::setValue(const CValue& value)
{
    switch (m_variableType)
    {
    case CValue::eBoolValue:
        m_value = value.getBoolValue();
        break;

    case CValue::eIntValue:
        m_value = value.getIntValue();
        break;

    case CValue::eDoubleValue:
        m_value = value.getDoubleValue();
        break;

    default:
        assert(false);
    }
}
