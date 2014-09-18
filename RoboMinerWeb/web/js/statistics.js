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

function showStatisticsType(statisticsType) {

    document.getElementById('totalStatistics').style.display = (statisticsType === 'totalStatistics') ? 'inherit' : 'none';
    document.getElementById('lastRuns').style.display = (statisticsType === 'lastRuns') ? 'inherit' : 'none';
    document.getElementById('today').style.display = (statisticsType === 'today') ? 'inherit' : 'none';
    document.getElementById('yesterday').style.display = (statisticsType === 'yesterday') ? 'inherit' : 'none';
    document.getElementById('lastweek').style.display = (statisticsType === 'lastweek') ? 'inherit' : 'none';
}