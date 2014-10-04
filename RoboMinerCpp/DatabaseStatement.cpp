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

#include "DatabaseStatement.h"

#include <cstring>


using namespace std;


CDatabaseStatement::CDatabaseStatement(MYSQL* connection, const string& query)
{
    m_statement = mysql_stmt_init(connection);
    assert(m_statement);

    m_sqlStatement = query;
    int status = mysql_stmt_prepare(m_statement, m_sqlStatement.c_str(), m_sqlStatement.size());
    assert(status == 0);

    m_currentBindParameter = 0;
    memset(m_bindParameters, 0, sizeof(m_bindParameters));

    m_resultsBound = false;
    m_currentBindResult = 0;
    memset(m_bindResults, 0, sizeof(m_bindResults));
}


CDatabaseStatement::~CDatabaseStatement()
{
    mysql_stmt_close(m_statement);
    
    for (std::list<CStringBindResult*>::iterator iter = m_stringBindResultList.begin();
         iter != m_stringBindResultList.end(); ++iter)
    {
        delete *iter;
    }
}


void CDatabaseStatement::addIntParameterValue(int parameterValue)
{
    assert(m_currentBindParameter < MAX_BIND_PARAMETERS);

    m_intParameters[m_currentBindParameter] = parameterValue;

    m_bindParameters[m_currentBindParameter].buffer_type   = MYSQL_TYPE_LONG;
    m_bindParameters[m_currentBindParameter].buffer_length = sizeof(parameterValue);
    m_bindParameters[m_currentBindParameter].buffer        = &(m_intParameters[m_currentBindParameter]);

    ++m_currentBindParameter;
}


void CDatabaseStatement::addDoubleParameterValue(double parameterValue)
{
    assert(m_currentBindParameter < MAX_BIND_PARAMETERS);

    m_doubleParameters[m_currentBindParameter] = parameterValue;

    m_bindParameters[m_currentBindParameter].buffer_type   = MYSQL_TYPE_DOUBLE;
    m_bindParameters[m_currentBindParameter].buffer_length = sizeof(parameterValue);
    m_bindParameters[m_currentBindParameter].buffer        = &(m_doubleParameters[m_currentBindParameter]);

    ++m_currentBindParameter;
}


void CDatabaseStatement::addTimestampParameterValue(MYSQL_TIME parameterValue)
{
    assert(m_currentBindParameter < MAX_BIND_PARAMETERS);

    m_timestampParameters[m_currentBindParameter] = parameterValue;

    m_bindParameters[m_currentBindParameter].buffer_type   = MYSQL_TYPE_TIMESTAMP;
    m_bindParameters[m_currentBindParameter].buffer_length = sizeof(parameterValue);
    m_bindParameters[m_currentBindParameter].buffer        = &(m_timestampParameters[m_currentBindParameter]);

    ++m_currentBindParameter;
}


void CDatabaseStatement::addStringParameterValue(const char* parameterValue, unsigned int length)
{
    assert(m_currentBindParameter < MAX_BIND_PARAMETERS);

    m_bindParameters[m_currentBindParameter].buffer_type   = MYSQL_TYPE_STRING;
    m_bindParameters[m_currentBindParameter].buffer_length = length;
    m_bindParameters[m_currentBindParameter].buffer        = const_cast<char*>(parameterValue);

    ++m_currentBindParameter;
}


void CDatabaseStatement::execute()
{
    if (m_currentBindParameter > 0)
    {
        int status = mysql_stmt_bind_param(m_statement, m_bindParameters);
        assert(status == 0);
    }

    int status = mysql_stmt_execute(m_statement);
    assert(status == 0);
}


int CDatabaseStatement::getInsertId()
{
    return mysql_stmt_insert_id(m_statement);
}


void CDatabaseStatement::bindIntResult(int* resultValue)
{
    assert(m_currentBindResult < MAX_BIND_RESULTS);
    assert(resultValue);

    m_bindResults[m_currentBindResult].buffer_type   = MYSQL_TYPE_LONG;
    m_bindResults[m_currentBindResult].buffer_length = sizeof(int);
    m_bindResults[m_currentBindResult].buffer        = resultValue;

    ++m_currentBindResult;
}


void CDatabaseStatement::bindDoubleResult(double* resultValue)
{
    assert(m_currentBindResult < MAX_BIND_RESULTS);
    assert(resultValue);

    m_bindResults[m_currentBindResult].buffer_type   = MYSQL_TYPE_DOUBLE;
    m_bindResults[m_currentBindResult].buffer_length = sizeof(double);
    m_bindResults[m_currentBindResult].buffer        = resultValue;

    ++m_currentBindResult;
}


void CDatabaseStatement::bindTimestampResult(MYSQL_TIME* resultValue)
{
    assert(m_currentBindResult < MAX_BIND_RESULTS);
    assert(resultValue);

    m_bindResults[m_currentBindResult].buffer_type   = MYSQL_TYPE_TIMESTAMP;
    m_bindResults[m_currentBindResult].buffer_length = sizeof(MYSQL_TYPE_TIMESTAMP);
    m_bindResults[m_currentBindResult].buffer        = resultValue;

    ++m_currentBindResult;
}


void CDatabaseStatement::bindStringResult(char* resultValue, int maxLength)
{
    assert(m_currentBindResult < MAX_BIND_RESULTS);
    assert(resultValue);

    CStringBindResult* stringBindResult =
            new CStringBindResult(m_bindResults[m_currentBindResult],
                                       resultValue, maxLength);

    m_stringBindResultList.push_back(stringBindResult);

    ++m_currentBindResult;
}


bool CDatabaseStatement::fetch()
{
    if (!m_resultsBound)
    {
        assert(m_currentBindResult > 0);

        int status = mysql_stmt_bind_result(m_statement, m_bindResults);
        assert(status == 0);

        status = mysql_stmt_store_result(m_statement);
        assert(status == 0);

        m_resultsBound = true;
    }

    bool result = (mysql_stmt_fetch(m_statement) == 0);

    if (result)
    {
        for (list<CStringBindResult*>::iterator iter = m_stringBindResultList.begin();
             iter != m_stringBindResultList.end(); ++iter)
        {
            (*iter)->processFetchResult();
        }
    }

    return result;
}


CDatabaseStatement::CStringBindResult::CStringBindResult(MYSQL_BIND& bind, char* resultValue, int maxLength)
{
    m_buffer            = resultValue;
    m_bindResultLength  = new unsigned long;
    *m_bindResultLength = 0;
    m_bindResultIsNull  = new my_bool;
    m_bindResultIsError = new my_bool;

    bind.buffer_type    = MYSQL_TYPE_STRING;
    bind.buffer_length  = maxLength;
    bind.buffer         = m_buffer;
    bind.length         = m_bindResultLength;
    bind.is_null        = m_bindResultIsNull;
    bind.error          = m_bindResultIsError;
}


CDatabaseStatement::CStringBindResult::~CStringBindResult()
{
    delete m_bindResultLength;
    delete m_bindResultIsNull;
    delete m_bindResultIsError;
}


void CDatabaseStatement::CStringBindResult::processFetchResult()
{
    if ((*m_bindResultIsNull) || (*m_bindResultIsError))
    {
        m_buffer[0] = '\0';
    }
}
