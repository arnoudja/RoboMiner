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

#include "Position.h"
#include "GroundUnit.h"

class CAnimationStep
{
public:
    CAnimationStep(const CPosition& position, const CGroundUnit::TOreAmount& ore, double timeFraction);
    virtual ~CAnimationStep();

    const CPosition& getPosition() const                        { return m_position; }
    int getOre(int type) const                                  { return m_ore[type]; }
    double getTimeFraction() const                              { return m_timeFraction; }

private:
    CPosition               m_position;
    CGroundUnit::TOreAmount m_ore;
    double                  m_timeFraction;
};

