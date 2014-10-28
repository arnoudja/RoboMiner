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

#include "stdafx.h"

#include "ConfigFile.h"

#include <fstream>


using namespace std;


CConfigFile::CConfigFile(int argc, char* argv[])
{
    string configFileName = argv[0];
    configFileName.append(".conf");

    ifstream configFile(configFileName.c_str());

    assert(configFile.is_open());

    char nextLine[1024];
    string nextLineString;
    while (!configFile.eof())
    {
        configFile.getline(nextLine, sizeof(nextLine));
        nextLineString = nextLine;

        string itemName = extractItemName(nextLineString);
        
        if (!itemName.empty())
        {
            m_items[itemName] = nextLineString;
        }
    }
}


void CConfigFile::trimString(string& stringToTrim)
{
    int firstPos = stringToTrim.find_first_not_of(" \t\n\r");

    if (firstPos > 0)
    {
        stringToTrim.erase(0, firstPos);
    }

    int lastPos = stringToTrim.find_last_not_of(" \t\n\r");

    if (lastPos > 0 && lastPos < (int)stringToTrim.size())
    {
        stringToTrim.erase(lastPos + 1);
    }
}


string CConfigFile::extractItemName(string& lineString)
{
    string itemName;

    trimString(lineString);

    int firstWhitespace = lineString.find_first_of(" \t");

    if (firstWhitespace > 0)
    {
        itemName = lineString.substr(0, firstWhitespace);
        lineString.erase(0, firstWhitespace + 1);
        trimString(lineString);
    }
    else
    {
        itemName = lineString;
        lineString.clear();
    }

    return itemName;
}


string CConfigFile::getConfigValue(const std::string& configItem)
{
    return m_items[configItem];
}
