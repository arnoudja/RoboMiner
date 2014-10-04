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

#include <mysql.h>
#include <list>
#include <string>

#define MAX_BIND_PARAMETERS 20
#define MAX_BIND_RESULTS    20


class CDatabaseStatement
{
public:
    CDatabaseStatement(MYSQL* connection, const std::string& query);
    virtual ~CDatabaseStatement();

    void addIntParameterValue(int parameterValue);
    void addDoubleParameterValue(double parameterValue);
    void addTimestampParameterValue(MYSQL_TIME parameterValue);
    void addStringParameterValue(const char* parameterValue, unsigned int length);
    void execute();

    int getInsertId();
    
    void bindIntResult(int* resultValue);
    void bindDoubleResult(double* resultValue);
    void bindTimestampResult(MYSQL_TIME* resultValue);
    void bindStringResult(char* resultValue, int maxLength);

    bool fetch();

private:
    class CStringBindResult
    {
    public:
        CStringBindResult(MYSQL_BIND& bind, char* resultValue, int maxLength);
        virtual ~CStringBindResult();

        void processFetchResult();

    private:
        char*           m_buffer;
        unsigned long*  m_bindResultLength;
        my_bool*        m_bindResultIsNull;
        my_bool*        m_bindResultIsError;
    };

    MYSQL_STMT* m_statement;
    std::string m_sqlStatement;

    int         m_currentBindParameter;
    MYSQL_BIND  m_bindParameters[MAX_BIND_PARAMETERS];
    int         m_intParameters[MAX_BIND_PARAMETERS];
    double      m_doubleParameters[MAX_BIND_PARAMETERS];
    MYSQL_TIME  m_timestampParameters[MAX_BIND_PARAMETERS];

    bool            m_resultsBound;
    int             m_currentBindResult;
    MYSQL_BIND      m_bindResults[MAX_BIND_RESULTS];

    std::list<CStringBindResult*>   m_stringBindResultList;
};
