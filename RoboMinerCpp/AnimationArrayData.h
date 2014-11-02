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

#include <string>
#include <sstream>


class CAnimationArrayData
{
public:
    CAnimationArrayData(std::stringstream& output);
    virtual ~CAnimationArrayData();

    void addValue(const std::string& name, long value);

    void nextArrayElement();
    
    void closeArray();

private:
    std::stringstream&  m_output;
    bool                m_firstElement;
    bool                m_firstValue;
    bool                m_isClosed;
};
