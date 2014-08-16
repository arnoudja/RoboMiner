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

class CPosition
{
public:
    CPosition();
    CPosition(double xPos, double yPos, int orientation = 0);
    virtual ~CPosition();

    bool operator==(const CPosition& other) const               { return m_xPos == other.m_xPos && m_yPos == other.m_yPos && m_orientation == other.m_orientation; }
    bool operator!=(const CPosition& other) const               { return !operator==(other); }

    void setPosition(double x, double y);
    void setXPos(double x);
    void setYPos(double y);
    void setOrientation(int orientation);

    double getXPos() const                                      { return m_xPos; }
    double getYPos() const                                      { return m_yPos; }
    int getOrientation() const                                  { return m_orientation; }

    void rotate(int rotation);

    CPosition calculateMovePosition(double speed);

    double distance(const CPosition& other) const               { return sqrt((m_xPos - other.m_xPos) * (m_xPos - other.m_xPos) + (m_yPos - other.m_yPos) * (m_yPos - other.m_yPos)); }

private:
    double m_xPos;
    double m_yPos;
    int    m_orientation;
};
