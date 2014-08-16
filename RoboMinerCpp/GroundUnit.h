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

#include <cassert>
#include <vector>

class CGroundUnit
{
public:
    typedef std::vector<int>    TOreAmount;

    CGroundUnit();
    virtual ~CGroundUnit();

    int getOre(int type) const              { return m_oreAmount[type];  }
    const TOreAmount& getOre() const        { return m_oreAmount; }
    bool hasOre() const;

    void addOre(int type, int amount)       { m_oreAmount[type] += amount; }
    void removeOre(int type, int amount)    { assert(amount >= 0 && amount <= m_oreAmount[type]); m_oreAmount[type] -= amount; }

private:
    TOreAmount  m_oreAmount;
};
