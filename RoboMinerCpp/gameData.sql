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
insert into Ore (id, oreName) values (6, 'Prantum');
insert into Ore (id, oreName) values (7, 'Raxia');
insert into Ore (id, oreName) values (8, 'Dipolir');
insert into Ore (id, oreName) values (9, 'Asradon');

-- The tier names
insert into Tier (id, tierName) values (1, 'Cerbonium quality');
insert into Tier (id, tierName) values (2, 'Oxaria quality');
insert into Tier (id, tierName) values (3, 'Lithabine quality');
insert into Tier (id, tierName) values (4, 'Neudralion quality');
insert into Tier (id, tierName) values (5, 'Complatix quality');
insert into Tier (id, tierName) values (6, 'Prantum quality');
insert into Tier (id, tierName) values (7, 'Raxia quality');
insert into Tier (id, tierName) values (8, 'Dipolir quality');
insert into Tier (id, tierName) values (9, 'Asradon quality');

-- The robot part names
insert into RobotPartType (id, typeName) values (1, 'Ore container');
insert into RobotPartType (id, typeName) values (2, 'Mining unit');
insert into RobotPartType (id, typeName) values (3, 'Battery');
insert into RobotPartType (id, typeName) values (4, 'Memory module');
insert into RobotPartType (id, typeName) values (5, 'CPU');
insert into RobotPartType (id, typeName) values (6, 'Engine');

-- Ore containers - Cerbonium
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

-- Ore containers - Oxaria
insert into OrePrice (id, description) values (110, 'Oxaria Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1102, 110, 2, 20);
insert into RobotPart (id,  typeId, partName,               orePriceId, oreCapacity, weight, volume, powerUsage)
               values (110, 1,      'Oxaria Ore Container', 110,        35,          16,     40,     4);

insert into OrePrice (id, description) values (111, 'Enhanced Oxaria Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1111, 111, 1, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1112, 111, 2, 50);
insert into RobotPart (id,  typeId, partName,                        orePriceId, oreCapacity, weight, volume, powerUsage)
               values (111, 1,      'Enhanced Oxaria Ore Container', 111,        40,          18,     45,     5);

-- Ore containers - Lithabine
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

-- Ore containers - Neudralion
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

-- Ore containers - Complatix
insert into OrePrice (id, description) values (140, 'Complatix Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1403, 140, 3, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1404, 140, 4, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1405, 140, 5, 10);
insert into RobotPart (id,  typeId, partName,                  orePriceId, oreCapacity, weight, volume, powerUsage)
               values (140, 1,      'Complatix Ore Container', 140,        65,          28,     70,     10);

insert into OrePrice (id, description) values (141, 'Enhanced Complatix Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1413, 141, 3, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1414, 141, 4, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1415, 141, 5, 75);
insert into RobotPart (id,  typeId, partName,                           orePriceId, oreCapacity, weight, volume, powerUsage)
               values (141, 1,      'Enhanced Complatix Ore Container', 141,        70,          30,     75,     11);

-- Ore containers - Prantum
insert into OrePrice (id, description) values (150, 'Prantum Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1504, 150, 4, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1505, 150, 5, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1506, 150, 6, 10);
insert into RobotPart (id,  typeId, partName,                orePriceId, oreCapacity, weight, volume, powerUsage)
               values (150, 1,      'Prantum Ore Container', 150,        75,          32,     80,     12);

insert into OrePrice (id, description) values (151, 'Enhanced Prantum Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1514, 151, 4, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1515, 151, 5, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1516, 151, 6, 75);
insert into RobotPart (id,  typeId, partName,                         orePriceId, oreCapacity, weight, volume, powerUsage)
               values (151, 1,      'Enhanced Prantum Ore Container', 151,        80,          34,     85,     13);

-- Ore containers - Raxia
insert into OrePrice (id, description) values (160, 'Raxia Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1605, 160, 5, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1606, 160, 6, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1607, 160, 7, 10);
insert into RobotPart (id,  typeId, partName,              orePriceId, oreCapacity, weight, volume, powerUsage)
               values (160, 1,      'Raxia Ore Container', 160,        85,          36,     90,     14);

insert into OrePrice (id, description) values (161, 'Enhanced Raxia Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1615, 161, 5, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1616, 161, 6, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1617, 161, 7, 75);
insert into RobotPart (id,  typeId, partName,                       orePriceId, oreCapacity, weight, volume, powerUsage)
               values (161, 1,      'Enhanced Raxia Ore Container', 161,        90,          38,     95,     15);

-- Ore containers - Dipolir
insert into OrePrice (id, description) values (170, 'Dipolir Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1706, 170, 6, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1707, 170, 7, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1708, 170, 8, 10);
insert into RobotPart (id,  typeId, partName,                orePriceId, oreCapacity, weight, volume, powerUsage)
               values (170, 1,      'Dipolir Ore Container', 170,        95,          40,     100,    16);

insert into OrePrice (id, description) values (171, 'Enhanced Dipolir Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1716, 171, 6, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1717, 171, 7, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1718, 171, 8, 75);
insert into RobotPart (id,  typeId, partName,                         orePriceId, oreCapacity, weight, volume, powerUsage)
               values (171, 1,      'Enhanced Dipolir Ore Container', 171,        100,         42,     105,    17);

-- Ore containers - Asradon
insert into OrePrice (id, description) values (180, 'Asradon Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1807, 180, 7, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1808, 180, 8, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1809, 180, 9, 10);
insert into RobotPart (id,  typeId, partName,                orePriceId, oreCapacity, weight, volume, powerUsage)
               values (180, 1,      'Asradon Ore Container', 180,        105,         44,     110,    18);

insert into OrePrice (id, description) values (181, 'Enhanced Asradon Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1817, 181, 7, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1818, 181, 8, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (1819, 181, 9, 75);
insert into RobotPart (id,  typeId, partName,                         orePriceId, oreCapacity, weight, volume, powerUsage)
               values (181, 1,      'Enhanced Asradon Ore Container', 181,        110,         46,     115,    19);


-- Mining units - Cerbonium
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

-- Mining units - Oxaria
insert into OrePrice (id, description) values (210, 'Oxaria Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2102, 210, 2, 20);
insert into RobotPart (id,  typeId, partName,             orePriceId, miningCapacity, weight, volume, powerUsage)
               values (210, 2,      'Oxaria Mining Unit', 210,        3,              18,     11,     16);

insert into OrePrice (id, description) values (211, 'Enhanced Oxaria Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2111, 211, 1, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2112, 211, 2, 50);
insert into RobotPart (id,  typeId, partName,                      orePriceId, miningCapacity, weight, volume, powerUsage)
               values (211, 2,      'Enhanced Oxaria Mining Unit', 211,        3,              19,     12,     15);

-- Mining units - Lithabine
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

-- Mining units - Neudralion
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

-- Mining units - Complatix
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

-- Mining units - Prantum
insert into OrePrice (id, description) values (250, 'Prantum Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2504, 250, 4, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2505, 250, 5, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2506, 250, 6, 10);
insert into RobotPart (id,  typeId, partName,              orePriceId, miningCapacity, weight, volume, powerUsage)
               values (250, 2,      'Prantum Mining Unit', 250,        7,              26,     19,     30);

insert into OrePrice (id, description) values (251, 'Enhanced Prantum Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2514, 251, 4, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2515, 251, 5, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2516, 251, 6, 75);
insert into RobotPart (id,  typeId, partName,                       orePriceId, miningCapacity, weight, volume, powerUsage)
               values (251, 2,      'Enhanced Prantum Mining Unit', 251,        7,              27,     20,     27);

-- Mining units - Raxia
insert into OrePrice (id, description) values (260, 'Raxia Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2605, 260, 5, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2606, 260, 6, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2607, 260, 7, 10);
insert into RobotPart (id,  typeId, partName,            orePriceId, miningCapacity, weight, volume, powerUsage)
               values (260, 2,      'Raxia Mining Unit', 260,        8,              28,     21,     35);

insert into OrePrice (id, description) values (261, 'Enhanced Raxia Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2615, 261, 5, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2616, 261, 6, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2617, 261, 7, 75);
insert into RobotPart (id,  typeId, partName,                     orePriceId, miningCapacity, weight, volume, powerUsage)
               values (261, 2,      'Enhanced Raxia Mining Unit', 261,        8,              29,     22,     32);

-- Mining units - Dipolir
insert into OrePrice (id, description) values (270, 'Dipolir Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2706, 270, 6, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2707, 270, 7, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2708, 270, 8, 10);
insert into RobotPart (id,  typeId, partName,              orePriceId, miningCapacity, weight, volume, powerUsage)
               values (270, 2,      'Dipolir Mining Unit', 270,        9,              30,     23,     40);

insert into OrePrice (id, description) values (271, 'Enhanced Dipolir Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2716, 271, 6, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2717, 271, 7, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2718, 271, 8, 75);
insert into RobotPart (id,  typeId, partName,                       orePriceId, miningCapacity, weight, volume, powerUsage)
               values (271, 2,      'Enhanced Dipolir Mining Unit', 271,        5,              22,     15,     18);

-- Mining units - Asradon
insert into OrePrice (id, description) values (280, 'Asradon Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2807, 280, 7, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2808, 280, 8, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2809, 280, 9, 10);
insert into RobotPart (id,  typeId, partName,              orePriceId, miningCapacity, weight, volume, powerUsage)
               values (280, 2,      'Asradon Mining Unit', 280,        10,             32,     24,     45);

insert into OrePrice (id, description) values (281, 'Enhanced Asradon Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2817, 281, 7, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2818, 281, 8, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2819, 281, 9, 75);
insert into RobotPart (id,  typeId, partName,                       orePriceId, miningCapacity, weight, volume, powerUsage)
               values (281, 2,      'Enhanced Asradon Mining Unit', 281,        4,              19,     12,     16);


-- Batteries - Cerbonium
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

-- Batteries - Oxaria
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

-- Batteries - Lithabine
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

-- Batteries - Neudralion
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

-- Batteries - Complatix
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

-- Batteries - Prantum
insert into OrePrice (id, description) values (350, 'Prantum Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3504, 350, 4, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3505, 350, 5, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3506, 350, 6, 10);
insert into RobotPart (id,  typeId, partName,          orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (350, 3,      'Prantum Battery', 350,        98000,           420,          12,     11,     0);

insert into OrePrice (id, description) values (351, 'Enhanced Prantum Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3514, 351, 4, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3515, 351, 5, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3516, 351, 6, 75);
insert into RobotPart (id,  typeId, partName,                   orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (351, 3,      'Enhanced Prantum Battery', 351,        120000,          600,          13,     12,     0);

-- Batteries - Raxia
insert into OrePrice (id, description) values (360, 'Raxia Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3604, 360, 5, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3605, 360, 6, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3606, 360, 7, 10);
insert into RobotPart (id,  typeId, partName,        orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (360, 3,      'Raxia Battery', 360,        160000,          720,          14,     13,     0);

insert into OrePrice (id, description) values (361, 'Enhanced Raxia Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3615, 361, 5, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3616, 361, 6, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3617, 361, 7, 75);
insert into RobotPart (id,  typeId, partName,                 orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (361, 3,      'Enhanced Raxia Battery', 361,        200000,          900,          15,     14,     0);

-- Batteries - Dipolir
insert into OrePrice (id, description) values (370, 'Dipolir Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3706, 370, 6, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3707, 370, 7, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3708, 370, 8, 10);
insert into RobotPart (id,  typeId, partName,          orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (370, 3,      'Dipolir Battery', 370,        240000,          1200,         16,     15,     0);

insert into OrePrice (id, description) values (371, 'Enhanced Dipolir Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3716, 371, 6, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3717, 371, 7, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3718, 371, 8, 75);
insert into RobotPart (id,  typeId, partName,                   orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (371, 3,      'Enhanced Dipolir Battery', 371,        280000,          1500,         17,     16,     0);

-- Batteries - Asradon
insert into OrePrice (id, description) values (380, 'Asradon Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3807, 380, 7, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3808, 380, 8, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3809, 380, 9, 10);
insert into RobotPart (id,  typeId, partName,          orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (380, 3,      'Asradon Battery', 380,        320000,          1800,         18,     17,     0);

insert into OrePrice (id, description) values (381, 'Enhanced Asradon Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3817, 381, 7, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3818, 381, 8, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (3819, 381, 9, 75);
insert into RobotPart (id,  typeId, partName,                   orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (381, 3,      'Enhanced Asradon Battery', 381,        360000,          2100,         19,     18,     0);


-- Memory modules - Cerbonium
insert into OrePrice (id, description) values (401, 'Standard Memory Module price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4011, 401, 1, 2);
insert into RobotPart (id,  typeId, partName,                 orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (401, 4,      'Standard Memory Module', 401,        8,              1,      1,      1);

insert into OrePrice (id, description) values (402, 'Enhanced Memory Module price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4021, 402, 1, 10);
insert into RobotPart (id,  typeId, partName,                 orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (402, 4,      'Enhanced Memory Module', 402,        16,             1,      1,      2);

insert into OrePrice (id, description) values (403, 'Cerbonium Memory Module price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4031, 403, 1, 50);
insert into RobotPart (id,  typeId, partName,                  orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (403, 4,      'Cerbonium Memory Module', 403,        24,             1,      1,      3);

-- Memory modules - Oxaria
insert into OrePrice (id, description) values (410, 'Oxaria Memory Module price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4102, 410, 2, 20);
insert into RobotPart (id,  typeId, partName,               orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (410, 4,      'Oxaria Memory Module', 410,        32,             1,      1,      4);

insert into OrePrice (id, description) values (411, 'Enhanced Oxaria Memory Module price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4111, 411, 1, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4112, 411, 2, 50);
insert into RobotPart (id,  typeId, partName,                        orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (411, 4,      'Enhanced Oxaria Memory Module', 411,        48,             1,      1,      5);

-- Memory modules - Lithabine
insert into OrePrice (id, description) values (420, 'Lithabine Memory Module price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4201, 420, 1, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4202, 420, 2, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4203, 420, 3, 10);
insert into RobotPart (id,  typeId, partName,                  orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (420, 4,      'Lithabine Memory Module', 420,        64,             1,      1,      6);

insert into OrePrice (id, description) values (421, 'Enhanced Lithabine Memory Module price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4211, 421, 1, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4212, 421, 2, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4213, 421, 3, 50);
insert into RobotPart (id,  typeId, partName,                           orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (421, 4,      'Enhanced Lithabine Memory Module', 421,        80,             1,      1,      7);

-- Memory modules - Neudralion
insert into OrePrice (id, description) values (430, 'Neudralion Memory Module price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4302, 430, 2, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4303, 430, 3, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4304, 430, 4, 15);
insert into RobotPart (id,  typeId, partName,                   orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (430, 4,      'Neudralion Memory Module', 430,        96,             1,      1,      8);

insert into OrePrice (id, description) values (431, 'Enhanced Neudralion Memory Module price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4312, 431, 2, 350);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4313, 431, 3, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4314, 431, 4, 60);
insert into RobotPart (id,  typeId, partName,                            orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (431, 4,      'Enhanced Neudralion Memory Module', 431,        112,            1,      1,      9);

-- Memory modules - Complatix
insert into OrePrice (id, description) values (440, 'Complatix Memory Module price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4403, 440, 3, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4404, 440, 4, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4405, 440, 5, 10);
insert into RobotPart (id,  typeId, partName,                  orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (440, 4,      'Complatix Memory Module', 440,        128,            1,      1,      10);

insert into OrePrice (id, description) values (441, 'Enhanced Complatix Memory Module price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4413, 441, 3, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4414, 441, 4, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4415, 441, 5, 75);
insert into RobotPart (id,  typeId, partName,                           orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (441, 4,      'Enhanced Complatix Memory Module', 441,        160,            1,      1,      11);

-- Memory modules - Prantum
insert into OrePrice (id, description) values (450, 'Prantum Memory Module price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4504, 450, 4, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4505, 450, 5, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4506, 450, 6, 10);
insert into RobotPart (id,  typeId, partName,                orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (450, 4,      'Prantum Memory Module', 450,        192,            1,      1,      12);

insert into OrePrice (id, description) values (451, 'Enhanced Prantum Memory Module price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4514, 451, 4, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4515, 451, 5, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4516, 451, 6, 75);
insert into RobotPart (id,  typeId, partName,                         orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (451, 4,      'Enhanced Prantum Memory Module', 451,        224,            1,      1,      13);

-- Memory modules - Raxia
insert into OrePrice (id, description) values (460, 'Raxia Memory Module price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4605, 460, 5, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4606, 460, 6, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4607, 460, 7, 10);
insert into RobotPart (id,  typeId, partName,              orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (460, 4,      'Raxia Memory Module', 460,        256,            1,      1,      14);

insert into OrePrice (id, description) values (461, 'Enhanced Raxia Memory Module price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4615, 461, 5, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4616, 461, 6, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4617, 461, 7, 75);
insert into RobotPart (id,  typeId, partName,                       orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (461, 4,      'Enhanced Raxia Memory Module', 461,        288,            1,      1,      15);

-- Memory modules - Dipolir
insert into OrePrice (id, description) values (470, 'Dipolir Memory Module price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4706, 470, 6, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4707, 470, 7, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4708, 470, 8, 10);
insert into RobotPart (id,  typeId, partName,                orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (470, 4,      'Dipolir Memory Module', 470,        320,            1,      1,      16);

insert into OrePrice (id, description) values (471, 'Enhanced Dipolir Memory Module price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4716, 471, 6, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4717, 471, 7, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4718, 471, 8, 75);
insert into RobotPart (id,  typeId, partName,                         orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (471, 4,      'Enhanced Dipolir Memory Module', 471,        352,            1,      1,      17);

-- Memory modules - Asradon
insert into OrePrice (id, description) values (480, 'Asradon Memory Module price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4807, 480, 7, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4808, 480, 8, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4809, 480, 9, 10);
insert into RobotPart (id,  typeId, partName,                orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (480, 4,      'Asradon Memory Module', 480,        384,            1,      1,      18);

insert into OrePrice (id, description) values (481, 'Enhanced Asradon Memory Module price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4817, 481, 7, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4818, 481, 8, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (4819, 481, 9, 75);
insert into RobotPart (id,  typeId, partName,                         orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (481, 4,      'Enhanced Asradon Memory Module', 481,        416,            1,      1,      19);


-- CPUs - Cerbonium
insert into OrePrice (id, description) values (501, 'Standard CPU price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5011, 501, 1, 2);
insert into RobotPart (id,  typeId, partName,       orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (501, 5,      'Standard CPU', 501,        2,           1,      1,      1);

insert into OrePrice (id, description) values (502, 'Enhanced CPU price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5021, 502, 1, 10);
insert into RobotPart (id,  typeId, partName,       orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (502, 5,      'Enhanced CPU', 502,        4,           1,      1,      1);

insert into OrePrice (id, description) values (503, 'Cerbonium CPU price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5031, 503, 1, 50);
insert into RobotPart (id,  typeId, partName,        orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (503, 5,      'Cerbonium CPU', 503,        8,           1,      1,      2);

-- CPUs - Oxaria
insert into OrePrice (id, description) values (510, 'Oxaria CPU price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5102, 510, 2, 20);
insert into RobotPart (id,  typeId, partName,     orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (510, 5,      'Oxaria CPU', 510,        12,           1,      1,      3);

insert into OrePrice (id, description) values (511, 'Enhanced Oxaria CPU price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5111, 511, 1, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5112, 511, 2, 50);
insert into RobotPart (id,  typeId, partName,              orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (511, 5,      'Enhanced Oxaria CPU', 511,        16,          1,      1,      4);

-- CPUs - Lithabine
insert into OrePrice (id, description) values (520, 'Lithabine CPU price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5201, 520, 1, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5202, 520, 2, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5203, 520, 3, 10);
insert into RobotPart (id,  typeId, partName,        orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (520, 5,      'Lithabine CPU', 520,        20,          1,      1,      5);

insert into OrePrice (id, description) values (521, 'Enhanced Lithabine CPU price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5211, 521, 1, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5212, 521, 2, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5213, 521, 3, 50);
insert into RobotPart (id,  typeId, partName,                 orePriceId, cpuCapacity,  weight, volume, powerUsage)
               values (521, 5,      'Enhanced Lithabine CPU', 521,        24,           1,      1,      6);

-- CPUs - Neudralion
insert into OrePrice (id, description) values (530, 'Neudralion CPU price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5302, 530, 2, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5303, 530, 3, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5304, 530, 4, 15);
insert into RobotPart (id,  typeId, partName,         orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (530, 5,      'Neudralion CPU', 530,        28,          1,      1,      7);

insert into OrePrice (id, description) values (531, 'Enhanced Neudralion CPU price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5312, 531, 2, 350);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5313, 531, 3, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5314, 531, 4, 60);
insert into RobotPart (id,  typeId, partName,                  orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (531, 5,      'Enhanced Neudralion CPU', 531,        32,          1,      1,      8);

-- CPUs - Complatix
insert into OrePrice (id, description) values (540, 'Complatix CPU price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5403, 540, 3, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5404, 540, 4, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5405, 540, 5, 10);
insert into RobotPart (id,  typeId, partName,        orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (540, 5,      'Complatix CPU', 540,        36,          1,      1,      9);

insert into OrePrice (id, description) values (541, 'Enhanced Complatix CPU price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5413, 541, 3, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5414, 541, 4, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5415, 541, 5, 75);
insert into RobotPart (id,  typeId, partName,                 orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (541, 5,      'Enhanced Complatix CPU', 541,        40,          1,      1,      10);

-- CPUs - Prantum
insert into OrePrice (id, description) values (550, 'Prantum CPU price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5504, 550, 4, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5505, 550, 5, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5506, 550, 6, 10);
insert into RobotPart (id,  typeId, partName,      orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (550, 5,      'Prantum CPU', 550,        44,          1,      1,      11);

insert into OrePrice (id, description) values (551, 'Enhanced Prantum CPU price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5514, 551, 4, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5515, 551, 5, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5516, 551, 6, 75);
insert into RobotPart (id,  typeId, partName,               orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (551, 5,      'Enhanced Prantum CPU', 551,        48,          1,      1,      12);

-- CPUs - Raxia
insert into OrePrice (id, description) values (560, 'Raxia CPU price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5605, 560, 5, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5606, 560, 6, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5607, 560, 7, 10);
insert into RobotPart (id,  typeId, partName,    orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (560, 5,      'Raxia CPU', 560,        52,          1,      1,      13);

insert into OrePrice (id, description) values (561, 'Enhanced Raxia CPU price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5615, 561, 5, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5616, 561, 6, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5617, 561, 7, 75);
insert into RobotPart (id,  typeId, partName,             orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (561, 5,      'Enhanced Raxia CPU', 561,        56,          1,      1,      14);

-- CPUs - Dipolir
insert into OrePrice (id, description) values (570, 'Dipolir CPU price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5706, 570, 6, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5707, 570, 7, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5708, 570, 8, 10);
insert into RobotPart (id,  typeId, partName,      orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (570, 5,      'Dipolir CPU', 570,        60,          1,      1,      15);

insert into OrePrice (id, description) values (571, 'Enhanced Dipolir CPU price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5716, 571, 6, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5717, 571, 7, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5718, 571, 8, 75);
insert into RobotPart (id,  typeId, partName,               orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (571, 5,      'Enhanced Dipolir CPU', 571,        64,          1,      1,      16);

-- CPUs - Asradon
insert into OrePrice (id, description) values (580, 'Asradon CPU price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5807, 580, 7, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5808, 580, 8, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5809, 580, 9, 10);
insert into RobotPart (id,  typeId, partName,      orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (580, 5,      'Asradon CPU', 580,        68,          1,      1,      17);

insert into OrePrice (id, description) values (581, 'Enhanced Asradon CPU price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5817, 581, 7, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5818, 581, 8, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (5819, 581, 9, 75);
insert into RobotPart (id,  typeId, partName,               orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (581, 5,      'Enhanced Asradon CPU', 581,        72,          1,      1,      18);


-- Engines - Cerbonium
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

-- Engines - Oxaria
insert into OrePrice (id, description) values (610, 'Engine 95 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6102, 610, 2, 20);
insert into RobotPart (id,  typeId, partName,    orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (610, 6,      'Engine 95', 610,        95,              95,               95,             14,     8,      28);

insert into OrePrice (id, description) values (611, 'Engine 90E price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6111, 611, 1, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6112, 611, 2, 50);
insert into RobotPart (id,  typeId, partName,     orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (611, 6,      'Engine 90E', 611,        90,              90,               90,             14,     9,      25);

-- Engines - Lithabine
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

-- Engines - Neudralion
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

-- Engines - Complatix
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

-- Engines - Prantum
insert into OrePrice (id, description) values (650, 'Engine 180 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6504, 650, 4, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6505, 650, 5, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6506, 650, 6, 10);
insert into RobotPart (id,  typeId, partName,     orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (650, 6,      'Engine 180', 650,        180,             140,              180,            22,     16,     60);

insert into OrePrice (id, description) values (651, 'Engine 170A price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6514, 651, 4, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6515, 651, 5, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6516, 651, 6, 75);
insert into RobotPart (id,  typeId, partName,      orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (651, 6,      'Engine 170A', 651,        170,             170,              360,            22,     17,     60);

-- Engines - Raxia
insert into OrePrice (id, description) values (660, 'Engine 210 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6605, 660, 5, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6606, 660, 6, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6607, 660, 7, 10);
insert into RobotPart (id,  typeId, partName,     orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (660, 6,      'Engine 210', 660,        210,             160,              210,            24,     18,     70);

insert into OrePrice (id, description) values (661, 'Engine 200A price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6615, 661, 5, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6616, 661, 6, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6617, 661, 7, 75);
insert into RobotPart (id,  typeId, partName,      orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (661, 6,      'Engine 200A', 661,        200,             200,              400,            24,     19,     70);

-- Engines - Dipolir
insert into OrePrice (id, description) values (670, 'Engine 210E price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6706, 670, 6, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6707, 670, 7, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6708, 670, 8, 10);
insert into RobotPart (id,  typeId, partName,      orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (670, 6,      'Engine 210E', 670,        210,             150,              210,            23,     17,     65);

insert into OrePrice (id, description) values (671, 'Engine 210A price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6716, 671, 6, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6717, 671, 7, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6718, 671, 8, 75);
insert into RobotPart (id,  typeId, partName,      orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (671, 6,      'Engine 210A', 671,        210,             210,              600,            25,     20,     75);

-- Engines - Asradon
insert into OrePrice (id, description) values (680, 'Engine 230E price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6807, 680, 7, 200);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6808, 680, 8, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6809, 680, 9, 10);
insert into RobotPart (id,  typeId, partName,      orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (680, 6,      'Engine 230E', 680,        230,             150,              220,            26,     18,     70);

insert into OrePrice (id, description) values (681, 'Engine 230A price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6817, 681, 7, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6818, 681, 8, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (6819, 681, 9, 75);
insert into RobotPart (id,  typeId, partName,      orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (681, 6,      'Engine 230A', 681,        230,             230,              650,            26,     21,     80);



-- AI player
insert into Users (id, username, email, password) values (1, 'AI', '', '');

-- AI player robots
insert into Robot (id, usersId, robotName, sourceCode,
 rechargeTime, maxOre, miningSpeed, maxTurns, cpuSpeed, forwardSpeed, backwardSpeed, rotateSpeed, robotSize)
values (1, 1, 'AI-1', 'move(1.5); while (mine());',
 0,            50,     2,           1500,     99,       2,            2,             25,          1.5);

insert into Robot (id, usersId, robotName, sourceCode,
 rechargeTime, maxOre, miningSpeed, maxTurns, cpuSpeed, forwardSpeed, backwardSpeed, rotateSpeed, robotSize)
values (2, 1, 'AI-2', 'if (move(1.5) >= 1) { while (mine()); } else { move(-1); rotate(20); }',
 0,            50,     2,           3000,     99,       2,            2,             25,          1.5);

insert into Robot (id, usersId, robotName,
 sourceCode,
 rechargeTime, maxOre, miningSpeed, maxTurns, cpuSpeed, forwardSpeed, backwardSpeed, rotateSpeed, robotSize)
values (3, 1, 'AI-3', 
'int rot = 0; while (true) { if (rot) { if (rot <= 90) { rotate(rot); } rot = rot - 10; } if (move(1.5) < 1) { move(-1); rotate(24); } while (mine()) { rot = 100; } }',
 0,            50,     2,           5000,     99,       2,            2,             25,          1.5);

-- Mining areas

-- Cerbonium
insert into OrePrice (id, description) values (1001, 'Mining Area Cerbonium-1 price');
insert into MiningArea (id, areaName,        orePriceId, sizeX, sizeY, maxMoves, miningTime, taxRate, aiRobotId)
                values (1001, 'Cerbonium-1', 1001,       20,    20,    150,      30,         25,      1);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1001, 1, 20, 6);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1001, 1, 20, 4);

insert into OrePrice (id, description) values (1002, 'Mining Area Cerbonium-2 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (10021, 1002, 1, 1);
insert into MiningArea (id,   areaName,      orePriceId, sizeX, sizeY, maxMoves, miningTime, taxRate, aiRobotId)
                values (1002, 'Cerbonium-2', 1002,       30,    30,    300,      60,         10,      2);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1002, 1, 20, 6);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1002, 1, 20, 4);

insert into OrePrice (id, description) values (1003, 'Mining Area Cerbonium-3 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (10031, 1003, 1, 2);
insert into MiningArea (id,   areaName,      orePriceId, sizeX, sizeY, maxMoves, miningTime, taxRate, aiRobotId)
                values (1003, 'Cerbonium-3', 1003,       40,    40,    600,      120,        0,       3);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1003, 1, 20, 6);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1003, 1, 20, 4);

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
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (11022, 1102, 2, 1);
insert into MiningArea (id,   areaName,   orePriceId, sizeX, sizeY, maxMoves, miningTime, taxRate, aiRobotId)
                values (1102, 'Oxaria-2', 1102,       45,    45,    500,      120,        10,      3);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1102, 1, 20, 4);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1102, 2, 10, 4);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1102, 2, 5,  4);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1102, 2, 5,  4);

insert into OrePrice (id, description) values (1103, 'Mining Area Oxaria-3 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (11031, 1103, 1, 15);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (11032, 1103, 2, 2);
insert into MiningArea (id,   areaName,   orePriceId, sizeX, sizeY, maxMoves, miningTime, taxRate, aiRobotId)
                values (1103, 'Oxaria-3', 1103,       60,    60,    1000,     240,        0,       3);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1103, 1, 20, 4);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1103, 2, 10, 4);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1103, 2, 5,  4);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1103, 2, 5,  4);

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
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (12021, 1202, 1, 15);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (12022, 1202, 2, 10);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (12023, 1202, 3, 1);
insert into MiningArea (id,   areaName,      orePriceId, sizeX, sizeY, maxMoves, miningTime, taxRate, aiRobotId)
                values (1202, 'Lithabine-2', 1202,       60,    60,    700,      240,        10,      3);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1202, 1, 10, 6);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1202, 2, 10, 5);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1202, 3, 5, 5);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1202, 3, 5, 4);

insert into OrePrice (id, description) values (1203, 'Mining Area Lithabine-3 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (12031, 1203, 1, 20);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (12032, 1203, 2, 15);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (12033, 1203, 3, 2);
insert into MiningArea (id,   areaName,      orePriceId, sizeX, sizeY, maxMoves, miningTime, taxRate, aiRobotId)
                values (1203, 'Lithabine-3', 1203,       80,    80,    1400,     480,        0,       3);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1203, 1, 10, 6);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1203, 2, 10, 5);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1203, 3, 5, 5);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1203, 3, 5, 4);

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
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (13021, 1302, 1, 20);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (13022, 1302, 2, 15);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (13023, 1302, 3, 15);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (13024, 1302, 4, 1);
insert into MiningArea (id,   areaName,       orePriceId, sizeX, sizeY, maxMoves, miningTime, taxRate, aiRobotId)
                values (1302, 'Neudralion-2', 1302,       75,    75,    900,      600,        20,      3);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1302, 2, 10, 6);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1302, 3, 10, 5);
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
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (14021, 1402, 1, 25);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (14022, 1402, 2, 20);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (14023, 1402, 3, 15);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (14024, 1402, 4, 10);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (14025, 1402, 5, 1);
insert into MiningArea (id,   areaName,      orePriceId, sizeX, sizeY, maxMoves, miningTime, taxRate, aiRobotId)
                values (1402, 'Complatix-2', 1402,       90,    90,    1200,     1800,       25,      3);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1402, 3, 10, 6);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1402, 4, 10, 6);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1402, 5, 5, 5);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1402, 5, 5, 5);

-- Prantum
insert into OrePrice (id, description) values (1501, 'Mining Area Prantum-1 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (15011, 1501, 1, 30);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (15012, 1501, 2, 25);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (15013, 1501, 3, 20);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (15014, 1501, 4, 15);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (15015, 1501, 5, 10);
insert into MiningArea (id,   areaName,    orePriceId, sizeX, sizeY, maxMoves, miningTime, taxRate, aiRobotId)
                values (1501, 'Prantum-1', 1501,       70,    70,    900,      1800,       50,      3);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1501, 3, 15, 15);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1501, 3, 15, 15);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1501, 4, 15, 15);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1501, 6, 4, 4);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1501, 6, 4, 4);

-- Raxia
insert into OrePrice (id, description) values (1601, 'Mining Area Raxia-1 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (16011, 1601, 1, 35);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (16012, 1601, 2, 30);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (16013, 1601, 3, 25);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (16014, 1601, 4, 20);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (16015, 1601, 5, 15);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (16016, 1601, 6, 10);
insert into MiningArea (id,   areaName,  orePriceId, sizeX, sizeY, maxMoves, miningTime, taxRate, aiRobotId)
                values (1601, 'Raxia-1', 1601,       80,    80,    1250,     3600,       50,      3);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1601, 3, 15, 15);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1601, 3, 15, 15);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1601, 5, 15, 15);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1601, 7, 4, 4);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1601, 7, 4, 4);

-- Dipolir
insert into OrePrice (id, description) values (1701, 'Mining Area Dipolir-1 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (17011, 1701, 1, 40);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (17012, 1701, 2, 35);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (17013, 1701, 3, 30);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (17014, 1701, 4, 25);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (17015, 1701, 5, 20);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (17016, 1701, 6, 15);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (17017, 1701, 7, 10);
insert into MiningArea (id,   areaName,    orePriceId, sizeX, sizeY, maxMoves, miningTime, taxRate, aiRobotId)
                values (1701, 'Dipolir-1', 1701,       90,    90,    1800,     7200,       60,      3);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1701, 2, 15, 15);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1701, 2, 15, 15);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1701, 4, 15, 15);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1701, 8, 2, 3);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1701, 8, 2, 3);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1701, 8, 2, 3);

-- Asradon
insert into OrePrice (id, description) values (1801, 'Mining Area Asradon-1 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (18011, 1801, 1, 45);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (18012, 1801, 2, 40);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (18013, 1801, 3, 35);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (18014, 1801, 4, 30);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (18015, 1801, 5, 25);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (18016, 1801, 6, 20);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (18017, 1801, 7, 15);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (18018, 1801, 8, 10);
insert into MiningArea (id,   areaName,    orePriceId, sizeX, sizeY, maxMoves, miningTime, taxRate, aiRobotId)
                values (1801, 'Asradon-1', 1801,       100,   100,   2700,     10800,      65,      3);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1801, 2, 15, 15);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1801, 2, 15, 15);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1801, 3, 15, 15);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1801, 9, 1, 3);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1801, 9, 1, 3);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1801, 9, 2, 3);


-- Achievements - Initial achievement
insert into Achievement (id, title,              description)
                 values (1,  'Your first robot', 'Claim your first robot');

insert into AchievementStep (id,  achievementId, step, achievementPoints, miningQueueReward, robotReward, miningAreaId)
                     values (101, 1,             1,    10,                1,                 1,           1001);


-- Achievements - Mining queue increments
insert into Achievement (id, title,                        description)
                 values (2,  'Increase mining queue size', 'Earn a larger mining queue');

insert into AchievementPredecessor (id, predecessorId, predecessorStep, successorId) values (201, 1, 1, 2);


insert into AchievementStep (id,  achievementId, step, achievementPoints, miningQueueReward)
                     values (201, 2,             1,    10,                1);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (2011, 201, 1, 1);


insert into AchievementStep (id,  achievementId, step, achievementPoints, miningQueueReward)
                     values (202, 2,             2,    10,                1);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (2021, 202, 1, 25);


insert into AchievementStep (id,  achievementId, step, achievementPoints, miningQueueReward)
                     values (203, 2,             3,    10,                1);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (2031, 203, 1, 500);


insert into AchievementStep (id,  achievementId, step, achievementPoints, miningQueueReward)
                     values (204, 2,             4,    10,                1);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (2041, 204, 1, 1000);
insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (2042, 204, 2, 10);


insert into AchievementStep (id,  achievementId, step, achievementPoints, miningQueueReward)
                     values (205, 2,             5,    10,                1);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (2051, 205, 1, 5000);
insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (2052, 205, 2, 500);


insert into AchievementStep (id,  achievementId, step, achievementPoints, miningQueueReward)
                     values (206, 2,             6,    10,                1);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (2061, 206, 1, 10000);
insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (2062, 206, 2, 2500);
insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (2063, 206, 3, 250);


insert into AchievementStep (id,  achievementId, step, achievementPoints, miningQueueReward)
                     values (207, 2,             7,    10,                1);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (2071, 207, 4, 250);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2072, 207, 1001, 500.0);


insert into AchievementStep (id,  achievementId, step, achievementPoints, miningQueueReward)
                     values (208, 2,             8,    10,                1);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (2081, 208, 5, 250);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2082, 208, 1001, 700.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2083, 208, 2001, 500.0);


insert into AchievementStep (id,  achievementId, step, achievementPoints, miningQueueReward)
                     values (209, 2,             9,    10,                1);

insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2091, 209, 1002, 800.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2092, 209, 2001, 600.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2093, 209, 3001, 400.0);


insert into AchievementStep (id,  achievementId, step, achievementPoints, miningQueueReward)
                     values (210, 2,             10,   10,                1);

insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2101, 210, 1003, 900.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2102, 210, 2002, 700.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2103, 210, 3001, 500.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2104, 210, 4001, 400.0);


insert into AchievementStep (id,  achievementId, step, achievementPoints, miningQueueReward)
                     values (211, 2,             11,   10,                1);

insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2111, 211, 2003, 750.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2112, 211, 3002, 550.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2113, 211, 4001, 450.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2114, 211, 5001, 400.0);


insert into AchievementStep (id,  achievementId, step, achievementPoints, miningQueueReward)
                     values (212, 2,             12,   10,                1);

insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2121, 212, 2003, 800.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2122, 212, 3003, 600.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2123, 212, 4002, 550.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2124, 212, 5002, 500.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2125, 212, 6001, 500.0);


insert into AchievementStep (id,  achievementId, step, achievementPoints, miningQueueReward)
                     values (213, 2,             13,   10,                1);

insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2131, 213, 2003, 850.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2132, 213, 3003, 650.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2133, 213, 4002, 600.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2134, 213, 5002, 550.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2135, 213, 6001, 550.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2136, 213, 7001, 500.0);


insert into AchievementStep (id,  achievementId, step, achievementPoints, miningQueueReward)
                     values (214, 2,             14,   10,                1);

insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2141, 214, 2003, 900.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2142, 214, 3003, 700.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2143, 214, 4002, 650.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2144, 214, 5002, 600.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2145, 214, 6001, 600.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2146, 214, 7001, 550.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2147, 214, 8001, 500.0);


insert into AchievementStep (id,  achievementId, step, achievementPoints, miningQueueReward)
                     values (215, 2,             15,   10,                1);

insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2151, 215, 3003, 800.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2152, 215, 4002, 700.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2153, 215, 5002, 650.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2154, 215, 6001, 650.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2155, 215, 7001, 600.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2156, 215, 8001, 550.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2157, 215, 9001, 500.0);


-- Achievements - Ore type mining
insert into Achievement (id, title,        description)
                 values (3,  'Better ore', 'Earn mining rights for better ore');

insert into AchievementPredecessor (id, predecessorId, predecessorStep, successorId) values (301, 2, 2, 3);

-- Oraxia-1
insert into AchievementStep (id,  achievementId, step, achievementPoints, miningAreaId)
                     values (301, 3,             1,    10,                1101);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (3011, 301, 1, 250);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (3012, 301, 1001, 500.0);

-- Lithabine-1
insert into AchievementStep (id,  achievementId, step, achievementPoints, miningAreaId)
                     values (302, 3,             2,    10,                1201);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (3021, 302, 1, 1000);
insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (3022, 302, 2, 250);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (3023, 302, 1001, 600.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (3024, 302, 1101, 400.0);

-- Neudralion-1
insert into AchievementStep (id,  achievementId, step, achievementPoints, miningAreaId)
                     values (303, 3,             3,    10,                1301);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (3031, 303, 1, 5000);
insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (3032, 303, 2, 1000);
insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (3033, 303, 3, 250);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (3034, 303, 1001, 700.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (3035, 303, 1101, 450.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (3036, 303, 1201, 200.0);

-- Complatix-1
insert into AchievementStep (id,  achievementId, step, achievementPoints, miningAreaId)
                     values (304, 3,             4,    10,                1401);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (3041, 304, 2, 5000);
insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (3042, 304, 3, 1000);
insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (3043, 304, 4, 250);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (3044, 304, 1101, 500.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (3045, 304, 1201, 240.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (3046, 304, 1301, 200.0);

-- Prantum-1
insert into AchievementStep (id,  achievementId, step, achievementPoints, miningAreaId)
                     values (305, 3,             5,    10,                1501);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (3051, 305, 3, 5000);
insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (3052, 305, 4, 1000);
insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (3053, 305, 5, 250);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (3054, 305, 1201, 250.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (3055, 305, 1301, 230.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (3056, 305, 1401, 210.0);

-- Raxia-1
insert into AchievementStep (id,  achievementId, step, achievementPoints, miningAreaId)
                     values (306, 3,             6,    10,                1601);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (3061, 306, 4, 5000);
insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (3062, 306, 5, 1000);
insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (3063, 306, 6, 250);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (3064, 306, 1301, 250.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (3065, 306, 1401, 230.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (3066, 306, 1501, 210.0);

-- Dipolir-1
insert into AchievementStep (id,  achievementId, step, achievementPoints, miningAreaId)
                     values (307, 3,             7,    10,                1701);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (3071, 307, 5, 5000);
insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (3072, 307, 6, 1000);
insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (3073, 307, 7, 250);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (3074, 307, 1401, 250.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (3075, 307, 1501, 230.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (3076, 307, 1601, 210.0);

-- Asradon-1
insert into AchievementStep (id,  achievementId, step, achievementPoints, miningAreaId)
                     values (308, 3,             8,    10,                1801);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (3081, 308, 6, 5000);
insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (3082, 308, 7, 1000);
insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (3083, 308, 8, 250);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (3084, 308, 1501, 250.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (3085, 308, 1601, 230.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (3086, 308, 1701, 210.0);


-- Achievements - New robot
insert into Achievement (id, title,       description)
                 values (4,  'New robot', 'Earn an extra robot');

insert into AchievementPredecessor (id, predecessorId, predecessorStep, successorId) values (401, 3, 2, 4);

insert into AchievementStep (id,  achievementId, step, achievementPoints, robotReward)
                     values (401, 4,             1,    10,                2);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (4011, 401, 3, 1000);


-- Achievements - Cerbonium - Quantity mining
insert into Achievement (id, title,              description)
                 values (10, 'Cerbonium mining', 'Mine Cerbonium');

insert into AchievementPredecessor (id, predecessorId, predecessorStep, successorId) values (1001, 1, 1, 10);

insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (1001, 10,            1,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (10011, 1001, 1, 25);


insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (1002, 10,            2,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (10021, 1002, 1, 250);


insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (1003, 10,            3,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (10031, 1003, 1, 1000);


insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (1004, 10,            4,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (10041, 1004, 1, 2500);


insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (1005, 10,            5,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (10051, 1005, 1, 10000);


insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (1006, 10,            6,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (10061, 1006, 1, 100000);


-- Achievements - Cerbonium - Mining score
insert into Achievement (id, title,                       description)
                 values (11, 'Improved Cerbonium mining', 'Improve your mining efficiency for Cerbonium ore');

insert into AchievementPredecessor (id, predecessorId, predecessorStep, successorId) values (1101, 10, 4, 11);

insert into AchievementStep (id,   achievementId, step, achievementPoints, miningAreaId)
                     values (1101, 11,            1,    10,                1002);

insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (110101, 1101, 1001, 760.0);


insert into AchievementStep (id,   achievementId, step, achievementPoints, miningAreaId)
                     values (1102, 11,            2,    10,                1003);

insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (110201, 1102, 1001, 860.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (110202, 1102, 1002, 850.0);


-- Achievements - Oxaria - Quantity mining
insert into Achievement (id, title,           description)
                 values (20, 'Oxaria mining', 'Mine Oxaria');

insert into AchievementPredecessor (id, predecessorId, predecessorStep, successorId) values (2001, 3, 1, 20);

insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (2001, 20,            1,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (20011, 2001, 2, 50);


insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (2002, 20,            2,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (20021, 2002, 2, 500);


insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (2003, 20,            3,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (20031, 2003, 2, 2500);


insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (2004, 20,            4,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (20041, 2004, 2, 10000);


insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (2005, 20,            5,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (20051, 2005, 2, 25000);


insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (2006, 20,            6,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (20061, 2006, 2, 100000);


-- Achievements - Oxaria - Mining score
insert into Achievement (id, title,                    description)
                 values (21, 'Improved Oxaria mining', 'Improve your mining efficiency for Oxaria ore');

insert into AchievementPredecessor (id, predecessorId, predecessorStep, successorId) values (2101, 20, 3, 21);

insert into AchievementStep (id,   achievementId, step, achievementPoints, miningAreaId)
                     values (2101, 21,            1,    10,                1102);

insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (210101, 2101, 1101, 600.0);


insert into AchievementStep (id,   achievementId, step, achievementPoints, miningAreaId)
                     values (2102, 21,            2,    10,                1103);

insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (210201, 2102, 1101, 750.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (210202, 2102, 1102, 700.0);


-- Achievements - Lithabine - Quantity mining
insert into Achievement (id, title,              description)
                 values (30, 'Lithabine mining', 'Mine Lithabine');

insert into AchievementPredecessor (id, predecessorId, predecessorStep, successorId) values (3001, 3, 2, 30);

insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (3001, 30,            1,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (30011, 3001, 3, 100);


insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (3002, 30,            2,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (30021, 3002, 3, 500);


insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (3003, 30,            3,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (30031, 3003, 3, 2500);


insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (3004, 30,            4,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (30041, 3004, 3, 10000);


insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (3005, 30,            5,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (30051, 3005, 3, 50000);


insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (3006, 30,            6,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (30061, 3006, 3, 100000);


-- Achievements - Lithabine - Mining score
insert into Achievement (id, title,                       description)
                 values (31, 'Improved Lithabine mining', 'Improve your mining efficiency for Lithabine ore');

insert into AchievementPredecessor (id, predecessorId, predecessorStep, successorId) values (3101, 30, 3, 31);

insert into AchievementStep (id,   achievementId, step, achievementPoints, miningAreaId)
                     values (3101, 31,            1,    10,                1202);

insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (310101, 3101, 1201, 400.0);


insert into AchievementStep (id,   achievementId, step, achievementPoints, miningAreaId)
                     values (3102, 31,            2,    10,                1203);

insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (310201, 3102, 1201, 650.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (310202, 3102, 1202, 600.0);


-- Achievements - Neudralion - Quantity mining
insert into Achievement (id, title,               description)
                 values (40, 'Neudralion mining', 'Mine Neudralion');

insert into AchievementPredecessor (id, predecessorId, predecessorStep, successorId) values (4001, 3, 3, 40);

insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (4001, 40,            1,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (40011, 4001, 4, 100);


insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (4002, 40,            2,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (40021, 4002, 4, 500);


insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (4003, 40,            3,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (40031, 4003, 4, 2500);


insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (4004, 40,            4,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (40041, 4004, 4, 10000);


insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (4005, 40,            5,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (40051, 4005, 4, 50000);


insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (4006, 40,            6,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (40061, 4006, 4, 100000);


-- Achievements - Neudralion - Mining score
insert into Achievement (id, title,                        description)
                 values (41, 'Improved Neudralion mining', 'Improve your mining efficiency for Neudralion ore');

insert into AchievementPredecessor (id, predecessorId, predecessorStep, successorId) values (4101, 40, 3, 41);

insert into AchievementStep (id,   achievementId, step, achievementPoints, miningAreaId)
                     values (4101, 41,            1,    10,                1302);

insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (410101, 4101, 1301, 700.0);


-- Achievements - Complatix - Quantity mining
insert into Achievement (id, title,              description)
                 values (50, 'Complatix mining', 'Mine Complatix');

insert into AchievementPredecessor (id, predecessorId, predecessorStep, successorId) values (5001, 3, 4, 50);

insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (5001, 50,            1,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (50011, 5001, 5, 100);


insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (5002, 50,            2,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (50021, 5002, 5, 500);


insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (5003, 50,            3,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (50031, 5003, 5, 2500);


insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (5004, 50,            4,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (50041, 5004, 5, 10000);


insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (5005, 50,            5,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (50051, 5005, 5, 50000);


insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (5006, 50,            6,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (50061, 5006, 5, 100000);


-- Achievements - Complatix - Mining score
insert into Achievement (id, title,                       description)
                 values (51, 'Improved Complatix mining', 'Improve your mining efficiency for Complatix ore');

insert into AchievementPredecessor (id, predecessorId, predecessorStep, successorId) values (5101, 50, 3, 51);

insert into AchievementStep (id,   achievementId, step, achievementPoints, miningAreaId)
                     values (5101, 51,            1,    10,                1402);

insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (510101, 5101, 1401, 400.0);


-- Achievements - Prantum - Quantity mining
insert into Achievement (id, title,            description)
                 values (60, 'Prantum mining', 'Mine Prantum');

insert into AchievementPredecessor (id, predecessorId, predecessorStep, successorId) values (6001, 3, 5, 60);

insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (6001, 60,            1,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (60011, 6001, 6, 100);


insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (6002, 60,            2,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (60021, 6002, 6, 500);


insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (6003, 60,            3,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (60031, 6003, 6, 2500);


insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (6004, 60,            4,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (60041, 6004, 6, 10000);


insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (6005, 60,            5,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (60051, 6005, 6, 50000);


insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (6006, 60,            6,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (60061, 6006, 6, 100000);


-- Achievements - Raxia - Quantity mining
insert into Achievement (id, title,          description)
                 values (70, 'Raxia mining', 'Mine Raxia');

insert into AchievementPredecessor (id, predecessorId, predecessorStep, successorId) values (7001, 3, 6, 70);

insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (7001, 70,            1,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (70011, 7001, 7, 100);


insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (7002, 70,            2,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (70021, 7002, 7, 500);


insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (7003, 70,            3,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (70031, 7003, 7, 2500);


insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (7004, 70,            4,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (70041, 7004, 7, 10000);


insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (7005, 70,            5,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (70051, 7005, 7, 50000);


insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (7006, 70,            6,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (70061, 7006, 7, 100000);


-- Achievements - Dipolir - Quantity mining
insert into Achievement (id, title,            description)
                 values (80, 'Dipolir mining', 'Mine Dipolir');

insert into AchievementPredecessor (id, predecessorId, predecessorStep, successorId) values (8001, 3, 7, 80);

insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (8001, 80,            1,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (80011, 8001, 8, 100);


insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (8002, 80,            2,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (80021, 8002, 8, 500);


insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (8003, 80,            3,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (80031, 8003, 8, 2500);


insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (8004, 80,            4,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (80041, 8004, 8, 10000);


insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (8005, 80,            5,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (80051, 8005, 8, 50000);


insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (8006, 80,            6,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (80061, 8006, 8, 100000);


-- Achievements - Asradon - Quantity mining
insert into Achievement (id, title,            description)
                 values (90, 'Asradon mining', 'Mine Asradon');

insert into AchievementPredecessor (id, predecessorId, predecessorStep, successorId) values (9001, 3, 8, 90);

insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (9001, 90,            1,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (90011, 9001, 9, 100);


insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (9002, 90,            2,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (90021, 9002, 9, 500);


insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (9003, 90,            3,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (90031, 9003, 9, 2500);


insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (9004, 90,            4,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (90041, 9004, 9, 10000);


insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (9005, 90,            5,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (90051, 9005, 9, 50000);


insert into AchievementStep (id,   achievementId, step, achievementPoints)
                     values (9006, 90,            6,    10);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (90061, 9006, 9, 100000);



-- Calculate the tier levels
update RobotPart
set tierId = 
(
select max(OrePriceAmount.oreId)
from OrePriceAmount
where OrePriceAmount.orePriceId = RobotPart.orePriceId
);
