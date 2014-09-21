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


function addMiningQueueItem(robotId, miningAreaIdName) {

    document.getElementById("robotId").value = robotId;
    document.getElementById("miningAreaAddId").value = document.getElementById(miningAreaIdName).value;
    document.getElementById("submitType").value = "add";
    document.getElementById("miningqueueform").submit();
}

function removeMiningQueueItems(robotId) {

    if (confirm("Paid fees will be lost. Remove selected items?")) {

        document.getElementById("robotId").value = robotId;
        document.getElementById("submitType").value = "remove";
        document.getElementById("miningqueueform").submit();
    }
}

function showMiningAreaDetails() {

    var prevId = document.getElementById('prevInfoMiningAreaId').value;
    document.getElementById('miningAreaDetails' + prevId).style.display = 'none';
    var newId = document.getElementById('infoMiningAreaId').value;
    document.getElementById('miningAreaDetails' + newId).style.display = 'table-row-group';
    document.getElementById('prevInfoMiningAreaId').value = newId;
}

function selectMiningAreaDetails(miningAreaId) {
    document.getElementById('infoMiningAreaId').value = miningAreaId;
    showMiningAreaDetails();
}
