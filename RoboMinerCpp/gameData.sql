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
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1031, 103, 1, 50);
insert into RobotPart (id,  typeId, partName,                  orePriceId, oreCapacity, weight, volume, powerUsage)
               values (103, 1,      'Cerbonium Ore Container', 103,        30,          15,     35,     3);

insert into OrePrice (id, description) values (110, 'Oxaria Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1102, 110, 2, 20);
insert into RobotPart (id,  typeId, partName,               orePriceId, oreCapacity, weight, volume, powerUsage)
               values (110, 1,      'Oxaria Ore Container', 110,        35,          16,     40,     4);

insert into OrePrice (id, description) values (111, 'Enhanced Oxaria Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1111, 111, 1, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1112, 111, 2, 50);
insert into RobotPart (id,  typeId, partName,                        orePriceId, oreCapacity, weight, volume, powerUsage)
               values (111, 1,      'Enhanced Oxaria Ore Container', 111,        40,          18,     45,     5);

insert into OrePrice (id, description) values (120, 'Lithabine Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1201, 120, 1, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1202, 120, 2, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1203, 120, 3, 10);
insert into RobotPart (id,  typeId, partName,                  orePriceId, oreCapacity, weight, volume, powerUsage)
               values (120, 1,      'Lithabine Ore Container', 120,        45,          20,     50,     6);

insert into OrePrice (id, description) values (121, 'Enhanced Lithabine Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1211, 121, 1, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1212, 121, 2, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1213, 121, 3, 50);
insert into RobotPart (id,  typeId, partName,                           orePriceId, oreCapacity, weight, volume, powerUsage)
               values (121, 1,      'Enhanced Lithabine Ore Container', 121,        50,          22,     55,     7);

insert into OrePrice (id, description) values (130, 'Neudralion Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1302, 130, 2, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1303, 130, 3, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1304, 130, 4, 15);
insert into RobotPart (id,  typeId, partName,                   orePriceId, oreCapacity, weight, volume, powerUsage)
               values (130, 1,      'Neudralion Ore Container', 130,        55,          24,     60,     8);

insert into OrePrice (id, description) values (131, 'Enhanced Neudralion Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1312, 131, 2, 350);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1313, 131, 3, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1314, 131, 4, 60);
insert into RobotPart (id,  typeId, partName,                            orePriceId, oreCapacity, weight, volume, powerUsage)
               values (131, 1,      'Enhanced Neudralion Ore Container', 131,        60,          26,     65,     9);

insert into OrePrice (id, description) values (140, 'Neudralion Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1403, 140, 3, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1404, 140, 4, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1405, 140, 5, 10);
insert into RobotPart (id,  typeId, partName,                  orePriceId, oreCapacity, weight, volume, powerUsage)
               values (140, 1,      'Complatix Ore Container', 140,        65,          28,     70,     10);

insert into OrePrice (id, description) values (141, 'Enhanced Neudralion Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1413, 141, 3, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1414, 141, 4, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1415, 141, 5, 75);
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
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2031, 203, 1, 50);
insert into RobotPart (id,  typeId, partName,                orePriceId, miningCapacity, weight, volume, powerUsage)
               values (203, 2,      'Cerbonium Mining Unit', 203,        2,              15,     9,      11);

insert into OrePrice (id, description) values (210, 'Oxaria Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2102, 210, 2, 20);
insert into RobotPart (id,  typeId, partName,             orePriceId, miningCapacity, weight, volume, powerUsage)
               values (210, 2,      'Oxaria Mining Unit', 210,        3,              18,     11,     16);

insert into OrePrice (id, description) values (211, 'Enhanced Oxaria Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2111, 211, 1, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2112, 211, 2, 50);
insert into RobotPart (id,  typeId, partName,                      orePriceId, miningCapacity, weight, volume, powerUsage)
               values (211, 2,      'Enhanced Oxaria Mining Unit', 211,        3,              19,     12,     15);

insert into OrePrice (id, description) values (220, 'Lithabine Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2201, 220, 1, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2202, 220, 2, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2203, 220, 3, 10);
insert into RobotPart (id,  typeId, partName,                orePriceId, miningCapacity, weight, volume, powerUsage)
               values (220, 2,      'Lithabine Mining Unit', 220,        4,              20,     13,     18);

insert into OrePrice (id, description) values (221, 'Enhanced Lithabine Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2211, 221, 1, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2212, 221, 2, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2213, 221, 3, 50);
insert into RobotPart (id,  typeId, partName,                         orePriceId, miningCapacity, weight, volume, powerUsage)
               values (221, 2,      'Enhanced Lithabine Mining Unit', 221,        4,              21,     14,     17);

insert into OrePrice (id, description) values (230, 'Neudralion Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2302, 230, 2, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2303, 230, 3, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2304, 230, 4, 15);
insert into RobotPart (id,  typeId, partName,                 orePriceId, miningCapacity, weight, volume, powerUsage)
               values (230, 2,      'Neudralion Mining Unit', 230,        5,              22,     15,     20);

insert into OrePrice (id, description) values (231, 'Enhanced Neudralion Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2312, 231, 2, 350);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2313, 231, 3, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2314, 231, 4, 60);
insert into RobotPart (id,  typeId, partName,                          orePriceId, miningCapacity, weight, volume, powerUsage)
               values (231, 2,      'Enhanced Neudralion Mining Unit', 231,        5,              23,     16,     19);

insert into OrePrice (id, description) values (240, 'Complatix Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2403, 240, 3, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2404, 240, 4, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2405, 240, 5, 10);
insert into RobotPart (id,  typeId, partName,                orePriceId, miningCapacity, weight, volume, powerUsage)
               values (240, 2,      'Complatix Mining Unit', 240,        6,              24,     17,     25);

insert into OrePrice (id, description) values (241, 'Enhanced Complatix Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2413, 241, 3, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2414, 241, 4, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2415, 241, 5, 75);
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
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3031, 303, 1, 50);
insert into RobotPart (id,  typeId, partName,            orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (303, 3,      'Cerbonium Battery', 303,        6000,            15,           4,      3,      0);

insert into OrePrice (id, description) values (310, 'Oxaria Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3102, 310, 2, 20);
insert into RobotPart (id,  typeId, partName,         orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (310, 3,      'Oxaria Battery', 310,        9500,            30,           5,      3,      0);

insert into OrePrice (id, description) values (311, 'Enhanced Oxaria Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3111, 311, 1, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3112, 311, 2, 50);
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
               values (320, 3,      'Lithabine Battery', 320,        22000,           75,           6,      5,      0);

insert into OrePrice (id, description) values (321, 'Enhanced Lithabine Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3211, 321, 1, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3212, 321, 2, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3213, 321, 3, 50);
insert into RobotPart (id,  typeId, partName,                     orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (321, 3,      'Enhanced Lithabine Battery', 321,        25000,           90,           7,      6,      0);

insert into OrePrice (id, description) values (330, 'Neudralion Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3302, 330, 2, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3303, 330, 3, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3304, 330, 4, 15);
insert into RobotPart (id,  typeId, partName,             orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (330, 3,      'Neudralion Battery', 330,        34000,           120,           8,      7,      0);

insert into OrePrice (id, description) values (331, 'Enhanced Neudralion Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3312, 331, 2, 350);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3313, 331, 3, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3314, 331, 4, 60);
insert into RobotPart (id,  typeId, partName,                      orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (331, 3,      'Enhanced Neudralion Battery', 331,        42000,           180,          9,      8,      0);

insert into OrePrice (id, description) values (340, 'Complatix Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3403, 340, 3, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3404, 340, 4, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3405, 340, 5, 10);
insert into RobotPart (id,  typeId, partName,            orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (340, 3,      'Complatix Battery', 340,        56000,           240,          10,     9,      0);

insert into OrePrice (id, description) values (341, 'Enhanced Complatix Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3413, 341, 3, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3414, 341, 4, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3415, 341, 5, 75);
insert into RobotPart (id,  typeId, partName,                     orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (341, 3,      'Enhanced Complatix Battery', 341,        72000,           300,          11,     10,      0);

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
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4031, 403, 1, 50);
insert into RobotPart (id,  typeId, partName,           orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (403, 4,      'Memory Module 24', 403,        24,             1,      1,      3);

insert into OrePrice (id, description) values (410, 'Memory Module 32 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4102, 410, 2, 20);
insert into RobotPart (id,  typeId, partName,           orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (410, 4,      'Memory Module 32', 410,        32,             1,      1,      4);

insert into OrePrice (id, description) values (411, 'Memory Module 48 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4111, 411, 1, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4112, 411, 2, 50);
insert into RobotPart (id,  typeId, partName,           orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (411, 4,      'Memory Module 48', 411,        48,             1,      1,      5);

insert into OrePrice (id, description) values (420, 'Memory Module 64 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4201, 420, 1, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4202, 420, 2, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4203, 420, 3, 10);
insert into RobotPart (id,  typeId, partName,           orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (420, 4,      'Memory Module 64', 420,        64,             1,      1,      6);

insert into OrePrice (id, description) values (421, 'Memory Module 96 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4211, 421, 1, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4212, 421, 2, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4213, 421, 3, 50);
insert into RobotPart (id,  typeId, partName,           orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (421, 4,      'Memory Module 96', 421,        96,             1,      1,      7);

insert into OrePrice (id, description) values (430, 'Memory Module 128 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4302, 430, 2, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4303, 430, 3, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4304, 430, 4, 15);
insert into RobotPart (id,  typeId, partName,            orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (430, 4,      'Memory Module 128', 430,        128,            1,      1,      8);

insert into OrePrice (id, description) values (431, 'Memory Module 196 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4312, 431, 2, 350);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4313, 431, 3, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4314, 431, 4, 60);
insert into RobotPart (id,  typeId, partName,            orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (431, 4,      'Memory Module 196', 431,        196,            1,      1,      9);

insert into OrePrice (id, description) values (440, 'Memory Module 256 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4403, 440, 3, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4404, 440, 4, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4405, 440, 5, 10);
insert into RobotPart (id,  typeId, partName,            orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (440, 4,      'Memory Module 256', 440,        256,            1,      1,      10);

insert into OrePrice (id, description) values (441, 'Memory Module 384 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4413, 441, 3, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4414, 441, 4, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4415, 441, 5, 75);
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
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5102, 510, 2, 20);
insert into RobotPart (id,  typeId, partName,    orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (510, 5,      'CPU 3 ipc', 510,        3,           1,      1,      3);

insert into OrePrice (id, description) values (511, 'CPU 4 ipc price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5111, 511, 1, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5112, 511, 2, 50);
insert into RobotPart (id,  typeId, partName,    orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (511, 5,      'CPU 4 ipc', 511,        4,           1,      1,      4);

insert into OrePrice (id, description) values (520, 'CPU 5 ipc price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5201, 520, 1, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5202, 520, 2, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5203, 520, 3, 10);
insert into RobotPart (id,  typeId, partName,    orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (520, 5,      'CPU 5 ipc', 520,        5,           1,      1,      5);

insert into OrePrice (id, description) values (521, 'CPU 6 ipc price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5211, 521, 1, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5212, 521, 2, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5213, 521, 3, 50);
insert into RobotPart (id,  typeId, partName,    orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (521, 5,      'CPU 6 ipc', 521,        6,           1,      1,      6);

insert into OrePrice (id, description) values (530, 'CPU 7 ipc price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5302, 530, 2, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5303, 530, 3, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5304, 530, 4, 15);
insert into RobotPart (id,  typeId, partName,    orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (530, 5,      'CPU 7 ipc', 530,        7,           1,      1,      7);

insert into OrePrice (id, description) values (531, 'CPU 8 ipc price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5312, 531, 2, 350);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5313, 531, 3, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5314, 531, 4, 60);
insert into RobotPart (id,  typeId, partName,    orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (531, 5,      'CPU 8 ipc', 531,        8,           1,      1,      6);

insert into OrePrice (id, description) values (540, 'CPU 9 ipc price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5403, 540, 3, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5404, 540, 4, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5405, 540, 5, 10);
insert into RobotPart (id,  typeId, partName,    orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (540, 5,      'CPU 9 ipc', 540,        9,           1,      1,      9);

insert into OrePrice (id, description) values (541, 'CPU 10 ipc price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5413, 541, 3, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5414, 541, 4, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5415, 541, 5, 75);
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
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6031, 603, 1, 50);
insert into RobotPart (id,  typeId, partName,        orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (603, 6,      'Engine 100/40', 603,        100,             40,               40,             12,     7,      15);

insert into OrePrice (id, description) values (610, 'Engine 95 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6102, 610, 2, 20);
insert into RobotPart (id,  typeId, partName,    orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (610, 6,      'Engine 95', 610,        95,              95,               95,             14,     8,      28);

insert into OrePrice (id, description) values (611, 'Engine 90E price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6111, 611, 1, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6112, 611, 2, 50);
insert into RobotPart (id,  typeId, partName,     orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (611, 6,      'Engine 90E', 611,        90,              90,               90,             14,     9,      25);

insert into OrePrice (id, description) values (620, 'Engine 100 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6201, 620, 1, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6202, 620, 2, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6203, 620, 3, 10);
insert into RobotPart (id,  typeId, partName,     orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (620, 6,      'Engine 100', 620,        100,             100,              100,            16,     10,     30);

insert into OrePrice (id, description) values (621, 'Engine 95E price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6211, 621, 1, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6212, 621, 2, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6213, 621, 3, 50);
insert into RobotPart (id,  typeId, partName,     orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (621, 6,      'Engine 95E', 621,        95,              95,               95,             16,     11,     28);

insert into OrePrice (id, description) values (630, 'Engine 120 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6302, 630, 2, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6303, 630, 3, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6304, 630, 4, 15);
insert into RobotPart (id,  typeId, partName,     orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (630, 6,      'Engine 120', 630,        120,             120,              120,            18,     12,     40);

insert into OrePrice (id, description) values (631, 'Engine 110E price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6312, 631, 2, 350);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6313, 631, 3, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6314, 631, 4, 60);
insert into RobotPart (id,  typeId, partName,      orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (631, 6,      'Engine 110E', 631,        110,             110,              110,            18,     13,     38);

insert into OrePrice (id, description) values (640, 'Engine 150 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6403, 640, 3, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6404, 640, 4, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6405, 640, 5, 10);
insert into RobotPart (id,  typeId, partName,     orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (640, 6,      'Engine 150', 640,        150,             150,              150,            20,     14,     50);

insert into OrePrice (id, description) values (641, 'Engine 140E price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6413, 641, 3, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6414, 641, 4, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6415, 641, 5, 75);
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
                values (1002, 'Cerbonium-2', 1002,       25,    25,    250,      30,         0,       1);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1002, 1, 20, 5);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1002, 1, 20, 3);

-- Oxaria
insert into OrePrice (id, description) values (1101, 'Mining Area Oxaria-1 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (11011, 1101, 1, 10);
insert into MiningArea (id,   areaName,   orePriceId, sizeX, sizeY, maxMoves, miningTime, taxRate, aiRobotId)
                values (1101, 'Oxaria-1', 1101,       30,    30,    250,      60,         25,      2);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1101, 1, 20, 4);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1101, 2, 10, 4);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1101, 2, 5,  4);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1101, 2, 5,  4);

insert into OrePrice (id, description) values (1102, 'Mining Area Oxaria-2 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (11021, 1102, 1, 10);
insert into MiningArea (id,   areaName,   orePriceId, sizeX, sizeY, maxMoves, miningTime, taxRate, aiRobotId)
                values (1102, 'Oxaria-2', 1102,       35,    35,    300,      90,         40,      2);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1102, 2, 10, 4);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1102, 2, 10, 4);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1102, 2, 5,  4);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1102, 2, 5,  4);

-- Lithabine
insert into OrePrice (id, description) values (1201, 'Mining Area Lithabine-1 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (12011, 1201, 1, 15);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (12012, 1201, 2, 10);
insert into MiningArea (id,   areaName,      orePriceId, sizeX, sizeY, maxMoves, miningTime, taxRate, aiRobotId)
                values (1201, 'Lithabine-1', 1201,       40,    40,    350,      120,        25,      3);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1201, 1, 10, 6);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1201, 2, 10, 5);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1201, 3, 5, 5);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1201, 3, 5, 4);

insert into OrePrice (id, description) values (1202, 'Mining Area Lithabine-2 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (12021, 1202, 1, 20);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (12022, 1202, 2, 15);
insert into MiningArea (id,   areaName,      orePriceId, sizeX, sizeY, maxMoves, miningTime, taxRate, aiRobotId)
                values (1202, 'Lithabine-2', 1202,       45,    45,    400,      120,        10,      3);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1202, 1, 10, 5);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1202, 2, 10, 4);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1202, 3, 4, 6);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1202, 3, 4, 6);

-- Neudralion
insert into OrePrice (id, description) values (1301, 'Mining Area Neudralion-1 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (13011, 1301, 1, 20);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (13012, 1301, 2, 15);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (13013, 1301, 3, 15);
insert into MiningArea (id,   areaName,       orePriceId, sizeX, sizeY, maxMoves, miningTime, taxRate, aiRobotId)
                values (1301, 'Neudralion-1', 1301,       50,    50,    450,      300,        40,      3);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1301, 2, 10, 6);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1301, 3, 10, 5);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1301, 4, 5, 5);

insert into OrePrice (id, description) values (1302, 'Mining Area Neudralion-2 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (13021, 1302, 1, 25);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (13022, 1302, 2, 20);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (13023, 1302, 3, 15);
insert into MiningArea (id,   areaName,       orePriceId, sizeX, sizeY, maxMoves, miningTime, taxRate, aiRobotId)
                values (1302, 'Neudralion-2', 1302,       55,    55,    500,     420,        50,      3);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1302, 2, 10, 6);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1302, 3, 10, 5);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1302, 4, 5, 5);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1302, 4, 5, 5);

-- Complatix
insert into OrePrice (id, description) values (1401, 'Mining Area Complatix-1 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (14011, 1401, 1, 25);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (14012, 1401, 2, 20);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (14013, 1401, 3, 15);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (14014, 1401, 4, 10);
insert into MiningArea (id,   areaName,      orePriceId, sizeX, sizeY, maxMoves, miningTime, taxRate, aiRobotId)
                values (1401, 'Complatix-1', 1401,       60,    60,    600,      900,        50,      3);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1401, 3, 10, 6);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1401, 4, 10, 5);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1401, 5, 5, 5);

insert into OrePrice (id, description) values (1402, 'Mining Area Complatix-2 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (14021, 1402, 1, 30);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (14022, 1402, 2, 25);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (14023, 1402, 3, 20);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (14024, 1402, 4, 15);
insert into MiningArea (id,   areaName,      orePriceId, sizeX, sizeY, maxMoves, miningTime, taxRate, aiRobotId)
                values (1402, 'Complatix-2', 1402,       65,    65,    700,      3600,       50,      3);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1402, 3, 10, 6);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1402, 4, 10, 6);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1402, 5, 5, 5);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1402, 5, 5, 5);

-- Achievements
insert into Achievement (id, title,              description,              achievementPoints, robotReward, miningQueueReward, miningAreaId)
                 values (1,  'Your first robot', 'Claim your first robot', 10,                1,           1,                 1001);

insert into Achievement (id, title,          description,           achievementPoints, miningQueueReward)
                 values (11, 'First mining', 'Mine some Cerbonium', 10,                1);

insert into AchievementPredecessor (predecessorId, successorId) values (1, 11);

insert into AchievementMiningTotalRequirement (achievementId, oreId, amount) values (11, 1, 1);


insert into Achievement (id, title,           description,                                           achievementPoints, miningQueueReward)
                 values (12, 'Shopping cash', 'Mine enough Cerbonium to buy an upgrade in the shop', 10,                1);

insert into AchievementPredecessor (predecessorId, successorId) values (11, 12);

insert into AchievementMiningTotalRequirement (achievementId, oreId, amount) values (12, 1, 10);


insert into Achievement (id, title,              description,                                        achievementPoints, miningQueueReward, miningAreaId)
                 values (13, 'Better equipment', 'Mine more Cerbonium to buy even better equipment', 10,                1,                 1101);

insert into AchievementPredecessor (predecessorId, successorId) values (12, 13);

insert into AchievementMiningTotalRequirement (achievementId, oreId, amount) values (13, 1, 250);


insert into Achievement (id, title,             description,                achievementPoints)
                 values (14, 'More Cerbonium!', 'Mine even more Cerbonium', 10);

insert into AchievementPredecessor (predecessorId, successorId) values (13, 14);

insert into AchievementMiningTotalRequirement (achievementId, oreId, amount) values (14, 1, 1000);


insert into Achievement (id, title,             description,                achievementPoints)
                 values (15, 'More Cerbonium!', 'Mine even more Cerbonium', 10);

insert into AchievementPredecessor (predecessorId, successorId) values (14, 15);

insert into AchievementMiningTotalRequirement (achievementId, oreId, amount) values (15, 1, 10000);


insert into Achievement (id, title,             description,                achievementPoints)
                 values (16, 'More Cerbonium!', 'Mine even more Cerbonium', 10);

insert into AchievementPredecessor (predecessorId, successorId) values (15, 16);

insert into AchievementMiningTotalRequirement (achievementId, oreId, amount) values (16, 1, 100000);


insert into Achievement (id,  title,           description,                       achievementPoints, miningQueueReward)
                 values (100, 'Oxaria mining', 'Start mining better quality ore', 10,                1);

insert into AchievementPredecessor (predecessorId, successorId) values (3, 100);

insert into AchievementMiningTotalRequirement (achievementId, oreId, amount) values (100, 2, 1);


insert into Achievement (id,  title,              description,                                           achievementPoints, miningQueueReward, miningAreaId)
                 values (101, 'Oxaria equipment', 'Mine enough Oxaria ore for Oxaria-quality equipment', 10,                1,                 1201);

insert into AchievementPredecessor (predecessorId, successorId) values (100, 101);

insert into AchievementMiningTotalRequirement (achievementId, oreId, amount) values (101, 2, 100);


insert into Achievement (id, title,            description,                 achievementPoints)
                 values (102,  'More Oxaria!', 'Mine even more Oxaria ore', 10);

insert into AchievementPredecessor (predecessorId, successorId) values (101, 102);

insert into AchievementMiningTotalRequirement (achievementId, oreId, amount) values (102, 2, 1000);


insert into Achievement (id, title,            description,                 achievementPoints)
                 values (103,  'More Oxaria!', 'Mine even more Oxaria ore', 10);

insert into AchievementPredecessor (predecessorId, successorId) values (102, 103);

insert into AchievementMiningTotalRequirement (achievementId, oreId, amount) values (103, 2, 10000);


insert into Achievement (id, title,            description,                 achievementPoints)
                 values (104,  'More Oxaria!', 'Mine even more Oxaria ore', 10);

insert into AchievementPredecessor (predecessorId, successorId) values (103, 104);

insert into AchievementMiningTotalRequirement (achievementId, oreId, amount) values (104, 2, 100000);


insert into Achievement (id, title,            description,                 achievementPoints)
                 values (105,  'More Oxaria!', 'Mine even more Oxaria ore', 10);

insert into AchievementPredecessor (predecessorId, successorId) values (104, 105);

insert into AchievementMiningTotalRequirement (achievementId, oreId, amount) values (105, 2, 1000000);


insert into Achievement (id,  title,              description,                  achievementPoints, miningQueueReward)
                 values (200, 'Lithabine mining', 'Start mining Lithabine ore', 10,                1);

insert into AchievementPredecessor (predecessorId, successorId) values (102, 200);

insert into AchievementMiningTotalRequirement (achievementId, oreId, amount) values (200, 3, 1);


insert into Achievement (id,  title,             description,                    achievementPoints, miningQueueReward, miningAreaId)
                 values (201, 'More Lithabine!', 'Mine even more Lithabine ore', 10,                1,                 1301);

insert into AchievementPredecessor (predecessorId, successorId) values (200, 201);

insert into AchievementMiningTotalRequirement (achievementId, oreId, amount) values (201, 3, 50);


insert into Achievement (id,  title,       description,                                   achievementPoints, robotReward)
                 values (202, 'New robot', 'Show your dedication to earn an extra robot', 10,                2);

insert into AchievementPredecessor (predecessorId, successorId) values (201, 202);

insert into AchievementMiningTotalRequirement (achievementId, oreId, amount) values (202, 3, 1000);


insert into Achievement (id,  title,             description,                    achievementPoints)
                 values (203, 'More Lithabine!', 'Mine even more Lithabine ore', 10);

insert into AchievementPredecessor (predecessorId, successorId) values (202, 203);

insert into AchievementMiningTotalRequirement (achievementId, oreId, amount) values (203, 3, 10000);


insert into Achievement (id,  title,             description,                    achievementPoints)
                 values (204, 'More Lithabine!', 'Mine even more Lithabine ore', 10);

insert into AchievementPredecessor (predecessorId, successorId) values (203, 204);

insert into AchievementMiningTotalRequirement (achievementId, oreId, amount) values (204, 3, 100000);


insert into Achievement (id,  title,             description,                    achievementPoints)
                 values (205, 'More Lithabine!', 'Mine even more Lithabine ore', 10);

insert into AchievementPredecessor (predecessorId, successorId) values (204, 205);

insert into AchievementMiningTotalRequirement (achievementId, oreId, amount) values (205, 3, 1000000);


insert into Achievement (id,  title,               description,                   achievementPoints, miningQueueReward)
                 values (300, 'Neudralion mining', 'Start mining Neudralion ore', 10,                1);

insert into AchievementPredecessor (predecessorId, successorId) values (202, 300);

insert into AchievementMiningTotalRequirement (achievementId, oreId, amount) values (300, 4, 1);


insert into Achievement (id,  title,              description,                     achievementPoints, miningQueueReward, miningAreaId)
                 values (301, 'More Neudralion!', 'Mine even more Neudralion ore', 10,                1,                 1401);

insert into AchievementPredecessor (predecessorId, successorId) values (300, 301);

insert into AchievementMiningTotalRequirement (achievementId, oreId, amount) values (301, 4, 50);


insert into Achievement (id,  title,              description,                     achievementPoints, miningQueueReward)
                 values (302, 'More Neudralion!', 'Mine even more Neudralion ore', 10,                1);

insert into AchievementPredecessor (predecessorId, successorId) values (301, 302);

insert into AchievementMiningTotalRequirement (achievementId, oreId, amount) values (302, 4, 1000);


insert into Achievement (id,  title,              description,                     achievementPoints)
                 values (303, 'More Neudralion!', 'Mine even more Neudralion ore', 10);

insert into AchievementPredecessor (predecessorId, successorId) values (302, 303);

insert into AchievementMiningTotalRequirement (achievementId, oreId, amount) values (303, 4, 10000);


insert into Achievement (id,  title,              description,                     achievementPoints)
                 values (304, 'More Neudralion!', 'Mine even more Neudralion ore', 10);

insert into AchievementPredecessor (predecessorId, successorId) values (303, 304);

insert into AchievementMiningTotalRequirement (achievementId, oreId, amount) values (304, 4, 100000);


insert into Achievement (id,  title,              description,                     achievementPoints)
                 values (305, 'More Neudralion!', 'Mine even more Neudralion ore', 10);

insert into AchievementPredecessor (predecessorId, successorId) values (304, 305);

insert into AchievementMiningTotalRequirement (achievementId, oreId, amount) values (305, 4, 1000000);


insert into Achievement (id,  title,              description,                  achievementPoints, miningQueueReward)
                 values (400, 'Complatix mining', 'Start mining Complatix ore', 10,                1);

insert into AchievementPredecessor (predecessorId, successorId) values (301, 400);

insert into AchievementMiningTotalRequirement (achievementId, oreId, amount) values (400, 5, 1);


insert into Achievement (id,  title,             description,                    achievementPoints, miningQueueReward)
                 values (401, 'More Complatix!', 'Mine even more Complatix ore', 10,                1);

insert into AchievementPredecessor (predecessorId, successorId) values (400, 401);

insert into AchievementMiningTotalRequirement (achievementId, oreId, amount) values (401, 5, 50);


insert into Achievement (id,  title,             description,                    achievementPoints, miningQueueReward)
                 values (402, 'More Complatix!', 'Mine even more Complatix ore', 10,                1);

insert into AchievementPredecessor (predecessorId, successorId) values (401, 402);

insert into AchievementMiningTotalRequirement (achievementId, oreId, amount) values (402, 5, 1000);


insert into Achievement (id,  title,             description,                    achievementPoints)
                 values (403, 'More Complatix!', 'Mine even more Complatix ore', 10);

insert into AchievementPredecessor (predecessorId, successorId) values (402, 403);

insert into AchievementMiningTotalRequirement (achievementId, oreId, amount) values (403, 5, 10000);


insert into Achievement (id,  title,             description,                    achievementPoints)
                 values (404, 'More Complatix!', 'Mine even more Complatix ore', 10);

insert into AchievementPredecessor (predecessorId, successorId) values (403, 404);

insert into AchievementMiningTotalRequirement (achievementId, oreId, amount) values (404, 5, 100000);


insert into Achievement (id,  title,             description,                    achievementPoints)
                 values (405, 'More Complatix!', 'Mine even more Complatix ore', 10);

insert into AchievementPredecessor (predecessorId, successorId) values (404, 405);

insert into AchievementMiningTotalRequirement (achievementId, oreId, amount) values (405, 5, 1000000);



-- initial achievement filling
insert into UserAchievement
(usersId, achievementId)
select Users.id as usersId, NewAchievement.id as achievementId
from Users, Achievement NewAchievement
where not exists (
    select *
    from UserAchievement
    where UserAchievement.usersId = Users.id
    and UserAchievement.achievementId = NewAchievement.id)
and not exists
(
    select *
    from AchievementPredecessor
    left outer join UserAchievement
    on UserAchievement.achievementId = AchievementPredecessor.predecessorId
    where AchievementPredecessor.successorId = NewAchievement.id
    and (UserAchievement.claimed IS NULL OR UserAchievement.claimed = false)
);


-- Calculate the tier levels
update RobotPart
set tierId = 
(
select max(OrePriceAmount.oreId)
from OrePriceAmount
where OrePriceAmount.orePriceId = RobotPart.orePriceId
);
