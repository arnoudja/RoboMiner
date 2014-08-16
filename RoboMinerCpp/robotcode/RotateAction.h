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

#include "ProgramAction.h"

namespace robotcode
{
    class CValue;

    class CRotateAction :
        public CProgramAction
    {
    public:
        CRotateAction(const CValue& rotation);
        virtual ~CRotateAction();

        int getRotation() const                         { return m_rotation; }
        void rotated(int rotation)                      { m_rotation -= rotation; }

    private:
        int m_rotation;
    };
}
