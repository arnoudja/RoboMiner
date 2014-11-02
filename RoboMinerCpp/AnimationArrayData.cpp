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

#include "stdafx.h"

#include "AnimationArrayData.h"

using namespace std;


CAnimationArrayData::CAnimationArrayData(stringstream& output) :
    m_output(output),
    m_firstElement(true),
    m_firstValue(true),
    m_isClosed(false)
{
    m_output << "[";
}


CAnimationArrayData::~CAnimationArrayData()
{
    closeArray();
}


void CAnimationArrayData::addValue(const string& name, long value)
{
    if (m_firstValue)
    {
        if (!m_firstElement)
        {
            m_output << ",";
        }

        m_output << "{";

        m_firstElement = false;
    }
    else
    {
        m_output << ",";
    }

    m_output << name << ":" << value;

    m_firstValue = false;
}


void CAnimationArrayData::nextArrayElement()
{
    if (m_firstValue)
    {
        m_output << "{";
    }
    
    m_output << "}";

    m_firstValue    = true;
    m_firstElement  = false;
}


void CAnimationArrayData::closeArray()
{
    if (!m_isClosed)
    {
        m_output << "]";
        m_isClosed = true;
    }
}
