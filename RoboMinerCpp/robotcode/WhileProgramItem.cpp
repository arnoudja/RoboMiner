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

#include "WhileProgramItem.h"
#include "CallAction.h"
#include "ReturnAction.h"
#include "CompileInput.h"
#include "SequenceProgramItem.h"

#include <sstream>


using namespace std;
using namespace robotcode;


class CWhileStatus : public CProgramItemStatus
{
public:
    CWhileStatus(bool startEvaluating) : m_isEvaluating(startEvaluating)    {}
    virtual ~CWhileStatus()                                                 {}

    bool isEvaluating() const                   { return m_isEvaluating; }
    void setEvaluating(bool evaluating)         { m_isEvaluating = evaluating; }

private:
    bool m_isEvaluating;
};


CWhileProgramItem::CWhileProgramItem(const CValueProgramItem* condition, const CProgramItem* body, bool isDoWhile) :
    m_condition(condition),
    m_body(body),
    m_isDoWhile(isDoWhile)
{
}


CWhileProgramItem::~CWhileProgramItem()
{
    delete m_condition;
    delete m_body;
}


CProgramAction* CWhileProgramItem::getNextAction(CProgramItemStatus*& status) const
{
    CWhileStatus* currentStatus = dynamic_cast<CWhileStatus*>(status);
    assert(currentStatus || !status);

    if (!status)
    {
        currentStatus = new CWhileStatus(m_isDoWhile);
        currentStatus->setValue(true);
        status = currentStatus;
    }

    CProgramAction* action = NULL;

    if (currentStatus->isEvaluating())
    {
        if (currentStatus->getValue().getBoolValue())
        {
            if (m_body)
            {
                action = new CCallAction(m_body);
                currentStatus->setEvaluating(false);
            }
            else
            {
                action = new CCallAction(m_condition);
            }
        }
    }
    else if (m_condition)
    {
        action = new CCallAction(m_condition);
        currentStatus->setEvaluating(true);
    }

    if (!action)
    {
        action = new CReturnAction();
    }

    currentStatus->adoptProgramAction(action);

    return action;
}


int CWhileProgramItem::size() const
{
    return 1 +
           (m_condition ? m_condition->size() : 0) +
           (m_body ? m_body->size() : 0);
}


CWhileProgramItem* CWhileProgramItem::compile(CCompileInput& input, bool& terminated)
{
    CWhileProgramItem* result = NULL;

    CValueProgramItem* condition = NULL;
    CProgramItem*      body      = NULL;

    try
    {
        if (input.useNextWord("while"))
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

            body = CProgramItem::compile(input, terminated);

            result = new CWhileProgramItem(condition, body);
        }
        else if (input.useNextWord("do"))
        {
            if (input.peek() != '{')
            {
                stringstream error;
                error << "Syntax error at line " << input.getCurrentLine() << ". '{' expected";
                throw error.str();
            }

            body = CSequenceProgramItem::compile(input, terminated);

            if (!input.useNextWord("while"))
            {
                stringstream error;
                error << "Syntax error at line " << input.getCurrentLine() << ". 'while' expected";
                throw error.str();
            }

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

            result = new CWhileProgramItem(condition, body, true);

            terminated = input.eatChar(';');
        }
    }
    catch (...)
    {
        delete condition;
        delete body;

        throw;
    }

    return result;
}
