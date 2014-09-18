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

function showRobotParts() {

    var prevRobotPartTypeId = document.getElementById('selectedRobotPartTypeId').value;
    var prevTierId = document.getElementById('selectedTierId').value;
    for (i = 0; i < 99; ++i) {
        updateDisplayStyleIfExists('robotPartTypeRow' + prevRobotPartTypeId + '_' + prevTierId + '_' + i, 'none');
    }
    var robotPartTypeId = document.getElementById('robotPartTypeId').value;
    var tierId = document.getElementById('tierId').value;
    for (i = 0; i < 99; ++i) {
        updateDisplayStyleIfExists('robotPartTypeRow' + robotPartTypeId + '_' + tierId + '_' + i, 'table-row-group');
    }
    document.getElementById('selectedRobotPartTypeId').value = robotPartTypeId;
    document.getElementById('selectedTierId').value = tierId;
}

function buyItem(robotPartId, robotPartName) {

    if (confirm("Buy '" + robotPartName + "'?")) {

        document.getElementById('buyRobotPartId').value = robotPartId;
        document.getElementById('buySellRobotPartForm').submit();
    }
}

function sellItem(robotPartId, robotPartName) {

    if (confirm("Selling will return half the original price. Sell '" + robotPartName + "'?")) {

        document.getElementById('sellRobotPartId').value = robotPartId;
        document.getElementById('buySellRobotPartForm').submit();
    }
}

