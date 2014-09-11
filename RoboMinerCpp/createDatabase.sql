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

drop table if exists RobotDailyResult;
drop table if exists RobotDailyRuns;
drop table if exists RobotLifetimeResult;
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
drop table if exists Tier;
drop table if exists Ore;


create table Ore
(
id INT AUTO_INCREMENT PRIMARY KEY,
oreName VARCHAR(255) NOT NULL
);

create table Tier
(
id INT AUTO_INCREMENT PRIMARY KEY,
tierName VARCHAR(255) NOT NULL
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
tierId INT NULL REFERENCES Tier (id) ON DELETE SET NULL,
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
totalOwned INT NOT NULL DEFAULT 0,
unassigned INT NOT NULL DEFAULT 0,
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
forwardSpeed DOUBLE NOT NULL,
backwardSpeed DOUBLE NOT NULL,
rotateSpeed INT NOT NULL,
robotSize INT NOT NULL,
rechargeEndTime TIMESTAMP NOT NULL DEFAULT NOW(),
miningEndTime TIMESTAMP NULL,
totalMiningRuns INT NOT NULL DEFAULT 0
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
tax INT NULL,
PRIMARY KEY (miningQueueId, oreId)
);


create table RobotLifetimeResult
(
robotId INT NOT NULL REFERENCES Robot (id) ON DELETE CASCADE,
oreId INT NOT NULL REFERENCES Ore (id) ON DELETE CASCADE,
amount INT NOT NULL,
tax INT NOT NULL,
PRIMARY KEY (robotId, oreId)
);


create table RobotDailyRuns
(
robotId INT NOT NULL REFERENCES Robot (id) ON DELETE CASCADE,
miningDay DATE NOT NULL,
totalMiningRuns INT NOT NULL DEFAULT 0,
PRIMARY KEY (robotId, miningDay)
);


create table RobotDailyResult
(
robotId INT NOT NULL REFERENCES Robot (id) ON DELETE CASCADE,
oreId INT NOT NULL REFERENCES Ore (id) ON DELETE CASCADE,
miningDay DATE NOT NULL,
amount INT NOT NULL,
tax INT NOT NULL,
PRIMARY KEY (robotId, oreId, miningDay)
);


-- The ore type names
insert into Ore (id, oreName) values (1, 'Cerbonium');
insert into Ore (id, oreName) values (2, 'Oxaria');
insert into Ore (id, oreName) values (3, 'Lithabine');
insert into Ore (id, oreName) values (4, 'Neudralion');
insert into Ore (id, oreName) values (5, 'Complatix');

-- The tier names
insert into Tier (id, tierName) values (1, 'Cerbonium quality');
insert into Tier (id, tierName) values (2, 'Oxaria quality');
insert into Tier (id, tierName) values (3, 'Lithabine quality');
insert into Tier (id, tierName) values (4, 'Neudralion quality');
insert into Tier (id, tierName) values (5, 'Complatix quality');

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
               values (101, 1,      'Standard Ore Container', 101,        15,          10,     20,     1);

insert into OrePrice (id, description) values (102, 'Enhanced Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1021, 102, 1, 10);
insert into RobotPart (id,  typeId, partName,                 orePriceId, oreCapacity, weight, volume, powerUsage)
               values (102, 1,      'Enhanced Ore Container', 102,        25,          14,     30,     2);

insert into OrePrice (id, description) values (103, 'Cerbonium Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1031, 103, 1, 100);
insert into RobotPart (id,  typeId, partName,                  orePriceId, oreCapacity, weight, volume, powerUsage)
               values (103, 1,      'Cerbonium Ore Container', 103,        30,          15,     35,     3);

insert into OrePrice (id, description) values (110, 'Oxaria Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1102, 110, 2, 10);
insert into RobotPart (id,  typeId, partName,               orePriceId, oreCapacity, weight, volume, powerUsage)
               values (110, 1,      'Oxaria Ore Container', 110,        35,          16,     40,     4);

insert into OrePrice (id, description) values (111, 'Enhanced Oxaria Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1111, 111, 1, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1112, 111, 2, 25);
insert into RobotPart (id,  typeId, partName,                        orePriceId, oreCapacity, weight, volume, powerUsage)
               values (111, 1,      'Enhanced Oxaria Ore Container', 111,        40,          18,     45,     5);

insert into OrePrice (id, description) values (120, 'Lithabine Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1201, 120, 1, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1202, 120, 2, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1203, 120, 3, 10);
insert into RobotPart (id,  typeId, partName,                  orePriceId, oreCapacity, weight, volume, powerUsage)
               values (120, 1,      'Lithabine Ore Container', 120,        45,          20,     50,     6);

insert into OrePrice (id, description) values (121, 'Enhanced Lithabine Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1211, 121, 1, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1212, 121, 2, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1213, 121, 3, 25);
insert into RobotPart (id,  typeId, partName,                           orePriceId, oreCapacity, weight, volume, powerUsage)
               values (121, 1,      'Enhanced Lithabine Ore Container', 121,        50,          22,     55,     7);

insert into OrePrice (id, description) values (130, 'Neudralion Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1302, 130, 2, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1303, 130, 3, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1304, 130, 4, 10);
insert into RobotPart (id,  typeId, partName,                   orePriceId, oreCapacity, weight, volume, powerUsage)
               values (130, 1,      'Neudralion Ore Container', 130,        55,          24,     60,     8);

insert into OrePrice (id, description) values (131, 'Enhanced Neudralion Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1312, 131, 2, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1313, 131, 3, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1314, 131, 4, 25);
insert into RobotPart (id,  typeId, partName,                            orePriceId, oreCapacity, weight, volume, powerUsage)
               values (131, 1,      'Enhanced Neudralion Ore Container', 131,        60,          26,     65,     9);

insert into OrePrice (id, description) values (140, 'Neudralion Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1403, 140, 3, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1404, 140, 4, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1405, 140, 5, 10);
insert into RobotPart (id,  typeId, partName,                  orePriceId, oreCapacity, weight, volume, powerUsage)
               values (140, 1,      'Complatix Ore Container', 140,        65,          28,     70,     10);

insert into OrePrice (id, description) values (141, 'Enhanced Neudralion Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1413, 141, 3, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1414, 141, 4, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1415, 141, 5, 25);
insert into RobotPart (id,  typeId, partName,                           orePriceId, oreCapacity, weight, volume, powerUsage)
               values (141, 1,      'Enhanced Complatix Ore Container', 141,        70,          30,     75,     11);

-- Mining units
insert into OrePrice (id, description) values (201, 'Standard Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2011, 201, 1, 2);
insert into RobotPart (id,  typeId, partName,               orePriceId, miningCapacity, weight, volume, powerUsage)
               values (201, 2,      'Standard Mining Unit', 201,        1,              10,     5,      8);

insert into OrePrice (id, description) values (202, 'Enhanced Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2021, 202, 1, 10);
insert into RobotPart (id,  typeId, partName,               orePriceId, miningCapacity, weight, volume, powerUsage)
               values (202, 2,      'Enhanced Mining Unit', 202,        2,              14,     8,      12);

insert into OrePrice (id, description) values (203, 'Cerbonium Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2031, 203, 1, 100);
insert into RobotPart (id,  typeId, partName,                orePriceId, miningCapacity, weight, volume, powerUsage)
               values (203, 2,      'Cerbonium Mining Unit', 203,        2,              15,     9,      11);

insert into OrePrice (id, description) values (210, 'Oxaria Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2102, 210, 2, 10);
insert into RobotPart (id,  typeId, partName,             orePriceId, miningCapacity, weight, volume, powerUsage)
               values (210, 2,      'Oxaria Mining Unit', 210,        3,              18,     11,     16);

insert into OrePrice (id, description) values (211, 'Enhanced Oxaria Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2111, 211, 1, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2112, 211, 2, 25);
insert into RobotPart (id,  typeId, partName,                      orePriceId, miningCapacity, weight, volume, powerUsage)
               values (211, 2,      'Enhanced Oxaria Mining Unit', 211,        3,              19,     12,     15);

insert into OrePrice (id, description) values (220, 'Lithabine Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2201, 220, 1, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2202, 220, 2, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2203, 220, 3, 10);
insert into RobotPart (id,  typeId, partName,                orePriceId, miningCapacity, weight, volume, powerUsage)
               values (220, 2,      'Lithabine Mining Unit', 220,        4,              20,     13,     18);

insert into OrePrice (id, description) values (221, 'Enhanced Lithabine Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2211, 221, 1, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2212, 221, 2, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2213, 221, 3, 25);
insert into RobotPart (id,  typeId, partName,                         orePriceId, miningCapacity, weight, volume, powerUsage)
               values (221, 2,      'Enhanced Lithabine Mining Unit', 221,        4,              21,     14,     17);

insert into OrePrice (id, description) values (230, 'Neudralion Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2302, 230, 2, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2303, 230, 3, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2304, 230, 4, 10);
insert into RobotPart (id,  typeId, partName,                 orePriceId, miningCapacity, weight, volume, powerUsage)
               values (230, 2,      'Neudralion Mining Unit', 230,        5,              22,     15,     20);

insert into OrePrice (id, description) values (231, 'Enhanced Neudralion Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2312, 231, 2, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2313, 231, 3, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2314, 231, 4, 25);
insert into RobotPart (id,  typeId, partName,                          orePriceId, miningCapacity, weight, volume, powerUsage)
               values (231, 2,      'Enhanced Neudralion Mining Unit', 231,        5,              23,     16,     19);

insert into OrePrice (id, description) values (240, 'Complatix Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2403, 240, 3, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2404, 240, 4, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2405, 240, 5, 10);
insert into RobotPart (id,  typeId, partName,                orePriceId, miningCapacity, weight, volume, powerUsage)
               values (240, 2,      'Complatix Mining Unit', 240,        6,              24,     17,     25);

insert into OrePrice (id, description) values (241, 'Enhanced Complatix Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2413, 241, 3, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2414, 241, 4, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2415, 241, 5, 25);
insert into RobotPart (id,  typeId, partName,                         orePriceId, miningCapacity, weight, volume, powerUsage)
               values (241, 2,      'Enhanced Complatix Mining Unit', 241,        6,              25,     18,     22);

-- Batteries
insert into OrePrice (id, description) values (301, 'Standard Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3011, 301, 1, 2);
insert into RobotPart (id,  typeId, partName,           orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (301, 3,      'Standard Battery', 301,        2500,            5,            2,      2,      0);

insert into OrePrice (id, description) values (302, 'Enhanced Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3021, 302, 1, 10);
insert into RobotPart (id,  typeId, partName,           orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (302, 3,      'Enhanced Battery', 302,        4000,            10,           3,      3,      0);

insert into OrePrice (id, description) values (303, 'Cerbonium Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3031, 303, 1, 100);
insert into RobotPart (id,  typeId, partName,            orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (303, 3,      'Cerbonium Battery', 303,        6000,            15,           4,      3,      0);

insert into OrePrice (id, description) values (310, 'Oxaria Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3102, 310, 2, 10);
insert into RobotPart (id,  typeId, partName,         orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (310, 3,      'Oxaria Battery', 310,        9500,            30,           5,      3,      0);

insert into OrePrice (id, description) values (311, 'Enhanced Oxaria Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3111, 311, 1, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3112, 311, 2, 25);
insert into RobotPart (id,  typeId, partName,                  orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (311, 3,      'Enhanced Oxaria Battery', 311,        18000,           60,           5,      3,      0);

insert into OrePrice (id, description) values (312, 'Fast Charge Oxaria Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3121, 312, 1, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3122, 312, 2, 50);
insert into RobotPart (id,  typeId, partName,                     orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (312, 3,      'Fast Charge Oxaria Battery', 312,        17000,           40,           5,      4,      0);

insert into OrePrice (id, description) values (320, 'Lithabine Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3201, 320, 1, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3202, 320, 2, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3203, 320, 3, 10);
insert into RobotPart (id,  typeId, partName,            orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (320, 3,      'Lithabine Battery', 320,        22000,           45,           6,      5,      0);

insert into OrePrice (id, description) values (321, 'Enhanced Lithabine Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3211, 321, 1, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3212, 321, 2, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3213, 321, 3, 25);
insert into RobotPart (id,  typeId, partName,                     orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (321, 3,      'Enhanced Lithabine Battery', 321,        25000,           60,           7,      6,      0);

insert into OrePrice (id, description) values (330, 'Neudralion Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3302, 330, 2, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3303, 330, 3, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3304, 330, 4, 10);
insert into RobotPart (id,  typeId, partName,             orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (330, 3,      'Neudralion Battery', 330,        29000,           90,           8,      7,      0);

insert into OrePrice (id, description) values (331, 'Enhanced Neudralion Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3312, 331, 2, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3313, 331, 3, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3314, 331, 4, 25);
insert into RobotPart (id,  typeId, partName,                      orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (331, 3,      'Enhanced Neudralion Battery', 331,        32000,           120,          9,      8,      0);

insert into OrePrice (id, description) values (340, 'Complatix Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3403, 340, 3, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3404, 340, 4, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3405, 340, 5, 10);
insert into RobotPart (id,  typeId, partName,            orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (340, 3,      'Complatix Battery', 340,        39000,           180,          10,     9,      0);

insert into OrePrice (id, description) values (341, 'Enhanced Complatix Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3413, 341, 3, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3414, 341, 4, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3415, 341, 5, 25);
insert into RobotPart (id,  typeId, partName,                     orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (341, 3,      'Enhanced Complatix Battery', 341,        45000,           240,          11,     10,      0);

-- Memory modules
insert into OrePrice (id, description) values (401, 'Memory Module 8 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4011, 401, 1, 2);
insert into RobotPart (id,  typeId, partName,          orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (401, 4,      'Memory Module 8', 401,        8,              1,      1,      1);

insert into OrePrice (id, description) values (402, 'Memory Module 16 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4021, 402, 1, 10);
insert into RobotPart (id,  typeId, partName,           orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (402, 4,      'Memory Module 16', 402,        16,             1,      1,      2);

insert into OrePrice (id, description) values (403, 'Memory Module 24 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4031, 403, 1, 100);
insert into RobotPart (id,  typeId, partName,           orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (403, 4,      'Memory Module 24', 403,        24,             1,      1,      3);

insert into OrePrice (id, description) values (410, 'Memory Module 32 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4102, 410, 2, 10);
insert into RobotPart (id,  typeId, partName,           orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (410, 4,      'Memory Module 32', 410,        32,             1,      1,      4);

insert into OrePrice (id, description) values (411, 'Memory Module 48 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4111, 411, 1, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4112, 411, 2, 25);
insert into RobotPart (id,  typeId, partName,           orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (411, 4,      'Memory Module 48', 411,        48,             1,      1,      5);

insert into OrePrice (id, description) values (420, 'Memory Module 64 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4201, 420, 1, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4202, 420, 2, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4203, 420, 3, 10);
insert into RobotPart (id,  typeId, partName,           orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (420, 4,      'Memory Module 64', 420,        64,             1,      1,      6);

insert into OrePrice (id, description) values (421, 'Memory Module 96 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4211, 421, 1, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4212, 421, 2, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4213, 421, 3, 25);
insert into RobotPart (id,  typeId, partName,           orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (421, 4,      'Memory Module 96', 421,        96,             1,      1,      7);

insert into OrePrice (id, description) values (430, 'Memory Module 128 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4302, 430, 2, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4303, 430, 3, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4304, 430, 4, 10);
insert into RobotPart (id,  typeId, partName,            orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (430, 4,      'Memory Module 128', 430,        128,            1,      1,      8);

insert into OrePrice (id, description) values (431, 'Memory Module 196 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4312, 431, 2, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4313, 431, 3, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4314, 431, 4, 25);
insert into RobotPart (id,  typeId, partName,            orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (431, 4,      'Memory Module 196', 431,        196,            1,      1,      9);

insert into OrePrice (id, description) values (440, 'Memory Module 256 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4403, 440, 3, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4404, 440, 4, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4405, 440, 5, 10);
insert into RobotPart (id,  typeId, partName,            orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (440, 4,      'Memory Module 256', 440,        256,            1,      1,      10);

insert into OrePrice (id, description) values (441, 'Memory Module 384 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4413, 441, 3, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4414, 441, 4, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4415, 441, 5, 25);
insert into RobotPart (id,  typeId, partName,            orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (441, 4,      'Memory Module 384', 441,        384,            1,      1,      11);

-- CPUs
insert into OrePrice (id, description) values (501, 'CPU 1 ipc price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5011, 501, 1, 2);
insert into RobotPart (id,  typeId, partName,    orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (501, 5,      'CPU 1 ipc', 501,        1,           1,      1,      1);

insert into OrePrice (id, description) values (502, 'CPU 2 ipc price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5021, 502, 1, 10);
insert into RobotPart (id,  typeId, partName,    orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (502, 5,      'CPU 2 ipc', 502,        2,           1,      1,      2);

insert into OrePrice (id, description) values (510, 'CPU 3 ipc price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5102, 510, 2, 10);
insert into RobotPart (id,  typeId, partName,    orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (510, 5,      'CPU 3 ipc', 510,        3,           1,      1,      3);

insert into OrePrice (id, description) values (511, 'CPU 4 ipc price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5111, 511, 1, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5112, 511, 2, 25);
insert into RobotPart (id,  typeId, partName,    orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (511, 5,      'CPU 4 ipc', 511,        4,           1,      1,      4);

insert into OrePrice (id, description) values (520, 'CPU 5 ipc price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5201, 520, 1, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5202, 520, 2, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5203, 520, 3, 10);
insert into RobotPart (id,  typeId, partName,    orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (520, 5,      'CPU 5 ipc', 520,        5,           1,      1,      5);

insert into OrePrice (id, description) values (521, 'CPU 6 ipc price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5211, 521, 1, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5212, 521, 2, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5213, 521, 3, 25);
insert into RobotPart (id,  typeId, partName,    orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (521, 5,      'CPU 6 ipc', 521,        6,           1,      1,      6);

insert into OrePrice (id, description) values (530, 'CPU 7 ipc price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5302, 530, 2, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5303, 530, 3, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5304, 530, 4, 10);
insert into RobotPart (id,  typeId, partName,    orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (530, 5,      'CPU 7 ipc', 530,        7,           1,      1,      7);

insert into OrePrice (id, description) values (531, 'CPU 8 ipc price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5312, 531, 2, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5313, 531, 3, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5314, 531, 4, 25);
insert into RobotPart (id,  typeId, partName,    orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (531, 5,      'CPU 8 ipc', 531,        8,           1,      1,      6);

insert into OrePrice (id, description) values (540, 'CPU 9 ipc price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5403, 540, 3, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5404, 540, 4, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5405, 540, 5, 10);
insert into RobotPart (id,  typeId, partName,    orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (540, 5,      'CPU 9 ipc', 540,        9,           1,      1,      9);

insert into OrePrice (id, description) values (541, 'CPU 10 ipc price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5413, 541, 3, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5414, 541, 4, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5415, 541, 5, 25);
insert into RobotPart (id,  typeId, partName,     orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (541, 5,      'CPU 10 ipc', 541,        10,          1,      1,      6);

-- Engines
insert into OrePrice (id, description) values (601, 'Engine 50 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6011, 601, 1, 2);
insert into RobotPart (id,  typeId, partName,    orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (601, 6,      'Engine 50', 601,        50,              50,               50,             8,      4,      8);

insert into OrePrice (id, description) values (602, 'Engine 70 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6021, 602, 1, 10);
insert into RobotPart (id,  typeId, partName,    orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (602, 6,      'Engine 70', 602,        70,              70,               70,             10,     5,      12);

insert into OrePrice (id, description) values (603, 'Engine 100/40 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6031, 603, 1, 100);
insert into RobotPart (id,  typeId, partName,        orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (603, 6,      'Engine 100/40', 603,        100,             40,               40,             12,     7,      15);

insert into OrePrice (id, description) values (610, 'Engine 80 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6102, 610, 2, 10);
insert into RobotPart (id,  typeId, partName,    orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (610, 6,      'Engine 80', 610,        80,              80,               80,             14,     8,      22);

insert into OrePrice (id, description) values (611, 'Engine 75E price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6111, 611, 1, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6112, 611, 2, 25);
insert into RobotPart (id,  typeId, partName,     orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (611, 6,      'Engine 75E', 611,        75,              75,               75,             14,     9,      12);

insert into OrePrice (id, description) values (620, 'Engine 100 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6201, 620, 1, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6202, 620, 2, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6203, 620, 3, 10);
insert into RobotPart (id,  typeId, partName,     orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (620, 6,      'Engine 100', 620,        100,             100,              100,            16,     10,     30);

insert into OrePrice (id, description) values (621, 'Engine 95E price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6211, 621, 1, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6212, 621, 2, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6213, 621, 3, 25);
insert into RobotPart (id,  typeId, partName,     orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (621, 6,      'Engine 95E', 621,        95,              95,               95,             16,     11,     28);

insert into OrePrice (id, description) values (630, 'Engine 120 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6302, 630, 2, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6303, 630, 3, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6304, 630, 4, 10);
insert into RobotPart (id,  typeId, partName,     orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (630, 6,      'Engine 120', 630,        120,             120,              120,            18,     12,     40);

insert into OrePrice (id, description) values (631, 'Engine 110E price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6312, 631, 2, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6313, 631, 3, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6314, 631, 4, 25);
insert into RobotPart (id,  typeId, partName,      orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (631, 6,      'Engine 110E', 631,        110,             110,              110,            18,     13,     38);

insert into OrePrice (id, description) values (640, 'Engine 150 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6403, 640, 3, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6404, 640, 4, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6405, 640, 5, 10);
insert into RobotPart (id,  typeId, partName,     orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (640, 6,      'Engine 150', 640,        150,             150,              150,            20,     14,     50);

insert into OrePrice (id, description) values (641, 'Engine 140E price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6413, 641, 3, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6414, 641, 4, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6415, 641, 5, 25);
insert into RobotPart (id,  typeId, partName,      orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (641, 6,      'Engine 140E', 641,        140,             140,              140,            20,     15,     48);


-- AI player
insert into Users (id, username, email, password) values (1, 'AI', '', '');

-- AI player robots
insert into Robot (id, usersId, robotName, sourceCode,
 rechargeTime, maxOre, miningSpeed, maxTurns, cpuSpeed, forwardSpeed, backwardSpeed, rotateSpeed, robotSize)
values (1, 1, 'AI-1', 'move(1.5); while (mine());',
 0,            50,     2,           150,      2,        2,            2,             25,          3);

insert into Robot (id, usersId, robotName, sourceCode,
 rechargeTime, maxOre, miningSpeed, maxTurns, cpuSpeed, forwardSpeed, backwardSpeed, rotateSpeed, robotSize)
values (2, 1, 'AI-2', 'if (move(1.5) >= 1) { while (mine()); } else { move(-1); rotate(20); }',
 0,            50,     2,           300,      2,        2,            2,             25,          3);

insert into Robot (id, usersId, robotName,
 sourceCode,
 rechargeTime, maxOre, miningSpeed, maxTurns, cpuSpeed, forwardSpeed, backwardSpeed, rotateSpeed, robotSize)
values (3, 1, 'AI-3', 
'int rot = 0; while (true) { if (rot) { if (rot <= 90) { rotate(rot); } rot = rot - 10; } if (move(1.5) < 1) { move(-1); rotate(24); } while (mine()) { rot = 100; } }',
 0,            50,     2,           500,      5,        2,            2,             25,          3);

-- Mining areas

-- Cerbonium
insert into OrePrice (id, description) values (1001, 'Mining Area Cerbonium-1 price');
insert into MiningArea (id, areaName,        orePriceId, sizeX, sizeY, maxMoves, miningTime, taxRate, aiRobotId)
                values (1001, 'Cerbonium-1', 1001,       20,    20,    150,      30,         25,      1);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1001, 1, 20, 6);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1001, 1, 20, 4);

insert into OrePrice (id, description) values (1002, 'Mining Area Cerbonium-2 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (10021, 1002, 1, 2);
insert into MiningArea (id,   areaName,      orePriceId, sizeX, sizeY, maxMoves, miningTime, taxRate, aiRobotId)
                values (1002, 'Cerbonium-2', 1002,       25,    25,    200,      30,         0,       1);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1002, 1, 20, 4);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1002, 1, 20, 3);

-- Oxaria
insert into OrePrice (id, description) values (1101, 'Mining Area Oxaria-1 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (11011, 1101, 1, 25);
insert into MiningArea (id,   areaName,   orePriceId, sizeX, sizeY, maxMoves, miningTime, taxRate, aiRobotId)
                values (1101, 'Oxaria-1', 1101,       30,    30,    250,      45,         25,      2);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1101, 1, 20, 4);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1101, 2, 10, 4);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1101, 2, 5,  4);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1101, 2, 5,  4);

insert into OrePrice (id, description) values (1102, 'Mining Area Oxaria-2 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (11021, 1102, 1, 100);
insert into MiningArea (id,   areaName,   orePriceId, sizeX, sizeY, maxMoves, miningTime, taxRate, aiRobotId)
                values (1102, 'Oxaria-2', 1102,       35,    35,    300,      90,         50,      2);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1102, 1, 20, 4);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1102, 2, 10, 4);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1102, 2, 5,  4);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1102, 2, 5,  4);

-- Lithabine
insert into OrePrice (id, description) values (1201, 'Mining Area Lithabine-1 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (12011, 1201, 2, 25);
insert into MiningArea (id,   areaName,      orePriceId, sizeX, sizeY, maxMoves, miningTime, taxRate, aiRobotId)
                values (1201, 'Lithabine-1', 1201,       40,    40,    350,      120,        25,      3);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1201, 1, 10, 5);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1201, 2, 5, 4);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1201, 3, 5, 4);

insert into OrePrice (id, description) values (1202, 'Mining Area Lithabine-2 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (12021, 1202, 2, 25);
insert into MiningArea (id,   areaName,      orePriceId, sizeX, sizeY, maxMoves, miningTime, taxRate, aiRobotId)
                values (1202, 'Lithabine-2', 1202,       45,    45,    400,      120,        50,      3);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1202, 1, 10, 5);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1202, 2, 10, 4);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1202, 3, 5, 4);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1202, 3, 5, 4);

-- Neudralion
insert into OrePrice (id, description) values (1301, 'Mining Area Neudralion-1 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (13011, 1301, 3, 25);
insert into MiningArea (id,   areaName,       orePriceId, sizeX, sizeY, maxMoves, miningTime, taxRate, aiRobotId)
                values (1301, 'Neudralion-1', 1301,       50,    50,    450,      300,        25,      3);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1301, 2, 10, 6);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1301, 3, 10, 5);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1301, 4, 5, 5);

insert into OrePrice (id, description) values (1302, 'Mining Area Neudralion-2 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (13021, 1302, 3, 25);
insert into MiningArea (id,   areaName,       orePriceId, sizeX, sizeY, maxMoves, miningTime, taxRate, aiRobotId)
                values (1302, 'Neudralion-2', 1302,       55,    55,    500,     420,        50,      3);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1302, 2, 10, 6);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1302, 3, 10, 5);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1302, 4, 5, 5);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1302, 4, 5, 5);

-- Complatix
insert into OrePrice (id, description) values (1401, 'Mining Area Complatix-1 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (14011, 1401, 4, 25);
insert into MiningArea (id,   areaName,      orePriceId, sizeX, sizeY, maxMoves, miningTime, taxRate, aiRobotId)
                values (1401, 'Complatix-1', 1401,       60,    60,    600,      900,        25,      3);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1401, 3, 10, 6);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1401, 4, 10, 5);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1401, 5, 5, 5);

insert into OrePrice (id, description) values (1402, 'Mining Area Complatix-2 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (14021, 1402, 4, 25);
insert into MiningArea (id,   areaName,      orePriceId, sizeX, sizeY, maxMoves, miningTime, taxRate, aiRobotId)
                values (1402, 'Complatix-2', 1402,       65,    65,    700,      3600,       50,      3);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1402, 3, 10, 6);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1402, 4, 10, 6);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1402, 5, 5, 5);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1402, 5, 5, 5);

-- Calculate the tier levels
update RobotPart set tierId = (select max(OrePriceAmount.oreId) from OrePriceAmount where OrePriceAmount.orePriceId = RobotPart.orePriceId);


-- Test data
insert into Users
(id, username, email, password)
values
(2, 'test', 'test@test.com', '$2a$10$Mcn32qmzmfdD9MPjIlZl1eF.K32Q6EtvWI0S8/V1Pa6vG4D7Rh.2m');

insert into ProgramSource (id, usersId, sourceName, sourceCode, verified)
                   values (1,  2,       'Default',
'move(1);
mine();', TRUE);

insert into ProgramSource (id, usersId, sourceName, sourceCode, verified)
                   values (2,  2,       'Test',
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
                   values (3,  2,       'Test-2',
'int rot = 0;

while (true)
{
    if (rot)
    {
        if (rot <= 90)
        {
            rotate(rot);
        }
        rot = rot - 10;
    }
    if (move(1.5) < 1)
    {
        move(-1);
        rotate(14);
    }
    while (mine())
    {
        rot = 100;
    }
}', TRUE);

insert into UserRobotPartAsset (usersId, robotPartId, totalOwned, unassigned) values (2, 101, 1, 0);
insert into UserRobotPartAsset (usersId, robotPartId, totalOwned, unassigned) values (2, 201, 1, 0);
insert into UserRobotPartAsset (usersId, robotPartId, totalOwned, unassigned) values (2, 301, 1, 0);
insert into UserRobotPartAsset (usersId, robotPartId, totalOwned, unassigned) values (2, 401, 1, 0);
insert into UserRobotPartAsset (usersId, robotPartId, totalOwned, unassigned) values (2, 501, 1, 0);
insert into UserRobotPartAsset (usersId, robotPartId, totalOwned, unassigned) values (2, 601, 1, 0);

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

insert into UserRobotPartAsset (usersId, robotPartId, totalOwned, unassigned) values (2, 102, 1, 0);
insert into UserRobotPartAsset (usersId, robotPartId, totalOwned, unassigned) values (2, 202, 1, 0);
insert into UserRobotPartAsset (usersId, robotPartId, totalOwned, unassigned) values (2, 302, 1, 0);
insert into UserRobotPartAsset (usersId, robotPartId, totalOwned, unassigned) values (2, 402, 1, 0);
insert into UserRobotPartAsset (usersId, robotPartId, totalOwned, unassigned) values (2, 502, 1, 0);
insert into UserRobotPartAsset (usersId, robotPartId, totalOwned, unassigned) values (2, 602, 1, 0);

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

insert into UserOreAsset (usersId, oreId, amount) values (2, 1, 9999);
insert into UserOreAsset (usersId, oreId, amount) values (2, 2, 9999);
insert into UserOreAsset (usersId, oreId, amount) values (2, 3, 9999);
insert into UserOreAsset (usersId, oreId, amount) values (2, 4, 9999);
insert into UserOreAsset (usersId, oreId, amount) values (2, 5, 9999);
