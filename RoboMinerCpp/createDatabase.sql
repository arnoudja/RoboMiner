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

use RoboMiner;

SET storage_engine=InnoDB;

drop table if exists MiningOreResult;
drop table if exists MiningQueue;
drop table if exists RallyResult;
drop table if exists MiningAreaOreSupply;
drop table if exists MiningArea;
drop table if exists Robot;
drop table if exists UserRobotPartAsset;
drop table if exists RobotPart;
drop table if exists RobotPartType;
drop table if exists ProgramSource;
drop table if exists UserOreAsset;
drop table if exists Users;
drop table if exists OrePriceAmount;
drop table if exists OrePrice;
drop table if exists Ore;


create table Ore
(
id INT AUTO_INCREMENT PRIMARY KEY,
oreName VARCHAR(255) NOT NULL
);


create table OrePrice
(
id INT AUTO_INCREMENT PRIMARY KEY,
description VARCHAR(255) NOT NULL
);

create table OrePriceAmount
(
id INT AUTO_INCREMENT PRIMARY KEY,
orePriceId INT NOT NULL REFERENCES OrePrice (id) ON DELETE CASCADE,
oreId INT NOT NULL REFERENCES Ore (id) ON DELETE CASCADE,
amount INT NOT NULL
);


create table Users
(
id INT AUTO_INCREMENT PRIMARY KEY,
username VARCHAR(255) NOT NULL UNIQUE,
email VARCHAR(255) NOT NULL UNIQUE,
password VARCHAR(255) NOT NULL
);


create table UserOreAsset
(
usersId INT NOT NULL REFERENCES Users (id) ON DELETE CASCADE,
oreId INT NOT NULL REFERENCES Ore (id) ON DELETE CASCADE,
amount INT NOT NULL DEFAULT 0,
PRIMARY KEY (usersId, oreId)
);


create table ProgramSource
(
id INT AUTO_INCREMENT PRIMARY KEY,
usersId INT NOT NULL REFERENCES Users (id) ON DELETE CASCADE,
sourceName VARCHAR(255) NOT NULL,
sourceCode TEXT,
verified BOOL NOT NULL DEFAULT FALSE,
compiledSize INT NOT NULL DEFAULT -1,
errorDescription VARCHAR(255)
);


create table RobotPartType
(
id INT AUTO_INCREMENT PRIMARY KEY,
typeName VARCHAR(255) NOT NULL
);


create table RobotPart
(
id INT AUTO_INCREMENT PRIMARY KEY,
typeId INT NOT NULL REFERENCES RobotPartType (id) ON DELETE CASCADE,
partName VARCHAR(255) NOT NULL,
orePriceId INT NOT NULL REFERENCES OrePrice (id),
oreCapacity INT NOT NULL DEFAULT 0,
miningCapacity INT NOT NULL DEFAULT 0,
batteryCapacity INT NOT NULL DEFAULT 0,
memoryCapacity INT NOT NULL DEFAULT 0,
cpuCapacity INT NOT NULL DEFAULT 0,
forwardCapacity INT NOT NULL DEFAULT 0,
backwardCapacity INT NOT NULL DEFAULT 0,
rotateCapacity INT NOT NULL DEFAULT 0,
rechargeTime INT NOT NULL DEFAULT 0,
weight INT NOT NULL,
volume INT NOT NULL,
powerUsage INT NOT NULL
);


create table UserRobotPartAsset
(
usersId INT NOT NULL REFERENCES Users (id) ON DELETE CASCADE,
robotPartId INT NOT NULL REFERENCES RobotPart (id) ON DELETE CASCADE,
amount INT NOT NULL DEFAULT 0,
PRIMARY KEY (usersId, robotPartId)
);


create table Robot
(
id INT AUTO_INCREMENT PRIMARY KEY,
usersId INT NOT NULL REFERENCES Users (id) ON DELETE CASCADE,
robotName VARCHAR(255) NOT NULL,
sourceCode TEXT NOT NULL,
programSourceId INT NULL REFERENCES ProgramSource (id) ON DELETE SET NULL,
oreContainerId INT NULL REFERENCES RobotPart (id) ON DELETE SET NULL,
miningUnitId INT NULL REFERENCES RobotPart (id) ON DELETE SET NULL,
batteryId INT NULL REFERENCES RobotPart (id) ON DELETE SET NULL,
memoryModuleId INT NULL REFERENCES RobotPart (id) ON DELETE SET NULL,
cpuId INT NULL REFERENCES RobotPart (id) ON DELETE SET NULL,
engineId INT NULL REFERENCES RobotPart (id) ON DELETE SET NULL,
rechargeTime INT NOT NULL,
maxOre INT NOT NULL,
miningSpeed INT NOT NULL,
maxTurns INT NOT NULL,
memorySize INT NOT NULL DEFAULT 0,
cpuSpeed INT NOT NULL,
forwardSpeed INT NOT NULL,
backwardSpeed INT NOT NULL,
rotateSpeed INT NOT NULL,
robotSize INT NOT NULL,
rechargeEndTime TIMESTAMP NOT NULL DEFAULT NOW(),
miningEndTime TIMESTAMP NULL
);


create table MiningArea
(
id INT AUTO_INCREMENT PRIMARY KEY,
areaName VARCHAR(255) NOT NULL,
orePriceId INT NOT NULL REFERENCES OrePrice (id),
sizeX INT NOT NULL,
sizeY INT NOT NULL,
maxMoves INT NOT NULL,
miningTime INT NOT NULL,
taxRate INT NOT NULL,
aiRobotId INT NOT NULL REFERENCES Robot (id)
);


create table MiningAreaOreSupply
(
id INT AUTO_INCREMENT PRIMARY KEY,
miningAreaId INT NOT NULL REFERENCES MiningArea (id) ON DELETE CASCADE,
oreId INT NOT NULL REFERENCES Ore (id) ON DELETE CASCADE,
supply INT NOT NULL,
radius INT NOT NULL
);


create table RallyResult
(
id INT AUTO_INCREMENT PRIMARY KEY,
resultData MEDIUMTEXT NOT NULL
);


create table MiningQueue
(
id INT AUTO_INCREMENT PRIMARY KEY,
miningAreaId INT NOT NULL REFERENCES MiningArea (id) ON DELETE CASCADE,
robotId INT NOT NULL REFERENCES Robot (id) ON DELETE CASCADE,
rallyResultId INT NULL REFERENCES RallyResult (id) ON DELETE SET NULL,
playerNumber INT NULL,
creationTime TIMESTAMP NOT NULL DEFAULT NOW(),
miningEndTime TIMESTAMP NULL,
claimed BOOL NOT NULL DEFAULT FALSE
);


create table MiningOreResult
(
miningQueueId INT NOT NULL REFERENCES MiningQueue (id) ON DELETE CASCADE,
oreId INT NOT NULL REFERENCES Ore (id) ON DELETE CASCADE,
amount INT NOT NULL,
PRIMARY KEY (miningQueueId, oreId)
);


-- The ore type names
insert into Ore (id, oreName) values (1, 'Cerbonium');
insert into Ore (id, oreName) values (2, 'Oxaria');
insert into Ore (id, oreName) values (3, 'Lithabine');
insert into Ore (id, oreName) values (4, 'Neudralion');
insert into Ore (id, oreName) values (5, 'Complatix');

-- The robot part names
insert into RobotPartType (id, typeName) values (1, 'Ore container');
insert into RobotPartType (id, typeName) values (2, 'Mining unit');
insert into RobotPartType (id, typeName) values (3, 'Battery');
insert into RobotPartType (id, typeName) values (4, 'Memory module');
insert into RobotPartType (id, typeName) values (5, 'CPU');
insert into RobotPartType (id, typeName) values (6, 'Engine');

-- Ore containers
insert into OrePrice (id, description) values (101, 'Standard Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1011, 101, 1, 2);
insert into RobotPart (id,  typeId, partName,                 orePriceId, oreCapacity, weight, volume, powerUsage)
               values (101, 1,      'Standard Ore Container', 101,        25,          10,     30,     1);

insert into OrePrice (id, description) values (102, 'Enhanced Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1021, 102, 1, 10);
insert into RobotPart (id,  typeId, partName,                 orePriceId, oreCapacity, weight, volume, powerUsage)
               values (102, 1,      'Enhanced Ore Container', 102,        40,          14,     45,     2);

insert into OrePrice (id, description) values (103, 'Cerbonium Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1031, 103, 1, 100);
insert into RobotPart (id,  typeId, partName,                  orePriceId, oreCapacity, weight, volume, powerUsage)
               values (103, 1,      'Cerbonium Ore Container', 103,        60,          15,     65,     2);

-- Mining units
insert into OrePrice (id, description) values (201, 'Standard Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2011, 201, 1, 2);
insert into RobotPart (id,  typeId, partName,               orePriceId, miningCapacity, weight, volume, powerUsage)
               values (201, 2,      'Standard Mining Unit', 201,        1,              10,     5,      5);

insert into OrePrice (id, description) values (202, 'Enhanced Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2021, 202, 1, 10);
insert into RobotPart (id,  typeId, partName,               orePriceId, miningCapacity, weight, volume, powerUsage)
               values (202, 2,      'Enhanced Mining Unit', 202,        2,              14,     8,      8);

insert into OrePrice (id, description) values (203, 'Cerbonium Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2031, 203, 1, 100);
insert into RobotPart (id,  typeId, partName,                orePriceId, miningCapacity, weight, volume, powerUsage)
               values (203, 2,      'Cerbonium Mining Unit', 203,        3,              16,     9,      10);

-- Batteries
insert into OrePrice (id, description) values (301, 'Standard Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3011, 301, 1, 2);
insert into RobotPart (id,  typeId, partName,           orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (301, 3,      'Standard Battery', 301,        1200,            20,           2,      2,      0);

insert into OrePrice (id, description) values (302, 'Enhanced Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3021, 302, 1, 10);
insert into RobotPart (id,  typeId, partName,           orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (302, 3,      'Enhanced Battery', 302,        1800,            30,           3,      3,      0);

insert into OrePrice (id, description) values (303, 'Cerbonium Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3031, 303, 1, 100);
insert into RobotPart (id,  typeId, partName,            orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (303, 3,      'Cerbonium Battery', 303,        2400,            35,           4,      3,      0);

insert into OrePrice (id, description) values (304, 'Oxaria Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3041, 304, 2, 25);
insert into RobotPart (id,  typeId, partName,         orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (304, 3,      'Oxaria Battery', 304,        4000,            60,           5,      3,      0);

insert into OrePrice (id, description) values (305, 'Enhanced Oxaria Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3051, 305, 2, 100);
insert into RobotPart (id,  typeId, partName,                  orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (305, 3,      'Enhanced Oxaria Battery', 305,        5000,            80,           5,      3,      0);

insert into OrePrice (id, description) values (306, 'Fast Charge Oxaria Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3061, 306, 2, 500);
insert into RobotPart (id,  typeId, partName,                     orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (306, 3,      'Fast Charge Oxaria Battery', 306,        4800,            40,           5,      4,      0);

-- Memory modules
insert into OrePrice (id, description) values (401, 'Memory Module 5 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4011, 401, 1, 2);
insert into RobotPart (id,  typeId, partName,          orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (401, 4,      'Memory Module 5', 401,        5,              1,      1,      1);

insert into OrePrice (id, description) values (402, 'Memory Module 12 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4021, 402, 1, 10);
insert into RobotPart (id,  typeId, partName,           orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (402, 4,      'Memory Module 12', 402,        12,             1,      1,      1);

insert into OrePrice (id, description) values (403, 'Memory Module 19 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4031, 403, 1, 100);
insert into RobotPart (id,  typeId, partName,           orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (403, 4,      'Memory Module 19', 403,        19,             1,      1,      1);

insert into OrePrice (id, description) values (404, 'Memory Module 25 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4041, 404, 2, 10);
insert into RobotPart (id,  typeId, partName,           orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (404, 4,      'Memory Module 25', 404,        25,             1,      1,      2);

insert into OrePrice (id, description) values (405, 'Memory Module 32 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4051, 405, 2, 100);
insert into RobotPart (id,  typeId, partName,           orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (405, 4,      'Memory Module 32', 405,        32,             1,      1,      2);

-- CPUs
insert into OrePrice (id, description) values (501, 'CPU 1 ipc price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5011, 501, 1, 2);
insert into RobotPart (id,  typeId, partName,    orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (501, 5,      'CPU 1 ipc', 501,        1,           1,      1,      1);

insert into OrePrice (id, description) values (502, 'CPU 2 ipc price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5021, 502, 1, 10);
insert into RobotPart (id,  typeId, partName,    orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (502, 5,      'CPU 2 ipc', 502,        2,           1,      1,      1);

insert into OrePrice (id, description) values (503, 'CPU 3 ipc price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5031, 503, 2, 10);
insert into RobotPart (id,  typeId, partName,    orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (503, 5,      'CPU 3 ipc', 503,        3,           1,      1,      1);

-- Engines
insert into OrePrice (id, description) values (601, 'Engine 100 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6011, 601, 1, 2);
insert into RobotPart (id,  typeId, partName,     orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (601, 6,      'Engine 100', 601,        100,             100,              100,            10,     5,      5);

insert into OrePrice (id, description) values (602, 'Engine 150/50 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6021, 602, 1, 10);
insert into RobotPart (id,  typeId, partName,        orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (602, 6,      'Engine 150/50', 602,        150,             50,               50,             14,     8,      8);


-- AI player
insert into Users (id, username, email, password) values (1, 'AI', '', '');

-- AI player robots
insert into Robot (id, usersId, robotName, sourceCode,
 rechargeTime, maxOre, miningSpeed, maxTurns, cpuSpeed, forwardSpeed, backwardSpeed, rotateSpeed, robotSize)
values (1, 1, 'AI-1', 'move(2); while (mine());',
 0,            50,     2,           150,      2,        2,            2,             25,          3);

insert into Robot (id, usersId, robotName, sourceCode,
 rechargeTime, maxOre, miningSpeed, maxTurns, cpuSpeed, forwardSpeed, backwardSpeed, rotateSpeed, robotSize)
values (2, 1, 'AI-2', 'if (move(2) >= 1) { while (mine()); } else { move(-2); rotate(45); }',
 0,            50,     2,           200,      2,        2,            2,             25,          3);


-- Mining areas

-- Cerbonium
insert into OrePrice (id, description) values (1001, 'Mining Area Alpha price');
insert into MiningArea (id, areaName, orePriceId, sizeX, sizeY, maxMoves, miningTime, taxRate, aiRobotId)
                values (1,  'Alpha',  1001,       20,    20,    150,      30,         75,      1);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1, 1, 50, 5);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1, 1, 40, 3);

insert into OrePrice (id, description) values (1002, 'Mining Area Beta price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (10021, 1002, 1, 5);
insert into MiningArea (id, areaName, orePriceId, sizeX, sizeY, maxMoves, miningTime, taxRate, aiRobotId)
                values (2,  'Beta',   1002,       20,    20,    200,      30,         25,      1);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (2, 1, 50, 4);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (2, 1, 40, 2);

-- Oxaria
insert into OrePrice (id, description) values (1003, 'Mining Area Gamma price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (10031, 1003, 1, 25);
insert into MiningArea (id, areaName,  orePriceId, sizeX, sizeY, maxMoves, miningTime, taxRate, aiRobotId)
                values (3,  'Gamma',   1003,       25,    25,    200,      45,         25,      1);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (3, 1, 50, 4);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (3, 2, 20, 3);

insert into OrePrice (id, description) values (1004, 'Mining Area Delta price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (10041, 1004, 1, 100);
insert into MiningArea (id, areaName, orePriceId, sizeX, sizeY, maxMoves, miningTime, taxRate, aiRobotId)
                values (4,  'Delta',  1004,       30,    30,    250,      90,         75,      2);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (4, 2, 20, 4);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (4, 2, 20, 4);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (4, 2, 20, 3);

-- Lithabine
insert into OrePrice (id, description) values (1005, 'Mining Area Epsilon price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (10051, 1005, 2, 25);
insert into MiningArea (id, areaName,  orePriceId, sizeX, sizeY, maxMoves, miningTime, taxRate, aiRobotId)
                values (5,  'Epsilon', 1005,       30,    30,    300,      120,        75,      2);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (5, 1, 50, 4);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (5, 2, 20, 3);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (5, 3, 10, 3);

-- Test data
insert into Users
(id, username, email, password)
values
(2, 'test', 'test@test.com', '$2a$10$Mcn32qmzmfdD9MPjIlZl1eF.K32Q6EtvWI0S8/V1Pa6vG4D7Rh.2m');

insert into ProgramSource (id, usersId, sourceName, sourceCode, verified)
                   values (1,  2,       'Default',
'{
   int i = 1;
   while (true)
   {
      move(i);
      i = i + 1;
      while (mine() >= 2)
      {
         i = 1;
      }
   }
}', TRUE);

insert into ProgramSource (id, usersId, sourceName, sourceCode, verified)
                   values (2,  2,       'Test',
'move(1);
mine();', TRUE);

insert into UserRobotPartAsset (usersId, robotPartId, amount) values (2, 1, 1);

insert into Robot
(usersId, robotName, sourceCode, programSourceId,
 oreContainerId, miningUnitId, batteryId, memoryModuleId, cpuId, engineId,
 rechargeTime, maxOre, miningSpeed, maxTurns, memorySize, cpuSpeed,
 forwardSpeed, backwardSpeed, rotateSpeed, robotSize)
values
(2, 'Robot_1', 'move(1);
mine();', 1,
 101, 201, 301, 401, 501, 601,
 20, 200, 3, 100, 10, 2,
 10, 10, 10, 10);

insert into Robot
(usersId, robotName, sourceCode, programSourceId,
 oreContainerId, miningUnitId, batteryId, memoryModuleId, cpuId, engineId,
 rechargeTime, maxOre, miningSpeed, maxTurns, memorySize, cpuSpeed,
 forwardSpeed, backwardSpeed, rotateSpeed, robotSize)
values
(2, 'Robot_2', 'move(1);
mine();', 1,
 102, 202, 302, 402, 502, 602,
 20, 200, 3, 100, 20, 2,
 10, 10, 10, 10);
