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


function rgbToHex(r, g, b) {
    return "#" + ((1 << 24) + (r << 16) + (g << 8) + b).toString(16).slice(1);
}


function smoothen(v1, v2, t, i)
{
    return (v1 * (i - t) + v2 * t) / i;
}


function robotColor(robotNr)
{
    switch (robotNr)
    {
        case 0:
            return '#00a000';
            
        case 1:
            return '#0000ff';
            
        case 2:
            return '#ff0000';
            
        case 3:
            return '#ffff00';
    }
}


function depletedRobotColor(robotNr)
{
    switch (robotNr)
    {
        case 0:
            return '#002000';
            
        case 1:
            return '#000050';
            
        case 2:
            return '#400000';
            
        case 3:
            return '#404000';
    }
}


function drawRobot(robot, scale, turn)
{
    var centerX = robot.x * scale + scale / 2;
    var centerY = robot.y * scale + scale / 2;

    myRallyContext.beginPath();
    myRallyContext.arc(centerX, centerY, robot.size * scale / 2.0, 0, 2.0 * Math.PI, false);
    myRallyContext.fillStyle = turn < robot.maxturns ? robotColor(robot.robotnr) : depletedRobotColor(robot.robotnr);
    myRallyContext.fill();
    myRallyContext.lineWidth = 2;
    myRallyContext.strokeStyle = 'black';
    myRallyContext.stroke();

    var orientation = robot.o * Math.PI / 180.0;

    myRallyContext.beginPath();
    myRallyContext.moveTo(centerX, centerY);
    myRallyContext.lineTo(centerX + scale * robot.size * Math.cos(orientation) / 2.0, centerY + scale * robot.size * Math.sin(orientation) / 2.0);
    myRallyContext.lineWidth = 2;
    myRallyContext.strokeStyle = 'black';
    myRallyContext.stroke();
}


function eraseRobot(robot, scale, step)
{
    var minX = Math.floor(Math.max(0, robot.x - robot.size / 2.0));
    var minY = Math.floor(Math.max(0, robot.y - robot.size / 2.0));

    var maxX = Math.floor(Math.min(myGround.sizeX, minX + robot.size + 3));
    var maxY = Math.floor(Math.min(myGround.sizeY, minY + robot.size + 3));

    drawGroundAt(step, scale, minX, minY, maxX, maxY);
}


function drawRobotOre(robot)
{
    var i = robot.robotnr;
    var borderWidth = 3;
    var oreWidth = myOreCanvas[i].width - 2 * borderWidth;
    var oreHeight = myOreCanvas[i].height - 2 * borderWidth;
    var oreAHeight = Math.floor(robot.A * oreHeight / robot.maxore);
    var oreBHeight = Math.floor((robot.A + robot.B) * oreHeight / robot.maxore) - oreAHeight;
    var oreCHeight = Math.floor((robot.A + robot.B + robot.C) * oreHeight / robot.maxore) - oreAHeight - oreBHeight;
    
    myOreContext[i].beginPath();
    myOreContext[i].rect(0, 0, myOreCanvas[i].width, myOreCanvas[i].height);
    myOreContext[i].fillStyle = robotColor(robot.robotnr);
    myOreContext[i].fill();

    myOreContext[i].beginPath();
    myOreContext[i].rect(borderWidth, borderWidth, oreWidth, myOreCanvas[i].height - 2 * borderWidth);
    myOreContext[i].fillStyle = 'black';
    myOreContext[i].fill();

    myOreContext[i].beginPath();
    myOreContext[i].rect(borderWidth, myOreCanvas[i].height - borderWidth - oreAHeight, oreWidth, oreAHeight);
    myOreContext[i].fillStyle = 'red';
    myOreContext[i].fill();

    myOreContext[i].beginPath();
    myOreContext[i].rect(borderWidth, myOreCanvas[i].height - borderWidth - oreAHeight - oreBHeight, oreWidth, oreBHeight);
    myOreContext[i].fillStyle = 'green';
    myOreContext[i].fill();

    myOreContext[i].beginPath();
    myOreContext[i].rect(borderWidth, myOreCanvas[i].height - borderWidth - oreAHeight - oreBHeight - oreCHeight, oreWidth, oreCHeight);
    myOreContext[i].fillStyle = 'blue';
    myOreContext[i].fill();
}


function drawInitialGround(scale)
{
    myGround.updatedTo = 0;

    myRallyContext.beginPath();
    myRallyContext.rect(0, 0, 600, 600);
    myRallyContext.fillStyle = 'black';
    myRallyContext.fill();

    var oreAMax = typeof myOreTypes.A !== 'undefined' ? myOreTypes.A.max : 255;
    var oreBMax = typeof myOreTypes.B !== 'undefined' ? myOreTypes.B.max : 255;
    var oreCMax = typeof myOreTypes.C !== 'undefined' ? myOreTypes.C.max : 255;

    for (var i = 0; i < myGround.positions.length; i++)
    {
        myGround.positions[i].lastDrawn = 0;

        var x = myGround.positions[i].x;
        var y = myGround.positions[i].y;

        var oreA = myGround.positions[i].changes[0].A;
        var oreB = myGround.positions[i].changes[0].B;
        var oreC = myGround.positions[i].changes[0].C;

        var oreAIntensity = Math.min(255, Math.floor(oreA * 255 / oreAMax));
        var oreBIntensity = Math.min(255, Math.floor(oreB * 255 / oreBMax));
        var oreCIntensity = Math.min(255, Math.floor(oreC * 255 / oreCMax));

        myRallyContext.beginPath();
        myRallyContext.rect(x * scale, y * scale, scale, scale);
        myRallyContext.fillStyle = rgbToHex(oreAIntensity, oreBIntensity, oreCIntensity);
        myRallyContext.fill();
    }
}


function drawGroundAt(step, scale, fromX, fromY, tillX, tillY)
{
    var oreAMax = typeof myOreTypes.A !== 'undefined' ? myOreTypes.A.max : 255;
    var oreBMax = typeof myOreTypes.B !== 'undefined' ? myOreTypes.B.max : 255;
    var oreCMax = typeof myOreTypes.C !== 'undefined' ? myOreTypes.C.max : 255;

    myRallyContext.beginPath();
    myRallyContext.rect(fromX * scale, fromY * scale, (tillX - fromX) * scale, (tillY - fromY) * scale);
    myRallyContext.fillStyle = 'black';
    myRallyContext.fill();

    for (var i = 0; i < myGround.positions.length; i++)
    {
        if (myGround.positions[i].x >= fromX && myGround.positions[i].x < tillX &&
            myGround.positions[i].y >= fromY && myGround.positions[i].y < tillY)
        {
            var x = myGround.positions[i].x;
            var y = myGround.positions[i].y;

            var j = myGround.positions[i].lastDrawn;

            while (myGround.positions[i].changes.length > (j + 1) &&
                   myGround.positions[i].changes[j + 1].t <= step)
            {
                j++;
            }

            myGround.positions[i].lastDrawn = j;

            var oreA = myGround.positions[i].changes[j].A;
            var oreB = myGround.positions[i].changes[j].B;
            var oreC = myGround.positions[i].changes[j].C;

            var oreAIntensity = Math.min(255, Math.floor(oreA * 255 / oreAMax));
            var oreBIntensity = Math.min(255, Math.floor(oreB * 255 / oreBMax));
            var oreCIntensity = Math.min(255, Math.floor(oreC * 255 / oreCMax));

            myRallyContext.beginPath();
            myRallyContext.rect(x * scale, y * scale, scale, scale);
            myRallyContext.fillStyle = rgbToHex(oreAIntensity, oreBIntensity, oreCIntensity);
            myRallyContext.fill();
        }
    }
}


function updateRobotTo(robotNr, step)
{
    if (step > myRobots.robot[robotNr].updatedTo && step < myRobots.robot[robotNr].locations.length)
    {
        updateRobotTo(robotNr, step - 1);

        if (typeof myRobots.robot[robotNr].locations[step].x === 'undefined')
        {
            myRobots.robot[robotNr].locations[step].x = myRobots.robot[robotNr].locations[step - 1].x;
        }
        if (typeof myRobots.robot[robotNr].locations[step].y === 'undefined')
        {
            myRobots.robot[robotNr].locations[step].y = myRobots.robot[robotNr].locations[step - 1].y;
        }
        if (typeof myRobots.robot[robotNr].locations[step].o === 'undefined')
        {
            myRobots.robot[robotNr].locations[step].o = myRobots.robot[robotNr].locations[step - 1].o;
        }
        if (typeof myRobots.robot[robotNr].locations[step].A === 'undefined')
        {
            myRobots.robot[robotNr].locations[step].A = myRobots.robot[robotNr].locations[step - 1].A;
        }
        if (typeof myRobots.robot[robotNr].locations[step].B === 'undefined')
        {
            myRobots.robot[robotNr].locations[step].B = myRobots.robot[robotNr].locations[step - 1].B;
        }
        if (typeof myRobots.robot[robotNr].locations[step].C === 'undefined')
        {
            myRobots.robot[robotNr].locations[step].C = myRobots.robot[robotNr].locations[step - 1].C;
        }

        myRobots.robot[robotNr].updatedTo = step;
    }
}


function updateRobotPosition(robotNr, time, stepTime)
{
    var t1 = Math.floor(time / stepTime);
    var t2 = t1 + 1;

    updateRobotTo(robotNr, t2);

    if (t2 >= myRobots.robot[robotNr].locations.length)
    {
        t1 = myRobots.robot[robotNr].locations.length - 1;
        myRobots.robot[robotNr].x = myRobots.robot[robotNr].locations[t1].x;
        myRobots.robot[robotNr].y = myRobots.robot[robotNr].locations[t1].y;
        myRobots.robot[robotNr].o = myRobots.robot[robotNr].locations[t1].o;
        myRobots.robot[robotNr].A = myRobots.robot[robotNr].locations[t1].A;
        myRobots.robot[robotNr].B = myRobots.robot[robotNr].locations[t1].B;
        myRobots.robot[robotNr].C = myRobots.robot[robotNr].locations[t1].C;
    }
    else
    {
        var dt = time % stepTime;

        if (dt >= stepTime * myRobots.robot[robotNr].locations[t2].t)
        {
            myRobots.robot[robotNr].x = myRobots.robot[robotNr].locations[t2].x;
            myRobots.robot[robotNr].y = myRobots.robot[robotNr].locations[t2].y;
            myRobots.robot[robotNr].o = myRobots.robot[robotNr].locations[t2].o;
            myRobots.robot[robotNr].A = myRobots.robot[robotNr].locations[t2].A;
            myRobots.robot[robotNr].B = myRobots.robot[robotNr].locations[t2].B;
            myRobots.robot[robotNr].C = myRobots.robot[robotNr].locations[t2].C;
        }
        else
        {
            var travelTime = stepTime * myRobots.robot[robotNr].locations[t2].t;
            myRobots.robot[robotNr].x = smoothen(myRobots.robot[robotNr].locations[t1].x, myRobots.robot[robotNr].locations[t2].x, dt, travelTime);
            myRobots.robot[robotNr].y = smoothen(myRobots.robot[robotNr].locations[t1].y, myRobots.robot[robotNr].locations[t2].y, dt, travelTime);
            myRobots.robot[robotNr].o = myRobots.robot[robotNr].locations[t1].o;
            myRobots.robot[robotNr].A = smoothen(myRobots.robot[robotNr].locations[t1].A, myRobots.robot[robotNr].locations[t2].A, dt, travelTime);
            myRobots.robot[robotNr].B = smoothen(myRobots.robot[robotNr].locations[t1].B, myRobots.robot[robotNr].locations[t2].B, dt, travelTime);
            myRobots.robot[robotNr].C = smoothen(myRobots.robot[robotNr].locations[t1].C, myRobots.robot[robotNr].locations[t2].C, dt, travelTime);
        }
    }
}


function animate(scale, startTime, stepTime)
{
    var time = (new Date()).getTime() - startTime;
    var totalSteps = myRobots.robot[0].locations.length;
    var totalTime = totalSteps * stepTime;
    var completed = time / totalTime;
    if (completed > 1.)
    {
        completed = 1.;
    }

    var cycle = Math.floor(time / stepTime);
    if (cycle > totalSteps)
    {
        cycle = totalSteps;
    }
    myCycleText.value = cycle;

    myProgressContext.clearRect(0, 0, myProgressCanvas.width, myProgressCanvas.height);

    myProgressContext.beginPath();
    myProgressContext.rect(0, 0, 600 * completed, 20);
    myProgressContext.fillStyle = 'red';
    myProgressContext.fill();
    myProgressContext.lineWidth = 1;
    myProgressContext.strokeStyle = 'black';
    myProgressContext.stroke();

    for (var i = 0; i < myRobots.robot.length; i++)
    {
        eraseRobot(myRobots.robot[i], scale, cycle);
    }

    for (var i = 0; i < myRobots.robot.length; i++)
    {
        updateRobotPosition(i, time, stepTime);
        drawRobot(myRobots.robot[i], scale, cycle);
        drawRobotOre(myRobots.robot[i]);
    }

    if (time <= totalTime)
    {
        requestAnimFrame(function() {
                            animate(scale, startTime, stepTime);
                        } );
    }
}


function runanimation()
{
    var scaleX = 600 / myGround.sizeX;
    var scaleY = 600 / myGround.sizeY;

    var scale = scaleX < scaleY ? scaleX : scaleY;

    drawInitialGround(scale);

    for (var i = 0; i < myRobots.robot.length; i++)
    {
        myRobots.robot[i].updatedTo = 0;
        drawRobot(myRobots.robot[i], scale, 0);
        drawRobotOre(myRobots.robot[i]);
        myCycleText.value = "0";
    }

    setTimeout(function() {
                    var startTime = (new Date()).getTime();
                    animate(scale, startTime, 50);
                }, 1000);
}
