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

function hasUnsavedChanges() {
    return (document.getElementById('sourceCode').value !== document.getElementById('sourceCodeOrig').value ||
            document.getElementById('sourceName').value !== document.getElementById('sourceNameOrig').value);
}

function selectOtherSource() {
    var saveData = false;
    if (hasUnsavedChanges()) {
        if (confirm("Save changes?")) {
            saveData = true;
        }
    }

    window.onbeforeunload = function() {};

    if (saveData) {
        document.getElementById('nextProgramSourceId').value = document.getElementById('programSourceId').value;
        document.getElementById('editCodeForm').submit();
    }
    else {
        document.getElementById('changeProgramSourceForm').submit();
    }
}

function submitData() {
    var sourceName = document.getElementById('sourceName').value;
    var sourceCode = document.getElementById('sourceCode').value;
    if (sourceName !== null && sourceName !== "" &&
        sourceCode !== null && sourceCode !== "") {
        window.onbeforeunload = function() {};
        document.getElementById('editCodeForm').submit();
    }
}

function confirmLooseChanges() {

    if (hasUnsavedChanges()) {
        return "Unsaved changes will be lost";
    }
}

function eraseProgram(programSourceId) {

    if (confirm("This will permanently delete this program. Are you sure?")) {

        document.getElementById("eraseProgramSourceId").value = programSourceId;
        document.getElementById("eraseProgramSourceForm").submit();
    }
}
