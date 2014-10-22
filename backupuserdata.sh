mysqldump --compact --no-create-info --complete-insert --skip-tz-utc -u root RoboMiner Users --where='id <> 1' > /media/sf_SharedMap/backupuserdata.sql

mysqldump --compact --no-create-info --complete-insert --skip-tz-utc -u root RoboMiner UserOreAsset ProgramSource UserRobotPartAsset >> /media/sf_SharedMap/backupuserdata.sql

mysqldump --compact --no-create-info --complete-insert --skip-tz-utc -u root RoboMiner Robot --where='usersId <> 1' >> /media/sf_SharedMap/backupuserdata.sql

mysqldump --compact --no-create-info --complete-insert --skip-tz-utc -u root RoboMiner PendingRobotChanges MiningAreaLifetimeResult UserMiningArea RallyResult RobotMiningAreaScore MiningQueue MiningOreResult RobotActionsDone RobotLifetimeResult UserAchievement >> /media/sf_SharedMap/backupuserdata.sql

