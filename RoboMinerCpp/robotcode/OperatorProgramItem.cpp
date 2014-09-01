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

#include "OperatorProgramItem.h"
#include "ProgramItemStatus.h"
#include "CallAction.h"
#include "ConstReturnAction.h"
#include "CompileInput.h"

#include <vector>


using namespace std;
using namespace robotcode;


class COperatorStatus : public CProgramItemStatus
{
public:
    COperatorStatus() : m_gotLeft(false)                                        {}
    virtual ~COperatorStatus()                                                  {}

    virtual void processReturnValue(const CValue& value)
    {
        if (!m_gotLeft)
        {
            m_leftValue = value;
        }
        else
        {
            m_rightValue = value;
        }
    }

    void setGotLeft()                                   { m_gotLeft = true; }
    bool hasGotLeft() const                             { return m_gotLeft; }

    CValue calculateDoubleResult(COperatorProgramItem::EOperatorType operatorType) const
    {
        CValue result;

        try
        {
            switch (operatorType)
            {
            case COperatorProgramItem::eAddition:
                result = m_leftValue.getDoubleValue() + m_rightValue.getDoubleValue();
                break;

            case COperatorProgramItem::eSubtraction:
                result = m_leftValue.getDoubleValue() - m_rightValue.getDoubleValue();
                break;

            case COperatorProgramItem::eMultiply:
                result = m_leftValue.getDoubleValue() * m_rightValue.getDoubleValue();
                break;

            case COperatorProgramItem::eDivision:
                result = m_leftValue.getDoubleValue() / m_rightValue.getDoubleValue();
                break;

            case COperatorProgramItem::eLarger:
                result = (m_leftValue.getDoubleValue() > m_rightValue.getDoubleValue());
                break;

            case COperatorProgramItem::eSmaller:
                result = (m_leftValue.getDoubleValue() < m_rightValue.getDoubleValue());
                break;

            case COperatorProgramItem::eLargerEqual:
                result = (m_leftValue.getDoubleValue() >= m_rightValue.getDoubleValue());
                break;

            case COperatorProgramItem::eSmallerEqual:
                result = (m_leftValue.getDoubleValue() <= m_rightValue.getDoubleValue());
                break;

            case COperatorProgramItem::eEqual:
                result = (m_leftValue.getDoubleValue() == m_rightValue.getDoubleValue());
                break;

            case COperatorProgramItem::eAnd:
            case COperatorProgramItem::eOr:
            case COperatorProgramItem::eNot:
                result = calculateBoolResult(operatorType);
                break;

            default:
                result = .0;
                break;
            }
        }
        catch (...)
        {
            // Return undefined in case of arithmetic exceptions (i.e. division by zero)
        }

        return result;
    }


    CValue calculateIntResult(COperatorProgramItem::EOperatorType operatorType) const
    {
        CValue result;

        try
        {
            switch (operatorType)
            {
            case COperatorProgramItem::eAddition:
                result = m_leftValue.getIntValue() + m_rightValue.getIntValue();
                break;

            case COperatorProgramItem::eSubtraction:
                result = m_leftValue.getIntValue() - m_rightValue.getIntValue();
                break;

            case COperatorProgramItem::eMultiply:
                result = m_leftValue.getIntValue() * m_rightValue.getIntValue();
                break;

            case COperatorProgramItem::eDivision:
                result = m_leftValue.getIntValue() / m_rightValue.getIntValue();
                break;

            case COperatorProgramItem::eLarger:
                result = (m_leftValue.getIntValue() > m_rightValue.getIntValue());
                break;

            case COperatorProgramItem::eSmaller:
                result = (m_leftValue.getIntValue() < m_rightValue.getIntValue());
                break;

            case COperatorProgramItem::eLargerEqual:
                result = (m_leftValue.getIntValue() >= m_rightValue.getIntValue());
                break;

            case COperatorProgramItem::eSmallerEqual:
                result = (m_leftValue.getIntValue() <= m_rightValue.getIntValue());
                break;

            case COperatorProgramItem::eEqual:
                result = (m_leftValue.getIntValue() == m_rightValue.getIntValue());
                break;

            case COperatorProgramItem::eAnd:
            case COperatorProgramItem::eOr:
            case COperatorProgramItem::eNot:
                result = calculateBoolResult(operatorType);
                break;

            default:
                result = 0;
                break;
            }
        }
        catch (...)
        {
            // Return undefined in case of arithmetic exceptions (i.e. division by zero)
        }

        return result;
    }


    CValue calculateBoolResult(COperatorProgramItem::EOperatorType operatorType) const
    {
        CValue result;

        try
        {
            switch (operatorType)
            {
            case COperatorProgramItem::eAddition:
                result = m_leftValue.getBoolValue() || m_rightValue.getBoolValue();
                break;

            case COperatorProgramItem::eSubtraction:
                result = m_leftValue.getBoolValue() && !m_rightValue.getBoolValue();
                break;

            case COperatorProgramItem::eMultiply:
                result = m_leftValue.getBoolValue() && m_rightValue.getBoolValue();
                break;

            case COperatorProgramItem::eDivision:
                result = m_leftValue.getBoolValue() && m_rightValue.getBoolValue();
                break;

            case COperatorProgramItem::eLarger:
                result = (m_leftValue.getBoolValue() && !m_rightValue.getBoolValue());
                break;

            case COperatorProgramItem::eSmaller:
                result = (!m_leftValue.getBoolValue() && m_rightValue.getBoolValue());
                break;

            case COperatorProgramItem::eLargerEqual:
                result = (m_leftValue.getBoolValue() || !m_rightValue.getBoolValue());
                break;

            case COperatorProgramItem::eSmallerEqual:
                result = (!m_leftValue.getBoolValue() || m_rightValue.getBoolValue());
                break;

            case COperatorProgramItem::eEqual:
                result = (m_leftValue.getBoolValue() == m_rightValue.getBoolValue());
                break;

            case COperatorProgramItem::eAnd:
                result = (m_leftValue.getBoolValue() && m_rightValue.getBoolValue());
                break;

            case COperatorProgramItem::eOr:
                result = (m_leftValue.getBoolValue() || m_rightValue.getBoolValue());
                break;

            case COperatorProgramItem::eNot:
                result = !(m_rightValue.getBoolValue());
                break;

            default:
                result = false;
                break;
            }
        }
        catch (...)
        {
            // Return undefined in case of arithmetic exceptions (i.e. division by zero)
        }

        return result;
    }


    CValue calculateResult(COperatorProgramItem::EOperatorType operatorType) const
    {
        if (m_leftValue.getValueType() == CValue::eDoubleValue || m_rightValue.getValueType() == CValue::eDoubleValue)
        {
            return calculateDoubleResult(operatorType);
        }
        else if (m_leftValue.getValueType() == CValue::eIntValue || m_rightValue.getValueType() == CValue::eIntValue)
        {
            return calculateIntResult(operatorType);
        }
        else
        {
            return calculateBoolResult(operatorType);
        }
    }


private:
    bool    m_gotLeft;
    CValue  m_leftValue;
    CValue  m_rightValue;
};


COperatorProgramItem::COperatorProgramItem(EOperatorType operatorType, const CValueProgramItem* left, CValueProgramItem* right) :
    m_operatorType(operatorType),
    m_leftValueProgramItem(left),
    m_rightValueProgramItem(right)
{
}


COperatorProgramItem::~COperatorProgramItem()
{
    delete m_leftValueProgramItem;
    delete m_rightValueProgramItem;
}


CProgramAction* COperatorProgramItem::getNextAction(const CRobot* robot, CProgramItemStatus*& status) const
{
    CProgramAction* action = NULL;

    if (!status)
    {
        COperatorStatus* currentStatus = new COperatorStatus();
        
        if (m_leftValueProgramItem)
        {
            action = new CCallAction(m_leftValueProgramItem);
        }
        else
        {
            currentStatus->setGotLeft();
            action = new CCallAction(m_rightValueProgramItem);
        }
        
        status = currentStatus;
    }
    else
    {
        COperatorStatus* currentStatus = dynamic_cast<COperatorStatus*>(status);
        assert(currentStatus);

        if (!currentStatus->hasGotLeft() && m_rightValueProgramItem)
        {
            currentStatus->setGotLeft();
            action = new CCallAction(m_rightValueProgramItem);
        }
        else
        {
            action = new CConstReturnAction(currentStatus->calculateResult(m_operatorType));
        }
    }

    status->adoptProgramAction(action);

    return action;
}


int COperatorProgramItem::size() const
{
    return 1 +
           (m_leftValueProgramItem ? m_leftValueProgramItem->size() : 0) +
           (m_rightValueProgramItem ? m_rightValueProgramItem->size() : 0);
}


CValueProgramItem* COperatorProgramItem::compile(CCompileInput& input)
{
    typedef pair<EOperatorType, CValueProgramItem*> TOperatorValuePair;
    typedef vector<TOperatorValuePair>              TValueItemVector;

    TValueItemVector valueItemVector;

    CValueProgramItem* first = compileSingleValue(input);

    if (first)
    {
        valueItemVector.push_back(TOperatorValuePair(eUndefinedOperator, first));
    }

    bool done = !first;

    try
    {
        while (!done)
        {
            EOperatorType nextOperator = eUndefinedOperator;

            if (input.eatChar('+'))
            {
                nextOperator = eAddition;
            }
            else if (input.eatChar('-'))
            {
                nextOperator = eSubtraction;
            }
            else if (input.eatChar('*'))
            {
                nextOperator = eMultiply;
            }
            else if (input.eatChar('/'))
            {
                nextOperator = eDivision;
            }
            else if (input.eatSequence(">="))
            {
                nextOperator = eLargerEqual;
            }
            else if (input.eatSequence("<="))
            {
                nextOperator = eSmallerEqual;
            }
            else if (input.eatSequence("=="))
            {
                nextOperator = eEqual;
            }
            else if (input.eatChar('>'))
            {
                nextOperator = eLarger;
            }
            else if (input.eatChar('<'))
            {
                nextOperator = eSmaller;
            }
            else if (input.eatSequence("&&"))
            {
                nextOperator = eAnd;
            }
            else if (input.eatSequence("||"))
            {
                nextOperator = eOr;
            }

            if (nextOperator == eUndefinedOperator)
            {
                done = true;
            }
            else
            {
                CValueProgramItem* next = compileSingleValue(input);

                if (!next)
                {
                    stringstream error;
                    error << "Syntax error at line " << input.getCurrentLine() << ". Expression expected";
                    throw error.str();
                }

                valueItemVector.push_back(TOperatorValuePair(nextOperator, next));
            }
        }
    }
    catch (...)
    {
        for (TValueItemVector::iterator iter = valueItemVector.begin(); iter != valueItemVector.end(); ++iter)
        {
            delete iter->second;
        }
        
        throw;
    }

    while (valueItemVector.size() > 1)
    {
        unsigned int i = 1;

        while (i + 1 < valueItemVector.size() && operatorPriority(valueItemVector[i + 1].first) > operatorPriority(valueItemVector[i].first))
        {
            ++i;
        }

        CValueProgramItem* newOperator = new COperatorProgramItem(valueItemVector[i].first, valueItemVector[i - 1].second, valueItemVector[i].second);
        valueItemVector[i - 1].second = newOperator;
        valueItemVector.erase(valueItemVector.begin() + i);
    }

    return valueItemVector.empty() ? NULL : valueItemVector[0].second;
}


CValueProgramItem* COperatorProgramItem::compileSingleValue(CCompileInput& input)
{
    CValueProgramItem* result = NULL;

    if (input.eatChar('('))
    {
        result = CValueProgramItem::compile(input);

        if (!result || !input.eatChar(')'))
        {
            delete result;

            stringstream error;
            error << "Syntax error at line " << input.getCurrentLine() << ". " << (result ? ")" : "expression") << " expected";
            throw error.str();
        }
    }
    else if (input.eatChar('!'))
    {
        CValueProgramItem* value = compileSingleValue(input);

        if (!value)
        {
            stringstream error;
            error << "Syntax error at line " << input.getCurrentLine() << ". expression expected";
            throw error.str();
        }

        result = new COperatorProgramItem(eNot, NULL, value);
    }
    else
    {
        result = CValueProgramItem::compileSingleValue(input);
    }

    return result;
}


int COperatorProgramItem::operatorPriority(EOperatorType operatorType)
{
    int result = 0;

    switch (operatorType)
    {
    case eNot:
        result = 5;
        break;

    case eMultiply:
    case eDivision:
        result = 4;
        break;

    case eAddition:
    case eSubtraction:
        result = 3;
        break;

    case eLarger:
    case eSmaller:
    case eLargerEqual:
    case eSmallerEqual:
    case eEqual:
        result = 2;
        break;

    case eAnd:
    case eOr:
        result = 1;
        break;
            
    default:
        result = 0;
        break;
    }

    return result;
}
