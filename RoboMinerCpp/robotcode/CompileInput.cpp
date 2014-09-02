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
#include "CompileInput.h"

#include "Value.h"


using namespace std;
using namespace robotcode;


CCompileInput::CCompileInput(const std::string& source) :
    m_sourceStream("{" + source + "\n}", ios_base::in),
    m_currentLine(1)
{
    extractNextWord();
}


bool CCompileInput::useNextWord(const std::string& word)
{
    bool result = false;

    if (getNextWord() == word)
    {
        result = true;
        m_nextWord.clear();
    }

    return result;
}


string CCompileInput::useNextWord()
{
    string result = getNextWord();

    m_nextWord.clear();

    return result;
}


const string& CCompileInput::getNextWord()
{
    if (m_nextWord.empty())
    {
        extractNextWord();
    }

    return m_nextWord;
}


bool CCompileInput::eatChar(int nextChar, bool repeatedly)
{
    bool result = false;

    while (peek() == nextChar && (repeatedly || !result))
    {
        result = true;

        if (!m_nextWord.empty())
        {
            m_nextWord.erase(0, 1);
        }
        else
        {
            m_sourceStream.get();
        }
    }

    return result;
}


bool CCompileInput::eatSequence(const std::string& sequence)
{
    bool result = false;

    if (!m_nextWord.empty())
    {
        if (m_nextWord.substr(0, sequence.size()) == sequence)
        {
            result = true;
            m_nextWord.erase(0, sequence.size());
        }
    }
    else
    {
        skipWhitespace();

        unsigned int i = 0;
        while (i < sequence.size() && m_sourceStream.peek() == sequence.at(i))
        {
            m_sourceStream.get();
            ++i;
        }

        if (i == sequence.size())
        {
            result = true;
        }
        else
        {
            while (i > 0)
            {
                m_sourceStream.putback(sequence.at(--i));
            }
        }
    }

    return result;
}


int CCompileInput::peek()
{
    int result = 0;

    if (m_nextWord.empty())
    {
        skipWhitespace();

        result = m_sourceStream.peek();
    }
    else
    {
        result = m_nextWord.at(0);
    }

    return result;
}


bool CCompileInput::eof()
{
    skipWhitespace();

    return m_sourceStream.eof();
}


void CCompileInput::extractNextWord()
{
    skipWhitespace();

    m_nextWord.clear();

    bool charAdded = false;

    do
    {
        charAdded = false;

        int nextChar = m_sourceStream.peek();

        if ((nextChar >= 'A' && nextChar <= 'Z') ||
            (nextChar >= 'a' && nextChar <= 'z') ||
            (nextChar == '_') ||
            (!m_nextWord.empty() && nextChar >= '0' && nextChar <= '9'))
        {
            charAdded = true;
            m_nextWord.append(1, (char)m_sourceStream.get());
        }
    } while (charAdded);
}


bool CCompileInput::extractConstValue(CValue& value)
{
    bool result = false;

    getNextWord();

    if (m_nextWord == "false")
    {
        value = false;
        result = true;
        m_nextWord.clear();
    }
    else if (m_nextWord == "true")
    {
        value = true;
        result = true;
        m_nextWord.clear();
    }
    else if (m_nextWord.empty())
    {
        int decimalFactor  = 0;
        int intValue       = 0;
        double doubleValue = .0;
        bool negative = false;

        bool charUsed = false;

        do
        {
            charUsed = false;

            int nextChar = m_sourceStream.peek();

            if (nextChar == '-' && !negative && !result)
            {
                negative = true;
                charUsed = true;

                m_sourceStream.get();
            }
            else if (nextChar == '.' && !decimalFactor)
            {
                result        = true;
                decimalFactor = 1;
                charUsed      = true;

                m_sourceStream.get();

                doubleValue = intValue;
            }
            else if (nextChar >= '0' && nextChar <= '9')
            {
                result   = true;
                charUsed = true;

                if (decimalFactor)
                {
                    decimalFactor *= 10;
                    doubleValue += (nextChar - '0') / (double)decimalFactor;
                }
                else
                {
                    intValue *= 10;
                    intValue += (nextChar - '0');
                }

                m_sourceStream.get();
            }
        } while (charUsed);

        if (result)
        {
            if (negative)
            {
                doubleValue *= -1;
                intValue    *= -1;
            }

            value = decimalFactor ? doubleValue : intValue;
            extractNextWord();
        }
        else if (negative)
        {
            m_sourceStream.putback('-');
        }
    }

    return result;
}


void CCompileInput::skipWhitespace()
{
    bool skip = false;

    do
    {
        skip = false;

        int nextChar = m_sourceStream.peek();

        switch (nextChar)
        {
        case ' ':
        case '\t':
        case '\r':
            skip = true;
            break;

        case '\n':
            skip = true;
            ++m_currentLine;
            break;

        case '/':
            // Treat '//' as comment till the end of line
            m_sourceStream.get();
            if (m_sourceStream.peek() == '/')
            {
                while (!m_sourceStream.eof() && m_sourceStream.peek() != '\n')
                {
                    m_sourceStream.get();
                }

                ++m_currentLine;
                skip = true;
            }
            else
            {
                m_sourceStream.putback('/');
                skip = false;
            }
            break;
        }

        if (skip)
        {
            m_sourceStream.get();
        }
    } while (skip);
}
