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
drop table if exists AchievementMiningTotalRequirement;
drop table if exists AchievementPredecessor;
drop table if exists Achievement;
drop table if exists RobotDailyResult;
drop table if exists RobotDailyRuns;
drop table if exists RobotLifetimeResult;
drop table if exists MiningOreResult;
drop table if exists MiningQueue;
drop table if exists RobotMiningAreaScore;
drop table if exists RallyResult;
drop table if exists UserMiningArea;
drop table if exists MiningAreaLifetimeResult;
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
password VARCHAR(255) NOT NULL,
achievementPoints INT NOT NULL DEFAULT 0,
miningQueueSize INT NOT NULL DEFAULT 0,
INDEX (username),
INDEX (email)
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


create table Achievement
(
id INT AUTO_INCREMENT PRIMARY KEY,
title VARCHAR(255) NOT NULL,
description TEXT NOT NULL,
achievementPoints INT NOT NULL DEFAULT 10,
miningQueueReward INT NOT NULL DEFAULT 0,
robotReward INT NOT NULL DEFAULT 0,
miningAreaId INT NULL REFERENCES MiningArea (id) ON DELETE SET NULL
);


create table AchievementPredecessor
(
predecessorId INT NOT NULL REFERENCES Achievement (id) ON DELETE CASCADE,
successorId INT NOT NULL REFERENCES Achievement (id) ON DELETE CASCADE,
PRIMARY KEY (predecessorId, successorId)
);


create table AchievementMiningTotalRequirement
(
achievementId INT NOT NULL REFERENCES Achievement (id) ON DELETE CASCADE,
oreId INT NOT NULL REFERENCES Ore (id) ON DELETE CASCADE,
amount INT NOT NULL,
PRIMARY KEY (achievementId, oreId)
);


create table AchievementMiningScoreRequirement
(
achievementId INT NOT NULL REFERENCES Achievement (id) ON DELETE CASCADE,
miningAreaId INT NOT NULL REFERENCES MiningArea (id) ON DELETE CASCADE,
minimumScore DOUBLE NOT NULL,
PRIMARY KEY (achievementId, miningAreaId)
);


create table UserAchievement
(
usersId INT NOT NULL REFERENCES Users (id) ON DELETE CASCADE,
achievementId INT NOT NULL REFERENCES Achievement (id) ON DELETE CASCADE,
claimed BOOL NOT NULL DEFAULT FALSE,
PRIMARY KEY (usersId, achievementId)
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
index (runsDone, totalScore, id)
);


create table PoolItemMiningTotals
(
poolItemId INT NOT NULL REFERENCES PoolItem (id) ON DELETE CASCADE,
oreId INT NOT NULL REFERENCES Ore (id) ON DELETE CASCADE,
totalMined BIGINT NOT NULL DEFAULT 0,
PRIMARY KEY (poolItemId, oreId)
);
