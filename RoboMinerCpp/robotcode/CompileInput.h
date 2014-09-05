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

#include "VariableStorage.h"

#include <string>
#include <sstream>

namespace robotcode
{
    class CValue;

    class CCompileInput
    {
    public:
        CCompileInput(const std::string& source);
        virtual ~CCompileInput()                        {}

        int getCurrentLine() const                      { return m_currentLine; }

        bool useNextWord(const std::string& word);
        std::string useNextWord();
        void returnNextWord(const std::string& word);

        const std::string& getNextWord();
        bool eatChar(int nextChar, bool repeatedly = false);
        bool eatSequence(const std::string& sequence);

        int peek();
        bool eof();

        bool extractConstValue(CValue& value);

        void skipWhitespace();

        CVariableStorage& getVariableStorage()          { return m_variableStorage; }

    protected:
        void extractNextWord();

    private:
        std::stringstream   m_sourceStream;
        std::string         m_nextWord;
        int                 m_currentLine;
        CVariableStorage    m_variableStorage;
    };
}
