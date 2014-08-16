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

#include "IfProgramItem.h"
#include "ProgramItemStatus.h"
#include "CallAction.h"
#include "ReturnAction.h"
#include "CompileInput.h"

#include <sstream>


using namespace std;
using namespace robotcode;


class CIfStatus : public CProgramItemStatus
{
public:
    CIfStatus() : m_bodyStarted(false)         {}
    virtual ~CIfStatus()                        {}

    bool bodyStarted() const                    { return m_bodyStarted; }
    void setBodyStarted()                       { m_bodyStarted = true; }

private:
    bool m_bodyStarted;
};


CIfProgramItem::CIfProgramItem(const CValueProgramItem* condition, const CProgramItem* trueBody, const CProgramItem* falseBody) :
    m_condition(condition),
    m_trueBody(trueBody),
    m_falseBody(falseBody)
{
}


CIfProgramItem::~CIfProgramItem()
{
    delete m_condition;
    delete m_trueBody;
    delete m_falseBody;
}


CProgramAction* CIfProgramItem::getNextAction(const CRobot* robot, CProgramItemStatus*& status) const
{
    CIfStatus* currentStatus = dynamic_cast<CIfStatus*>(status);
    assert(currentStatus || !status);

    CProgramAction* action = NULL;

    if (!status)
    {
        currentStatus = new CIfStatus();
        status = currentStatus;

        if (m_condition)
        {
            action = new CCallAction(m_condition);
        }
        else if (m_falseBody)
        {
            action = new CCallAction(m_falseBody);
            currentStatus->setBodyStarted();
        }
    }
    else if (!currentStatus->bodyStarted())
    {
        if (currentStatus->getValue().getBoolValue() && m_trueBody)
        {
            action = new CCallAction(m_trueBody);
        }
        else if (!currentStatus->getValue().getBoolValue() && m_falseBody)
        {
            action = new CCallAction(m_falseBody);
        }

        currentStatus->setBodyStarted();
    }

    if (!action)
    {
        action = new CReturnAction();
    }

    currentStatus->adoptProgramAction(action);

    return action;
}


int CIfProgramItem::size() const
{
    return 1 + 
           (m_condition ? m_condition->size() : 0) +
           (m_trueBody ? m_trueBody->size() : 0) +
           (m_falseBody ? m_falseBody->size() : 0);
}


CIfProgramItem* CIfProgramItem::compile(CCompileInput& input, bool& terminated)
{
    CIfProgramItem* result = NULL;

    if (input.useNextWord("if"))
    {
        CValueProgramItem* condition = NULL;
        CProgramItem*      trueBody  = NULL;
        CProgramItem*      falseBody = NULL;

        try
        {
            if (!input.eatChar('('))
            {
                stringstream error;
                error << "Syntax error at line " << input.getCurrentLine() << ". '(' expected";
                throw error.str();
            }

            condition = CValueProgramItem::compile(input);

            if (!condition || !input.eatChar(')'))
            {
                stringstream error;
                error << "Syntax error at line " << input.getCurrentLine() << ". " << (condition ? "')'" : "value") << " expected";
                throw error.str();
            }

            bool blockFound = (input.peek() == '{');
            trueBody  = CProgramItem::compile(input, terminated);

            if (!blockFound && !trueBody)
            {
                stringstream error;
                error << "Syntax error at line " << input.getCurrentLine() << ". Statement expected";
                throw error.str();
            }

            if ((blockFound || terminated) && input.useNextWord("else"))
            {
                blockFound = (input.peek() == '{');
                falseBody = CProgramItem::compile(input, terminated);

                if (!blockFound && !falseBody)
                {
                    stringstream error;
                    error << "Syntax error at line " << input.getCurrentLine() << ". Statement expected";
                    throw error.str();
                }
            }
        }
        catch (...)
        {
            delete condition;
            delete trueBody;
            delete falseBody;
            
            throw;
        }

        result = new CIfProgramItem(condition, trueBody, falseBody);
    }

    return result;
}
