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

drop view if exists TopRobotsView;

drop table if exists PoolItemMiningTotals;
drop table if exists PoolItem;
drop table if exists Pool;
drop table if exists UserAchievement;
drop table if exists AchievementStepMiningScoreRequirement;
drop table if exists AchievementStepMiningTotalRequirement;
drop table if exists AchievementPredecessor;
drop table if exists AchievementStep;
drop table if exists Achievement;
drop table if exists RobotLifetimeResult;
drop table if exists RobotActionsDone;
drop table if exists MiningOreResult;
drop table if exists MiningQueue;
drop table if exists RobotMiningAreaScore;
drop table if exists RallyResult;
drop table if exists UserMiningArea;
drop table if exists MiningAreaLifetimeResult;
drop table if exists MiningAreaOreSupply;
drop table if exists MiningArea;
drop table if exists PendingRobotChanges;
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
password VARCHAR(255) NOT NULL,
achievementPoints INT NOT NULL DEFAULT 0,
miningQueueSize INT NOT NULL DEFAULT 0,
INDEX (username),
INDEX (email)
);


create table UserOreAsset
(
id INT AUTO_INCREMENT PRIMARY KEY,
usersId INT NOT NULL REFERENCES Users (id) ON DELETE CASCADE,
oreId INT NOT NULL REFERENCES Ore (id) ON DELETE CASCADE,
amount INT NOT NULL DEFAULT 0,
CONSTRAINT UNIQUE INDEX (usersId, oreId)
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
tierId INT NULL REFERENCES Ore (id) ON DELETE SET NULL,
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
id INT AUTO_INCREMENT PRIMARY KEY,
usersId INT NOT NULL REFERENCES Users (id) ON DELETE CASCADE,
robotPartId INT NOT NULL REFERENCES RobotPart (id) ON DELETE CASCADE,
totalOwned INT NOT NULL DEFAULT 0,
unassigned INT NOT NULL DEFAULT 0,
CONSTRAINT UNIQUE INDEX (usersId, robotPartId)
);
-- TODO: remove column 'unassigned'.


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
robotSize DOUBLE NOT NULL,
rechargeEndTime TIMESTAMP NOT NULL DEFAULT NOW(),
miningEndTime TIMESTAMP NULL,
totalMiningRuns INT NOT NULL DEFAULT 0
);


create table PendingRobotChanges
(
robotId INT PRIMARY KEY REFERENCES Robot (id) ON DELETE CASCADE,
submitTime TIMESTAMP NOT NULL DEFAULT NOW(),
sourceCode TEXT NOT NULL,
oreContainerId INT NULL REFERENCES RobotPart (id) ON DELETE CASCADE,
miningUnitId INT NULL REFERENCES RobotPart (id) ON DELETE CASCADE,
batteryId INT NULL REFERENCES RobotPart (id) ON DELETE CASCADE,
memoryModuleId INT NULL REFERENCES RobotPart (id) ON DELETE CASCADE,
cpuId INT NULL REFERENCES RobotPart (id) ON DELETE CASCADE,
engineId INT NULL REFERENCES RobotPart (id) ON DELETE CASCADE,
oldOreContainerId INT NULL REFERENCES RobotPart (id) ON DELETE CASCADE,
oldMiningUnitId INT NULL REFERENCES RobotPart (id) ON DELETE CASCADE,
oldBatteryId INT NULL REFERENCES RobotPart (id) ON DELETE CASCADE,
oldMemoryModuleId INT NULL REFERENCES RobotPart (id) ON DELETE CASCADE,
oldCpuId INT NULL REFERENCES RobotPart (id) ON DELETE CASCADE,
oldEngineId INT NULL REFERENCES RobotPart (id) ON DELETE CASCADE,
rechargeTime INT NOT NULL,
maxOre INT NOT NULL,
miningSpeed INT NOT NULL,
maxTurns INT NOT NULL,
memorySize INT NOT NULL,
cpuSpeed INT NOT NULL,
forwardSpeed DOUBLE NOT NULL,
backwardSpeed DOUBLE NOT NULL,
rotateSpeed INT NOT NULL,
robotSize DOUBLE NOT NULL,
changesCommitTime TIMESTAMP NULL
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


create table MiningAreaLifetimeResult
(
miningAreaId INT NOT NULL REFERENCES MiningArea (id) ON DELETE CASCADE,
oreId INT NOT NULL REFERENCES Ore (id) ON DELETE CASCADE,
totalAmount BIGINT NOT NULL,
totalContainerSize BIGINT NOT NULL,
PRIMARY KEY (miningAreaId, oreId)
);


create table UserMiningArea
(
usersId INT NOT NULL REFERENCES Users (id) ON DELETE CASCADE,
miningAreaId INT NOT NULL REFERENCES MiningArea (id) ON DELETE CASCADE,
PRIMARY KEY (usersId, miningAreaId)
);


create table RallyResult
(
id INT AUTO_INCREMENT PRIMARY KEY,
resultData MEDIUMTEXT NOT NULL
);


create table RobotMiningAreaScore
(
robotId INT NOT NULL REFERENCES Robot (id) ON DELETE CASCADE,
miningAreaId INT NOT NULL REFERENCES MiningArea (id) ON DELETE CASCADE,
totalRuns INT NOT NULL DEFAULT 0,
score DOUBLE NOT NULL DEFAULT .0,
PRIMARY KEY (robotId, miningAreaId),
INDEX (miningAreaId, score)
);


create table MiningQueue
(
id INT AUTO_INCREMENT PRIMARY KEY,
miningAreaId INT NOT NULL REFERENCES MiningArea (id) ON DELETE CASCADE,
robotId INT NOT NULL REFERENCES Robot (id) ON DELETE CASCADE,
rallyResultId INT NULL REFERENCES RallyResult (id) ON DELETE SET NULL,
playerNumber INT NULL,
score DOUBLE NULL,
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


create table RobotActionsDone
(
miningQueueId INT NOT NULL REFERENCES MiningQueue (id) ON DELETE CASCADE,
actionType INT NOT NULL,
amount INT NOT NULL,
PRIMARY KEY (miningQueueId, actionType)
);


create table RobotLifetimeResult
(
id INT AUTO_INCREMENT PRIMARY KEY,
robotId INT NOT NULL REFERENCES Robot (id) ON DELETE CASCADE,
oreId INT NOT NULL REFERENCES Ore (id) ON DELETE CASCADE,
amount INT NOT NULL,
tax INT NOT NULL,
CONSTRAINT UNIQUE INDEX (robotId, oreId)
);


create table Achievement
(
id INT AUTO_INCREMENT PRIMARY KEY,
title VARCHAR(255) NOT NULL,
description TEXT NOT NULL
);

create table AchievementStep
(
id INT AUTO_INCREMENT PRIMARY KEY,
achievementId INT NOT NULL REFERENCES Achievement (id) ON DELETE CASCADE,
step INT NOT NULL,
achievementPoints INT NOT NULL DEFAULT 10,
miningQueueReward INT NOT NULL DEFAULT 0,
robotReward INT NOT NULL DEFAULT 0,
miningAreaId INT NULL REFERENCES MiningArea (id) ON DELETE SET NULL,
CONSTRAINT UNIQUE INDEX (achievementId, step)
);


create table AchievementPredecessor
(
id INT AUTO_INCREMENT PRIMARY KEY,
predecessorId INT NOT NULL REFERENCES Achievement (id) ON DELETE CASCADE,
predecessorStep INT NOT NULL,
successorId INT NOT NULL REFERENCES Achievement (id) ON DELETE CASCADE,
CONSTRAINT UNIQUE INDEX (predecessorId, successorId)
);


create table AchievementStepMiningTotalRequirement
(
id INT AUTO_INCREMENT PRIMARY KEY,
achievementStepId INT NOT NULL REFERENCES AchievementStep (id) ON DELETE CASCADE,
oreId INT NOT NULL REFERENCES Ore (id) ON DELETE CASCADE,
amount INT NOT NULL,
CONSTRAINT UNIQUE INDEX (AchievementStepId, oreId)
);


create table AchievementStepMiningScoreRequirement
(
id INT AUTO_INCREMENT PRIMARY KEY,
achievementStepId INT NOT NULL REFERENCES AchievementStep (id) ON DELETE CASCADE,
miningAreaId INT NOT NULL REFERENCES MiningArea (id) ON DELETE CASCADE,
minimumScore DOUBLE NOT NULL,
CONSTRAINT UNIQUE INDEX (achievementStepId, miningAreaId)
);


create table UserAchievement
(
id INT AUTO_INCREMENT PRIMARY KEY,
usersId INT NOT NULL REFERENCES Users (id) ON DELETE CASCADE,
achievementId INT NOT NULL REFERENCES Achievement (id) ON DELETE CASCADE,
stepsClaimed INT NOT NULL DEFAULT 0,
CONSTRAINT UNIQUE INDEX (usersId, achievementId)
);


create view TopRobotsView
as
select Robot.id as robotId,
       Robot.robotName as robotName,
       Users.username as username,
       count(distinct MiningQueue.id) as totalRuns,
       sum(MiningOreResult.amount) as totalAmount,
       sum(MiningOreResult.amount) / count(distinct MiningQueue.id) as orePerRun
from Robot
inner join Users
on Users.id = Robot.usersId
left outer join MiningQueue
on MiningQueue.robotId = Robot.id and MiningQueue.claimed = true
left outer join MiningOreResult
on MiningOreResult.miningQueueId = MiningQueue.id
group by Robot.id;


create table Pool
(
id INT AUTO_INCREMENT PRIMARY KEY,
miningAreaId INT NOT NULL REFERENCES MiningArea (id) ON DELETE CASCADE,
requiredRuns INT NOT NULL
);


create table PoolItem
(
id INT AUTO_INCREMENT PRIMARY KEY,
poolId INT NOT NULL REFERENCES Pool (id) ON DELETE CASCADE,
robotId INT NOT NULL REFERENCES Robot (id) ON DELETE CASCADE,
sourceCode TEXT NOT NULL,
totalScore DOUBLE NOT NULL DEFAULT 0,
runsDone INT NOT NULL DEFAULT 0,
INDEX (runsDone, totalScore, id)
);


create table PoolItemMiningTotals
(
poolItemId INT NOT NULL REFERENCES PoolItem (id) ON DELETE CASCADE,
oreId INT NOT NULL REFERENCES Ore (id) ON DELETE CASCADE,
totalMined BIGINT NOT NULL DEFAULT 0,
PRIMARY KEY (poolItemId, oreId)
);
