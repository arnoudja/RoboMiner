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

#include "../stdafx.h"
#include "SequenceProgramItem.h"

#include "CallAction.h"
#include "ReturnAction.h"
#include "CompileInput.h"


using namespace std;
using namespace robotcode;


CSequenceProgramItem::CSequenceProgramItem()
{
}


CSequenceProgramItem::~CSequenceProgramItem()
{
    for (TSequence::iterator iter = m_sequence.begin(); iter != m_sequence.end(); ++iter)
    {
        delete *iter;
    }
}


CProgramAction* CSequenceProgramItem::getNextAction(CProgramItemStatus*& status) const
{
    CSequenceStatus* currentStatus = dynamic_cast<CSequenceStatus*>(status);
    assert(status || !currentStatus);

    if (!status)
    {
        currentStatus = new CSequenceStatus(m_sequence.begin());
        status        = currentStatus;
    }
    else
    {
        currentStatus->toNextItem();
    }

    CProgramAction* action = NULL;

    if (currentStatus->getCurrentItem() == m_sequence.end())
    {
        action = new CReturnAction();
    }
    else
    {
        action = new CCallAction(*currentStatus->getCurrentItem());
    }

    currentStatus->adoptProgramAction(action);

    return action;
}


CSequenceProgramItem::CSequenceStatus::CSequenceStatus(const TSequence::const_iterator& currentItem)
{
    m_currentItem = currentItem;
}


int CSequenceProgramItem::size() const
{
    int result = 1;
    
    for (TSequence::const_iterator iter = m_sequence.begin(); iter != m_sequence.end(); ++iter)
    {
        if (*iter)
        {
            result += (*iter)->size();
        }
    }
    
    return result;
}


CProgramItem* CSequenceProgramItem::compile(CCompileInput& input, bool& terminated)
{
    CProgramItem* result = NULL;

    CSequenceProgramItem* sequence = NULL;

    try
    {
        if (input.eatChar('{'))
        {
            bool previousTerminated = false;

            int scopeDepth = input.getVariableStorage().getScopeDepth();
            input.getVariableStorage().setScopeDepth(scopeDepth + 1);

            input.eatChar(';', true);

            while (input.peek() != '}' && !input.eof())
            {
                CProgramItem* nextProgramItem = CProgramItem::compile(input, terminated);

                if (nextProgramItem && result && !previousTerminated)
                {
                    delete nextProgramItem;

                    stringstream error;
                    error << "Missing ';' at line " << input.getCurrentLine() << ".";
                    throw error.str();
                }

                if (!nextProgramItem)
                {
                    stringstream error;
                    error << "Syntax error at line " << input.getCurrentLine() << ". Statement expected";
                    throw error.str();
                }
                else if (sequence)
                {
                    sequence->adoptStep(nextProgramItem);
                }
                else if (result)
                {
                    sequence = new CSequenceProgramItem();

                    sequence->adoptStep(result);
                    sequence->adoptStep(nextProgramItem);

                    result = sequence;
                }
                else
                {
                    result = nextProgramItem;
                }

                previousTerminated = input.eatChar(';', true) || terminated;
            }

            if (!input.eatChar('}'))
            {
                stringstream error;
                error << "Missing '}' at line " << input.getCurrentLine();
                throw error.str();
            }

            input.getVariableStorage().setScopeDepth(scopeDepth);

            terminated = true;
        }
    }
    catch (...)
    {
        delete result;
        
        throw;
    }

    return result;
}
