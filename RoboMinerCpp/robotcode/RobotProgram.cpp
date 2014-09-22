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

#include "RobotProgram.h"

#include "ProgramItem.h"

#include "ProgramAction.h"
#include "MineAction.h"
#include "MoveAction.h"
#include "RotateAction.h"
#include "DumpAction.h"
#include "CallAction.h"
#include "SetVariableAction.h"
#include "ReturnAction.h"
#include "ValueReturnAction.h"

#include "CompileInput.h"


using namespace std;
using namespace robotcode;


CRobotProgram::CRobotProgram(int robotId,
                             const string& source,
                             int maxTurns, int maxOre,
                             int miningSpeed, int cpuSpeed,
                             double forwardSpeed, double backwardSpeed, int rotateSpeed,
                             int robotSize) :
    CRobot(robotId, maxTurns, maxOre,
           miningSpeed, cpuSpeed,
           forwardSpeed, backwardSpeed, rotateSpeed,
           robotSize),
    m_program(NULL),
    m_currentStep(NULL),
    m_currentStatus(NULL)
{
    bool terminated;
    CCompileInput inputSource(source);

    m_program = CProgramItem::compile(inputSource, terminated);
}


CRobotProgram::~CRobotProgram()
{
    while (!m_stack.empty())
    {
        delete m_stack.top().second;
        m_stack.pop();
    }

    delete m_currentStatus;
    delete m_program;
}


CRobot::RobotAction CRobotProgram::getNextAction()
{
    RobotAction robotAction;
    int stepsDone = 0;

    robotAction.action = eWait;

    while (robotAction.action == eWait && stepsDone++ < getCpuSpeed())
    {
        if (!m_currentStep)
        {
            delete m_currentStatus;
            m_currentStatus = NULL;

            m_currentStep   = m_program;
        }

        CProgramAction* programAction = m_currentStep->getNextAction(this, m_currentStatus);

        CMineAction*        mineAction          = dynamic_cast<CMineAction*>(programAction);
        CMoveAction*        moveAction          = dynamic_cast<CMoveAction*>(programAction);
        CRotateAction*      rotateAction        = dynamic_cast<CRotateAction*>(programAction);
        CDumpAction*        dumpAction          = dynamic_cast<CDumpAction*>(programAction);
        CCallAction*        callAction          = dynamic_cast<CCallAction*>(programAction);
        CReturnAction*      returnAction        = dynamic_cast<CReturnAction*>(programAction);
        CValueReturnAction* valueReturnAction   = dynamic_cast<CValueReturnAction*>(programAction);
        CSetVariableAction* setVariableAction   = dynamic_cast<CSetVariableAction*>(programAction);

        if (mineAction)
        {
            robotAction.action = eMine;
        }
        else if (moveAction)
        {
            if (moveAction->getDistance() > .0)
            {
                robotAction.action = eForward;
                if (moveAction->getDistance() >= getForwardSpeed())
                {
                    moveAction->traveled(getForwardSpeed());
                }
                else
                {
                    setTimeFraction(moveAction->getDistance() / getForwardSpeed());
                    moveAction->traveled(moveAction->getDistance());
                }
            }
            else if (moveAction->getDistance() < .0)
            {
                robotAction.action = eBackward;
                if (-moveAction->getDistance() >= getBackwardSpeed())
                {
                    moveAction->traveled(-getBackwardSpeed());
                }
                else
                {
                    setTimeFraction(-moveAction->getDistance() / getBackwardSpeed());
                    moveAction->traveled(moveAction->getDistance());
                }
            }
        }
        else if (rotateAction)
        {
            if (rotateAction->getRotation() > .0)
            {
                robotAction.action = eRotateRight;
                if (rotateAction->getRotation() >= getRotateSpeed())
                {
                    rotateAction->rotated(getRotateSpeed());
                }
                else
                {
                    setTimeFraction((double)rotateAction->getRotation() / (double)getRotateSpeed());
                    rotateAction->rotated(rotateAction->getRotation());
                }
            }
            else if (rotateAction->getRotation() < .0)
            {
                robotAction.action = eRotateLeft;
                if (-rotateAction->getRotation() >= getRotateSpeed())
                {
                    rotateAction->rotated(-getRotateSpeed());
                }
                else
                {
                    setTimeFraction((double)-rotateAction->getRotation() / (double)getRotateSpeed());
                    rotateAction->rotated(rotateAction->getRotation());
                }
            }
        }
        else if (dumpAction)
        {
            robotAction.action    = eDump;
            robotAction.parameter = dumpAction->getOreType();
        }
        else if (callAction)
        {
            m_stack.push(TStackItem(m_currentStep, m_currentStatus));
            m_currentStep   = callAction->getProgramItem();
            m_currentStatus = NULL;

            m_variableStorage.setScopeDepth(m_stack.size());
        }
        else if (returnAction)
        {
            CProgramItemStatus* previousStatus = m_currentStatus;

            if (!m_stack.empty())
            {
                m_currentStep   = m_stack.top().first;
                m_currentStatus = m_stack.top().second;
                m_stack.pop();

                if (valueReturnAction)
                {
                    m_currentStep->processReturnValue(m_currentStatus, valueReturnAction->getValue(*this));
                }
            }
            else
            {
                m_currentStep   = NULL;
                m_currentStatus = NULL;
            }

            delete previousStatus;

            m_variableStorage.setScopeDepth(m_stack.size());
        }
        else if (setVariableAction)
        {
            if (setVariableAction->isCreate())
            {
                m_variableStorage.addVariable(setVariableAction->getVariableName(), setVariableAction->getVariableCreateType(), setVariableAction->getValue());
            }
            else
            {
                m_variableStorage.updateValue(setVariableAction->getVariableName(), setVariableAction->getValue());
            }
        }
    }

    return robotAction;
}
