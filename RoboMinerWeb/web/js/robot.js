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

function getAvailableMemory(robotId) {

    var memoryModuleId = document.getElementById('memoryModuleId' + robotId).value;

    return Number(document.getElementById('memoryModuleSize' + memoryModuleId).value);
}

function getUsedMemory(robotId) {

    var programSourceId = document.getElementById('programSourceId' + robotId).value;

    return Number(document.getElementById('programSize' + programSourceId).value);
}

function updateMemorySizes() {

    var robotId = document.getElementById('robotId').value;
    var availableMemory = getAvailableMemory(robotId);
    var usedMemory = getUsedMemory(robotId);

    document.getElementById('memoryParameters' + robotId).innerHTML = usedMemory + '/' + availableMemory;
    document.getElementById('memoryParameters' + robotId).className = (availableMemory >= usedMemory ? 'valid' : 'invalid');
}

function showRobotDetails() {

    var prevRobotId = document.getElementById('prevRobotId').value;
    var detailsElement = document.getElementById('robotDetails' + prevRobotId);
    if (detailsElement !== null) {
        detailsElement.style.display = 'none';
    }
    var robotId = document.getElementById('robotId').value;
    detailsElement = document.getElementById('robotDetails' + robotId);
    if (detailsElement !== null) {
        detailsElement.style.display = 'table-row-group';
    }
    document.getElementById('prevRobotId').value = robotId;
    updateMemorySizes();
}

function applyChanges() {

    var robotId = document.getElementById('robotId').value;
    var availableMemory = getAvailableMemory(robotId);
    var usedMemory = getUsedMemory(robotId);
    var robotName = document.getElementById('robotName' + robotId).value;
    var robotNameRegExp = new RegExp('^[A-Za-z0-9_]{1,10}$');

    if (!robotNameRegExp.test(robotName)) {
        alert("Invalid robot name.");
    }
    else if (usedMemory > availableMemory) {
        alert("Not enough memory available!");
    }
    else {
        document.getElementById('robotForm').submit();
    }
}
