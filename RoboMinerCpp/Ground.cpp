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
#include "Ground.h"

#include "GroundUnit.h"

#include <cassert>

CGround::CGround(int sizeX, int sizeY) :
m_sizeX(sizeX),
m_sizeY(sizeY),
m_resources(boost::extents[sizeX][sizeY])
{
}


CGround::~CGround()
{
}


void CGround::resize(int sizeX, int sizeY)
{
    m_resources.resize(boost::extents[sizeX][sizeY]);
}


CGroundUnit& CGround::getAt(int x, int y)
{
    assert(x >= 0 && x < m_sizeX);
    assert(y >= 0 && y < m_sizeY);

    return m_resources[x][y];
}


CGroundUnit& CGround::getAt(const CPosition& position)
{
    return getAt((int)position.getXPos(), (int)position.getYPos());
}


void CGround::addOreHeap(int x, int y, int type, int topAmount, int radius)
{
    for (int dx = -radius; dx <= radius; ++dx)
    {
        for (int dy = -radius; dy <= radius; ++dy)
        {
            int xPos = x + dx;
            int yPos = y + dy;

            if (xPos >= 0 && xPos < m_sizeX && yPos >= 0 && yPos < m_sizeY)
            {
                double distance = sqrt(dx * dx + dy * dy);

                int amount = (int)(.999 + topAmount * (radius - distance) / radius);
                amount -= m_resources[xPos][yPos].getOre(type);

                if (amount > 0)
                {
                    m_resources[xPos][yPos].addOre(type, amount);
                }
            }
        }
    }
}
