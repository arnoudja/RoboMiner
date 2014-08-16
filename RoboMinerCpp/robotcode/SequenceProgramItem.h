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

#include "ProgramItem.h"
#include "ProgramItemStatus.h"

#include <list>

namespace robotcode
{
    class CSequenceProgramItem :
        public CProgramItem
    {
    public:
        CSequenceProgramItem();
        virtual ~CSequenceProgramItem();

        virtual CProgramAction* getNextAction(CProgramItemStatus*& status) const;

        void adoptStep(CProgramItem* step)              { m_sequence.push_back(step); }

        virtual int size() const;

        static CProgramItem* compile(CCompileInput& input, bool& terminated);

    private:
        typedef std::list<const CProgramItem*>    TSequence;

        class CSequenceStatus : public CProgramItemStatus
        {
        public:
            CSequenceStatus(const TSequence::const_iterator& currentItem);
            virtual ~CSequenceStatus()                                      {}

            void toNextItem()                                               { ++m_currentItem; }
            const TSequence::const_iterator& getCurrentItem() const         { return m_currentItem; }

        private:
            TSequence::const_iterator m_currentItem;
        };

        TSequence   m_sequence;
    };
}
