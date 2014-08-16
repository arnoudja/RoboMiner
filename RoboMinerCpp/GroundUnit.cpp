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
#include "GroundUnit.h"


CGroundUnit::CGroundUnit()
{
    m_oreAmount.resize(10);
    for (int i = 0; i < 10; ++i)
    {
        m_oreAmount[i] = 0;
    }
}


CGroundUnit::~CGroundUnit()
{
}


bool CGroundUnit::hasOre() const
{
    bool result = false;

    for (int i = 0; i < 10; ++i)
    {
        if (m_oreAmount[i] > 0)
        {
            result = true;
        }
    }

    return result;
}