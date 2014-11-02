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

#include "boost/multi_array.hpp"

#include "Position.h"

class CGroundUnit;

class CGround
{
public:
	CGround(int sizeX, int sizeY);
	virtual ~CGround()                                      {}

    void resize(int sizeX, int sizeY);

    CGroundUnit& getAt(int x, int y);
    CGroundUnit& getAt(const CPosition& position);

    int getSizeX() const                                        { return m_sizeX; }
    int getSizeY() const                                        { return m_sizeY; }

    void addOreHeap(int x, int y, int type, int topAmount, int radius);

private:
	int	m_sizeX;
	int m_sizeY;

	typedef boost::multi_array<CGroundUnit, 2> TGroundUnitArray;

	TGroundUnitArray	m_resources;
};

