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
#include "Value.h"


using namespace robotcode;


CValue::CValue() :
    m_valueType(eUndefinedValue)
{
}


CValue::CValue(bool value) :
    m_valueType(eBoolValue),
    m_boolValue(value)
{
}


CValue::CValue(int value) :
    m_valueType(eIntValue),
    m_intValue(value)
{
}


CValue::CValue(double value) :
    m_valueType(eDoubleValue),
    m_doubleValue(value)
{
}


CValue::~CValue()
{
}


double CValue::getDoubleValue() const
{
    double result = .0;

    switch (m_valueType)
    {
    case eBoolValue:
        result = m_boolValue ? 1. : .0;
        break;

    case eIntValue:
        result = m_intValue;
        break;

    case eDoubleValue:
        result = m_doubleValue;
        break;

    default:
        result = .0;
        break;
    }

    return result;
}


int CValue::getIntValue() const
{
    int result = 0;

    switch (m_valueType)
    {
    case eBoolValue:
        result = m_boolValue ? 1 : 0;
        break;

    case eIntValue:
        result = m_intValue;
        break;

    case eDoubleValue:
        result = (int)m_doubleValue;
        break;

    default:
        result = 0;
        break;
    }

    return result;
}


bool CValue::getBoolValue() const
{
    bool result = false;

    switch (m_valueType)
    {
    case eBoolValue:
        result = m_boolValue;
        break;

    case eIntValue:
        result = (m_intValue != 0);
        break;

    case eDoubleValue:
        result = (m_doubleValue != .0);
        break;

    default:
        result = false;
        break;
    }

    return result;
}
