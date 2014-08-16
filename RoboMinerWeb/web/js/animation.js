
function rgbToHex(r, g, b) {
    return "#" + ((1 << 24) + (r << 16) + (g << 8) + b).toString(16).slice(1);
}


function smoothen(v1, v2, t, i)
{
    return (v1 * (i - t) + v2 * t) / i;
}


function drawRobot(robot, scale)
{
    var centerX = robot.x * scale + scale / 2;
    var centerY = robot.y * scale + scale / 2;

    myRallyContext.beginPath();
    myRallyContext.arc(centerX, centerY, robot.size * scale / 2, 0, 2 * Math.PI, false);
    myRallyContext.fillStyle = robot.color;
    myRallyContext.fill();
    myRallyContext.lineWidth = 2;
    myRallyContext.strokeStyle = 'black';
    myRallyContext.stroke();

    var orientation = robot.o * Math.PI / 180.0;

    myRallyContext.beginPath();
    myRallyContext.moveTo(centerX, centerY);
    myRallyContext.lineTo(centerX + scale * robot.size * Math.sin(orientation) / 2.0, centerY + scale * robot.size * Math.cos(orientation) / 2.0);
    myRallyContext.lineWidth = 2;
    myRallyContext.strokeStyle = 'black';
    myRallyContext.stroke();
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
    myOreContext[i].fillStyle = robot.color;
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


function drawGround(step, scale)
{
    myRallyContext.beginPath();
    myRallyContext.rect(0, 0, 600, 600);
    myRallyContext.fillStyle = 'black';
    myRallyContext.fill();

    for (i = 0; i < myGround.positions.length; i++)
    {
        var x = myGround.positions[i].x;
        var y = myGround.positions[i].y;

        var oreA = 0;
        var oreB = 0;
        var oreC = 0;
        for (j = 0; j < myGround.positions[i].changes.length; j++)
        {
            if (myGround.positions[i].changes[j].t <= step)
            {
                oreA = myGround.positions[i].changes[j].A;
                oreB = myGround.positions[i].changes[j].B;
                oreC = myGround.positions[i].changes[j].C;
            }
        }

        myRallyContext.beginPath();
        myRallyContext.rect(x * scale, y * scale, scale, scale);
        myRallyContext.fillStyle = rgbToHex(oreA > 255 ? 255 : oreA, oreB > 255 ? 255 : oreB, oreC > 255 ? 255 : oreC);
        myRallyContext.fill();
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

    myRallyContext.clearRect(0, 0, myRallyCanvas.width, myRallyCanvas.height);
    myProgressContext.clearRect(0, 0, myProgressCanvas.width, myProgressCanvas.height);

    myProgressContext.beginPath();
    myProgressContext.rect(0, 0, 600 * completed, 20);
    myProgressContext.fillStyle = 'red';
    myProgressContext.fill();
    myProgressContext.lineWidth = 1;
    myProgressContext.strokeStyle = 'black';
    myProgressContext.stroke();

    drawGround(Math.floor(time / stepTime), scale);

    for (i = 0; i < myRobots.robot.length; i++)
    {
        updateRobotPosition(i, time, stepTime);
        drawRobot(myRobots.robot[i], scale);
        drawRobotOre(myRobots.robot[i]);
    }

    requestAnimFrame(function() {
                        animate(scale, startTime, stepTime);
                    } );
}


function runanimation()
{
    var scaleX = 600 / myGround.sizeX;
    var scaleY = 600 / myGround.sizeY;

    var scale = scaleX < scaleY ? scaleX : scaleY;

    drawGround(0, scale);

    for (i = 0; i < myRobots.robot.length; i++)
    {
        myRobots.robot[i].updatedTo = 0;
        drawRobot(myRobots.robot[i], scale);
        drawRobotOre(myRobots.robot[i]);
        myCycleText.value = "0";
    }

    setTimeout(function() {
                    var startTime = (new Date()).getTime();
                    animate(scale, startTime, 50);
                }, 1000);
}
