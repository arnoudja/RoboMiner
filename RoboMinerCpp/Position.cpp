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
#include "Position.h"

#include <cassert>


CPosition::CPosition() :
m_xPos(0),
m_yPos(0),
m_orientation(0)
{
}


CPosition::CPosition(double xPos, double yPos, int orientation) :
m_xPos(xPos),
m_yPos(yPos),
m_orientation(orientation)
{
}


CPosition::~CPosition()
{
}


void CPosition::setPosition(double x, double y)
{
    m_xPos = x;
    m_yPos = y;
}


void CPosition::setXPos(double x)
{
    m_xPos = x;
}


void CPosition::setYPos(double y)
{
    m_yPos = y;
}


void CPosition::setOrientation(int orientation)
{
    m_orientation = orientation;
}


void CPosition::rotate(int rotation)
{
    m_orientation = (m_orientation + rotation) % 360;
}


CPosition CPosition::calculateMovePosition(double speed)
{
    CPosition result = *this;

    double orientation = getOrientation() * M_PI / 180;
    result.m_xPos += speed * cos(orientation);
    result.m_yPos += speed * sin(orientation);

    return result;
}
