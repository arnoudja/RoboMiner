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


function addMiningQueueItem() {
    var robotId = parseInt(document.getElementById('robotId').value);

    if (robotQueueSize(robotId) >= 10) {
        alert('Maximum queue size reached for this robot.');
    }
    else {
        document.getElementById("submitType").value = "add";
        document.getElementById("addqueueform").submit();
    }
}

function removeMiningQueueItems() {
    if (confirm("Paid fees will be lost. Remove selected items?")) {
        document.getElementById("submitType").value = "remove";
        document.getElementById("addqueueform").submit();
    }
}

function showMiningAreaDetails() {
    var prevId = document.getElementById('prevMiningAreaId').value;
    hidePart('miningAreaDetails' + prevId);
    var newId = document.getElementById('miningAreaId').value;
    showPart('miningAreaDetails' + newId);
    document.getElementById('prevMiningAreaId').value = newId;
}
