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


-- Database cleaning

-- Remove unlinked items from AchievementPredecessor
delete
from AchievementPredecessor
where not exists
(
select *
from Achievement
where Achievement.id = AchievementPredecessor.predecessorId
)
or not exists
(
select *
from Achievement
where Achievement.id = AchievementPredecessor.successorId
);

-- Remove unlinked items from AchievementMiningTotalRequirement
delete
from AchievementMiningTotalRequirement
where not exists
(
select *
from Achievement
where Achievement.id = AchievementMiningTotalRequirement.achievementId
)
or not exists
(
select *
from Ore
where Ore.id = AchievementMiningTotalRequirement.oreId
)
;

-- Remove unlinked items from AchievementMiningScoreRequirement
delete
from AchievementMiningScoreRequirement
where not exists
(
select *
from Achievement
where Achievement.id = AchievementMiningScoreRequirement.achievementId
)
or not exists
(
select *
from MiningArea
where MiningArea.id = AchievementMiningScoreRequirement.miningAreaId
)
;

-- Remove unlinked items from Robot
delete
from Robot
where not exists
(
select *
from Users
where Users.id = Robot.usersId
);

-- Remove unlinked items from RobotDailyResult
delete
from RobotDailyResult
where not exists
(
select *
from Robot
where Robot.id = RobotDailyResult.robotId
)
or not exists
(
select *
from Ore
where Ore.id = RobotDailyResult.oreId
);

-- Remove unlinked items from RobotLifetimeResult
delete
from RobotLifetimeResult
where not exists
(
select *
from Robot
where Robot.id = RobotLifetimeResult.robotId
)
or not exists
(
select *
from Ore
where Ore.id = RobotLifetimeResult.oreId
);

-- Remove unlinked items from RobotDailyRuns
delete
from RobotDailyRuns
where not exists
(
select *
from Robot
where Robot.id = RobotDailyRuns.robotId
);

-- Remove unlinked items from RobotMiningAreaScore
delete
from RobotMiningAreaScore
where not exists
(
select *
from Robot
where Robot.id = RobotMiningAreaScore.robotId
)
or not exists
(
select *
from MiningArea
where MiningArea.id = RobotMiningAreaScore.miningAreaId
);

-- Remove unlinked items from ProgramSource
delete
from ProgramSource
where not exists
(
select *
from Users
where Users.id = ProgramSource.usersId
);

-- Remove unlinked items from UserAchievement
delete
from UserAchievement
where not exists
(
select *
from Users
where Users.id = UserAchievement.usersId
)
or not exists
(
select *
from Achievement
where Achievement.id = UserAchievement.achievementId
);

-- Remove unlinked items from UserMiningArea
delete
from UserMiningArea
where not exists
(
select *
from Users
where Users.id = UserMiningArea.usersId
)
or not exists
(
select *
from MiningArea
where MiningArea.id = UserMiningArea.miningAreaId
);

-- Remove unlinked items from UserOreAsset
delete
from UserOreAsset
where not exists
(
select *
from Users
where Users.id = UserOreAsset.usersId
)
or not exists
(
select *
from Ore
where Ore.id = UserOreAsset.oreId
);

-- Remove unlinked items from UserRobotPartAsset
delete
from UserRobotPartAsset
where not exists
(
select *
from Users
where Users.id = UserRobotPartAsset.usersId
)
or not exists
(
select *
from RobotPart
where RobotPart.id = UserRobotPartAsset.robotPartId
);

-- Remove unlinked items from MiningQueue
delete
from MiningQueue
where not exists
(
select *
from Robot
where Robot.id = MiningQueue.robotId
)
or not exists
(
select *
from MiningArea
where MiningArea.id = MiningQueue.miningAreaId
);

-- Remove unlinked items from MiningOreResult
delete
from MiningOreResult
where not exists
(
select *
from MiningQueue
where MiningQueue.id = MiningOreResult.miningQueueId
)
or not exists
(
select *
from Ore
where Ore.id = MiningOreResult.oreId
);

-- Remove unlinked items from RobotActionsDone
delete
from RobotActionsDone
where not exists
(
select *
from MiningQueue
where MiningQueue.id = RobotActionsDone.miningQueueId
);

-- Remove unlinked items from RallyResult
delete
from RallyResult
where not exists
(
select *
from MiningQueue
where MiningQueue.rallyResultId = RallyResult.id
);


-- Update user values

-- Update the number of achievement points
update Users
set achievementPoints =
(
select coalesce(sum(Achievement.achievementPoints), 0)
from UserAchievement
inner join Achievement
on Achievement.id = UserAchievement.achievementId
where UserAchievement.usersId = Users.id
and UserAchievement.claimed = true
);


-- Update the mining queue size
update Users
set miningQueueSize =
(
select coalesce(sum(Achievement.miningQueueReward), 0)
from UserAchievement
inner join Achievement
on Achievement.id = UserAchievement.achievementId
where UserAchievement.usersId = Users.id
and UserAchievement.claimed = true
);


-- Update the available mining areas earned with achievements
delete from UserMiningArea;

insert into UserMiningArea
(usersId, miningAreaId)
select UserAchievement.usersId, Achievement.miningAreaId
from UserAchievement
inner join Achievement
on Achievement.id = UserAchievement.achievementId
where UserAchievement.claimed = true
and Achievement.miningAreaId IS NOT NULL;


-- Add missing UserAchievement records
insert into UserAchievement
(usersId, achievementId, claimed)
select Users.id, Achievement.id, false
from Achievement, Users
where not exists
(
select *
from UserAchievement
where UserAchievement.usersId = Users.id
and UserAchievement.achievementId = Achievement.id
)
and not exists
(
select *
from AchievementPredecessor
inner join UserAchievement
on UserAchievement.achievementId = AchievementPredecessor.predecessorId
where AchievementPredecessor.successorId = Achievement.id
and UserAchievement.usersId = Users.id
and (UserAchievement.claimed IS NULL or UserAchievement.claimed = false)
)
and not exists
(
select *
from AchievementPredecessor
where AchievementPredecessor.successorId = Achievement.id
and not exists
(
select *
from UserAchievement
where UserAchievement.usersId = Users.id
and UserAchievement.achievementId = AchievementPredecessor.predecessorId
)
);


-- Update the tier levels
update RobotPart
set tierId = 
(
select max(OrePriceAmount.oreId)
from OrePriceAmount
where OrePriceAmount.orePriceId = RobotPart.orePriceId
);
