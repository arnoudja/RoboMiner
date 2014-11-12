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
insert into Ore (id, oreName) values (10, 'Baratiem');

-- The robot part names
insert into RobotPartType (id, typeName) values (1, 'Ore container');
insert into RobotPartType (id, typeName) values (2, 'Mining unit');
insert into RobotPartType (id, typeName) values (3, 'Battery');
insert into RobotPartType (id, typeName) values (4, 'Memory module');
insert into RobotPartType (id, typeName) values (5, 'CPU');
insert into RobotPartType (id, typeName) values (6, 'Engine');

-- Ore containers - Cerbonium
insert into OrePrice (id, description) values (101, 'Standard Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (10101, 101, 1, 2);
insert into RobotPart (id,  typeId, partName,                 orePriceId, oreCapacity, weight, volume, powerUsage)
               values (101, 1,      'Standard Ore Container', 101,        15,          10,     20,     1);

insert into OrePrice (id, description) values (102, 'Enhanced Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (10201, 102, 1, 10);
insert into RobotPart (id,  typeId, partName,                 orePriceId, oreCapacity, weight, volume, powerUsage)
               values (102, 1,      'Enhanced Ore Container', 102,        25,          14,     30,     2);

insert into OrePrice (id, description) values (103, 'Cerbonium Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (10301, 103, 1, 50);
insert into RobotPart (id,  typeId, partName,                  orePriceId, oreCapacity, weight, volume, powerUsage)
               values (103, 1,      'Cerbonium Ore Container', 103,        30,          15,     35,     3);

-- Ore containers - Oxaria
insert into OrePrice (id, description) values (110, 'Oxaria Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (11002, 110, 2, 20);
insert into RobotPart (id,  typeId, partName,               orePriceId, oreCapacity, weight, volume, powerUsage)
               values (110, 1,      'Oxaria Ore Container', 110,        35,          16,     40,     4);

insert into OrePrice (id, description) values (111, 'Enhanced Oxaria Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (11101, 111, 1, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (11102, 111, 2, 50);
insert into RobotPart (id,  typeId, partName,                        orePriceId, oreCapacity, weight, volume, powerUsage)
               values (111, 1,      'Enhanced Oxaria Ore Container', 111,        40,          18,     45,     5);

-- Ore containers - Lithabine
insert into OrePrice (id, description) values (120, 'Lithabine Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (12001, 120, 1, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (12002, 120, 2, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (12003, 120, 3, 15);
insert into RobotPart (id,  typeId, partName,                  orePriceId, oreCapacity, weight, volume, powerUsage)
               values (120, 1,      'Lithabine Ore Container', 120,        45,          20,     50,     6);

insert into OrePrice (id, description) values (121, 'Enhanced Lithabine Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (12101, 121, 1, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (12102, 121, 2, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (12103, 121, 3, 60);
insert into RobotPart (id,  typeId, partName,                           orePriceId, oreCapacity, weight, volume, powerUsage)
               values (121, 1,      'Enhanced Lithabine Ore Container', 121,        50,          22,     55,     7);

-- Ore containers - Neudralion
insert into OrePrice (id, description) values (130, 'Neudralion Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (13002, 130, 2, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (13003, 130, 3, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (13004, 130, 4, 15);
insert into RobotPart (id,  typeId, partName,                   orePriceId, oreCapacity, weight, volume, powerUsage)
               values (130, 1,      'Neudralion Ore Container', 130,        55,          24,     60,     8);

insert into OrePrice (id, description) values (131, 'Enhanced Neudralion Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (13102, 131, 2, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (13103, 131, 3, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (13104, 131, 4, 60);
insert into RobotPart (id,  typeId, partName,                            orePriceId, oreCapacity, weight, volume, powerUsage)
               values (131, 1,      'Enhanced Neudralion Ore Container', 131,        60,          26,     65,     9);

-- Ore containers - Complatix
insert into OrePrice (id, description) values (140, 'Complatix Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (14003, 140, 3, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (14004, 140, 4, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (14005, 140, 5, 15);
insert into RobotPart (id,  typeId, partName,                  orePriceId, oreCapacity, weight, volume, powerUsage)
               values (140, 1,      'Complatix Ore Container', 140,        65,          28,     70,     10);

insert into OrePrice (id, description) values (141, 'Enhanced Complatix Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (14103, 141, 3, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (14104, 141, 4, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (14105, 141, 5, 60);
insert into RobotPart (id,  typeId, partName,                           orePriceId, oreCapacity, weight, volume, powerUsage)
               values (141, 1,      'Enhanced Complatix Ore Container', 141,        70,          30,     75,     11);

-- Ore containers - Prantum
insert into OrePrice (id, description) values (150, 'Prantum Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (15004, 150, 4, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (15005, 150, 5, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (15006, 150, 6, 15);
insert into RobotPart (id,  typeId, partName,                orePriceId, oreCapacity, weight, volume, powerUsage)
               values (150, 1,      'Prantum Ore Container', 150,        75,          32,     80,     12);

insert into OrePrice (id, description) values (151, 'Enhanced Prantum Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (15104, 151, 4, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (15105, 151, 5, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (15106, 151, 6, 60);
insert into RobotPart (id,  typeId, partName,                         orePriceId, oreCapacity, weight, volume, powerUsage)
               values (151, 1,      'Enhanced Prantum Ore Container', 151,        80,          34,     85,     13);

-- Ore containers - Raxia
insert into OrePrice (id, description) values (160, 'Raxia Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (16005, 160, 5, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (16006, 160, 6, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (16007, 160, 7, 15);
insert into RobotPart (id,  typeId, partName,              orePriceId, oreCapacity, weight, volume, powerUsage)
               values (160, 1,      'Raxia Ore Container', 160,        85,          36,     90,     14);

insert into OrePrice (id, description) values (161, 'Enhanced Raxia Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (16105, 161, 5, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (16106, 161, 6, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (16107, 161, 7, 60);
insert into RobotPart (id,  typeId, partName,                       orePriceId, oreCapacity, weight, volume, powerUsage)
               values (161, 1,      'Enhanced Raxia Ore Container', 161,        90,          38,     95,     15);

-- Ore containers - Dipolir
insert into OrePrice (id, description) values (170, 'Dipolir Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (17006, 170, 6, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (17007, 170, 7, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (17008, 170, 8, 15);
insert into RobotPart (id,  typeId, partName,                orePriceId, oreCapacity, weight, volume, powerUsage)
               values (170, 1,      'Dipolir Ore Container', 170,        95,          40,     100,    16);

insert into OrePrice (id, description) values (171, 'Enhanced Dipolir Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (17106, 171, 6, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (17107, 171, 7, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (17108, 171, 8, 60);
insert into RobotPart (id,  typeId, partName,                         orePriceId, oreCapacity, weight, volume, powerUsage)
               values (171, 1,      'Enhanced Dipolir Ore Container', 171,        100,         42,     105,    17);

-- Ore containers - Asradon
insert into OrePrice (id, description) values (180, 'Asradon Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (18007, 180, 7, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (18008, 180, 8, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (18009, 180, 9, 15);
insert into RobotPart (id,  typeId, partName,                orePriceId, oreCapacity, weight, volume, powerUsage)
               values (180, 1,      'Asradon Ore Container', 180,        105,         44,     110,    18);

insert into OrePrice (id, description) values (181, 'Enhanced Asradon Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (18107, 181, 7, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (18108, 181, 8, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (18109, 181, 9, 60);
insert into RobotPart (id,  typeId, partName,                         orePriceId, oreCapacity, weight, volume, powerUsage)
               values (181, 1,      'Enhanced Asradon Ore Container', 181,        110,         46,     115,    19);

-- Ore containers - Baratiem
insert into OrePrice (id, description) values (190, 'Baratiem Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (19008, 190,  8, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (19009, 190,  9, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (19010, 190, 10, 15);
insert into RobotPart (id,  typeId, partName,                 orePriceId, oreCapacity, weight, volume, powerUsage)
               values (190, 1,      'Baratiem Ore Container', 190,        115,         48,     120,    20);

insert into OrePrice (id, description) values (191, 'Enhanced Baratiem Ore Container price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (19108, 191,  8, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (19109, 191,  9, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (19110, 191, 10, 60);
insert into RobotPart (id,  typeId, partName,                          orePriceId, oreCapacity, weight, volume, powerUsage)
               values (191, 1,      'Enhanced Baratiem Ore Container', 191,        120,         50,     125,    21);


-- Mining units - Cerbonium
insert into OrePrice (id, description) values (201, 'Standard Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (20101, 201, 1, 2);
insert into RobotPart (id,  typeId, partName,               orePriceId, miningCapacity, weight, volume, powerUsage)
               values (201, 2,      'Standard Mining Unit', 201,        1,              10,     5,      8);

insert into OrePrice (id, description) values (202, 'Enhanced Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (20201, 202, 1, 10);
insert into RobotPart (id,  typeId, partName,               orePriceId, miningCapacity, weight, volume, powerUsage)
               values (202, 2,      'Enhanced Mining Unit', 202,        2,              14,     8,      12);

insert into OrePrice (id, description) values (203, 'Cerbonium Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (20301, 203, 1, 50);
insert into RobotPart (id,  typeId, partName,                orePriceId, miningCapacity, weight, volume, powerUsage)
               values (203, 2,      'Cerbonium Mining Unit', 203,        2,              15,     9,      11);

-- Mining units - Oxaria
insert into OrePrice (id, description) values (210, 'Oxaria Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (21002, 210, 2, 20);
insert into RobotPart (id,  typeId, partName,             orePriceId, miningCapacity, weight, volume, powerUsage)
               values (210, 2,      'Oxaria Mining Unit', 210,        3,              18,     11,     16);

insert into OrePrice (id, description) values (211, 'Enhanced Oxaria Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (21101, 211, 1, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (21102, 211, 2, 50);
insert into RobotPart (id,  typeId, partName,                      orePriceId, miningCapacity, weight, volume, powerUsage)
               values (211, 2,      'Enhanced Oxaria Mining Unit', 211,        3,              19,     12,     15);

-- Mining units - Lithabine
insert into OrePrice (id, description) values (220, 'Lithabine Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (22001, 220, 1, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (22002, 220, 2, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (22003, 220, 3, 15);
insert into RobotPart (id,  typeId, partName,                orePriceId, miningCapacity, weight, volume, powerUsage)
               values (220, 2,      'Lithabine Mining Unit', 220,        4,              20,     13,     18);

insert into OrePrice (id, description) values (221, 'Enhanced Lithabine Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (22101, 221, 1, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (22102, 221, 2, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (22103, 221, 3, 60);
insert into RobotPart (id,  typeId, partName,                         orePriceId, miningCapacity, weight, volume, powerUsage)
               values (221, 2,      'Enhanced Lithabine Mining Unit', 221,        4,              21,     14,     17);

-- Mining units - Neudralion
insert into OrePrice (id, description) values (230, 'Neudralion Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (23002, 230, 2, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (23003, 230, 3, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (23004, 230, 4, 15);
insert into RobotPart (id,  typeId, partName,                 orePriceId, miningCapacity, weight, volume, powerUsage)
               values (230, 2,      'Neudralion Mining Unit', 230,        5,              22,     15,     20);

insert into OrePrice (id, description) values (231, 'Enhanced Neudralion Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (23102, 231, 2, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (23103, 231, 3, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (23104, 231, 4, 60);
insert into RobotPart (id,  typeId, partName,                          orePriceId, miningCapacity, weight, volume, powerUsage)
               values (231, 2,      'Enhanced Neudralion Mining Unit', 231,        5,              23,     16,     19);

-- Mining units - Complatix
insert into OrePrice (id, description) values (240, 'Complatix Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (24003, 240, 3, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (24004, 240, 4, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (24005, 240, 5, 15);
insert into RobotPart (id,  typeId, partName,                orePriceId, miningCapacity, weight, volume, powerUsage)
               values (240, 2,      'Complatix Mining Unit', 240,        6,              24,     17,     25);

insert into OrePrice (id, description) values (241, 'Enhanced Complatix Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (24103, 241, 3, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (24104, 241, 4, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (24105, 241, 5, 60);
insert into RobotPart (id,  typeId, partName,                         orePriceId, miningCapacity, weight, volume, powerUsage)
               values (241, 2,      'Enhanced Complatix Mining Unit', 241,        6,              25,     18,     22);

-- Mining units - Prantum
insert into OrePrice (id, description) values (250, 'Prantum Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (25004, 250, 4, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (25005, 250, 5, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (25006, 250, 6, 15);
insert into RobotPart (id,  typeId, partName,              orePriceId, miningCapacity, weight, volume, powerUsage)
               values (250, 2,      'Prantum Mining Unit', 250,        7,              26,     19,     30);

insert into OrePrice (id, description) values (251, 'Enhanced Prantum Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2514, 251, 4, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2515, 251, 5, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (2516, 251, 6, 60);
insert into RobotPart (id,  typeId, partName,                       orePriceId, miningCapacity, weight, volume, powerUsage)
               values (251, 2,      'Enhanced Prantum Mining Unit', 251,        7,              27,     20,     27);

-- Mining units - Raxia
insert into OrePrice (id, description) values (260, 'Raxia Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (26005, 260, 5, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (26006, 260, 6, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (26007, 260, 7, 15);
insert into RobotPart (id,  typeId, partName,            orePriceId, miningCapacity, weight, volume, powerUsage)
               values (260, 2,      'Raxia Mining Unit', 260,        8,              28,     21,     35);

insert into OrePrice (id, description) values (261, 'Enhanced Raxia Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (26105, 261, 5, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (26106, 261, 6, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (26107, 261, 7, 60);
insert into RobotPart (id,  typeId, partName,                     orePriceId, miningCapacity, weight, volume, powerUsage)
               values (261, 2,      'Enhanced Raxia Mining Unit', 261,        8,              29,     22,     32);

-- Mining units - Dipolir
insert into OrePrice (id, description) values (270, 'Dipolir Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (27006, 270, 6, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (27007, 270, 7, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (27008, 270, 8, 15);
insert into RobotPart (id,  typeId, partName,              orePriceId, miningCapacity, weight, volume, powerUsage)
               values (270, 2,      'Dipolir Mining Unit', 270,        9,              30,     23,     40);

insert into OrePrice (id, description) values (271, 'Enhanced Dipolir Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (27106, 271, 6, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (27107, 271, 7, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (27108, 271, 8, 60);
insert into RobotPart (id,  typeId, partName,                       orePriceId, miningCapacity, weight, volume, powerUsage)
               values (271, 2,      'Enhanced Dipolir Mining Unit', 271,        5,              22,     15,     18);

-- Mining units - Asradon
insert into OrePrice (id, description) values (280, 'Asradon Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (28007, 280, 7, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (28008, 280, 8, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (28009, 280, 9, 15);
insert into RobotPart (id,  typeId, partName,              orePriceId, miningCapacity, weight, volume, powerUsage)
               values (280, 2,      'Asradon Mining Unit', 280,        10,             32,     24,     45);

insert into OrePrice (id, description) values (281, 'Enhanced Asradon Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (28107, 281, 7, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (28108, 281, 8, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (28109, 281, 9, 60);
insert into RobotPart (id,  typeId, partName,                       orePriceId, miningCapacity, weight, volume, powerUsage)
               values (281, 2,      'Enhanced Asradon Mining Unit', 281,        4,              19,     12,     16);

-- Mining units - Baratiem
insert into OrePrice (id, description) values (290, 'Baratiem Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (29008, 290,  8, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (29009, 290,  9, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (29010, 290, 10, 15);
insert into RobotPart (id,  typeId, partName,               orePriceId, miningCapacity, weight, volume, powerUsage)
               values (290, 2,      'Baratiem Mining Unit', 290,        11,             34,     25,     50);

insert into OrePrice (id, description) values (291, 'Enhanced Baratiem Mining Unit price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (29108, 291,  8, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (29109, 291,  9, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (29110, 291, 10, 60);
insert into RobotPart (id,  typeId, partName,                        orePriceId, miningCapacity, weight, volume, powerUsage)
               values (291, 2,      'Enhanced Baratiem Mining Unit', 291,        3,              18,     11,     14);


-- Batteries - Cerbonium
insert into OrePrice (id, description) values (301, 'Standard Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (30101, 301, 1, 2);
insert into RobotPart (id,  typeId, partName,           orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (301, 3,      'Standard Battery', 301,        2500,            5,            2,      2,      0);

insert into OrePrice (id, description) values (302, 'Enhanced Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (30201, 302, 1, 10);
insert into RobotPart (id,  typeId, partName,           orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (302, 3,      'Enhanced Battery', 302,        4000,            10,           3,      3,      0);

insert into OrePrice (id, description) values (303, 'Cerbonium Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (30301, 303, 1, 50);
insert into RobotPart (id,  typeId, partName,            orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (303, 3,      'Cerbonium Battery', 303,        6000,            15,           4,      3,      0);

-- Batteries - Oxaria
insert into OrePrice (id, description) values (310, 'Oxaria Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (31002, 310, 2, 20);
insert into RobotPart (id,  typeId, partName,         orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (310, 3,      'Oxaria Battery', 310,        9500,            30,           5,      3,      0);

insert into OrePrice (id, description) values (311, 'Enhanced Oxaria Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (31101, 311, 1, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (31102, 311, 2, 50);
insert into RobotPart (id,  typeId, partName,                  orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (311, 3,      'Enhanced Oxaria Battery', 311,        18000,           60,           5,      3,      0);

insert into OrePrice (id, description) values (312, 'Fast Charge Oxaria Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (31201, 312, 1, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (31202, 312, 2, 50);
insert into RobotPart (id,  typeId, partName,                     orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (312, 3,      'Fast Charge Oxaria Battery', 312,        17000,           40,           5,      4,      0);

-- Batteries - Lithabine
insert into OrePrice (id, description) values (320, 'Lithabine Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (32001, 320, 1, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (32002, 320, 2, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (32003, 320, 3, 15);
insert into RobotPart (id,  typeId, partName,            orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (320, 3,      'Lithabine Battery', 320,        22000,           75,           6,      5,      0);

insert into OrePrice (id, description) values (321, 'Enhanced Lithabine Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (32101, 321, 1, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (32102, 321, 2, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (32103, 321, 3, 60);
insert into RobotPart (id,  typeId, partName,                     orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (321, 3,      'Enhanced Lithabine Battery', 321,        25000,           90,           7,      6,      0);

-- Batteries - Neudralion
insert into OrePrice (id, description) values (330, 'Neudralion Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (33002, 330, 2, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (33003, 330, 3, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (33004, 330, 4, 15);
insert into RobotPart (id,  typeId, partName,             orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (330, 3,      'Neudralion Battery', 330,        34000,           120,           8,      7,      0);

insert into OrePrice (id, description) values (331, 'Enhanced Neudralion Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (33102, 331, 2, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (33103, 331, 3, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (33104, 331, 4, 60);
insert into RobotPart (id,  typeId, partName,                      orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (331, 3,      'Enhanced Neudralion Battery', 331,        42000,           180,          9,      8,      0);

-- Batteries - Complatix
insert into OrePrice (id, description) values (340, 'Complatix Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (34003, 340, 3, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (34004, 340, 4, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (34005, 340, 5, 15);
insert into RobotPart (id,  typeId, partName,            orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (340, 3,      'Complatix Battery', 340,        56000,           240,          10,     9,      0);

insert into OrePrice (id, description) values (341, 'Enhanced Complatix Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (34103, 341, 3, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (34104, 341, 4, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (34105, 341, 5, 60);
insert into RobotPart (id,  typeId, partName,                     orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (341, 3,      'Enhanced Complatix Battery', 341,        72000,           300,          11,     10,      0);

-- Batteries - Prantum
insert into OrePrice (id, description) values (350, 'Prantum Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (35004, 350, 4, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (35005, 350, 5, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (35006, 350, 6, 15);
insert into RobotPart (id,  typeId, partName,          orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (350, 3,      'Prantum Battery', 350,        120000,          360,          12,     11,     0);

insert into OrePrice (id, description) values (351, 'Enhanced Prantum Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (35104, 351, 4, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (35105, 351, 5, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (35106, 351, 6, 60);
insert into RobotPart (id,  typeId, partName,                   orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (351, 3,      'Enhanced Prantum Battery', 351,        120000,          180,          13,     12,     0);

-- Batteries - Raxia
insert into OrePrice (id, description) values (360, 'Raxia Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (36004, 360, 5, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (36005, 360, 6, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (36006, 360, 7, 15);
insert into RobotPart (id,  typeId, partName,        orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (360, 3,      'Raxia Battery', 360,        200000,          480,          14,     13,     0);

insert into OrePrice (id, description) values (361, 'Enhanced Raxia Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (36105, 361, 5, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (36106, 361, 6, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (36107, 361, 7, 60);
insert into RobotPart (id,  typeId, partName,                 orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (361, 3,      'Enhanced Raxia Battery', 361,        200000,          240,          15,     14,     0);

-- Batteries - Dipolir
insert into OrePrice (id, description) values (370, 'Dipolir Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (37006, 370, 6, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (37007, 370, 7, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (37008, 370, 8, 15);
insert into RobotPart (id,  typeId, partName,          orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (370, 3,      'Dipolir Battery', 370,        260000,          600,          16,     15,     0);

insert into OrePrice (id, description) values (371, 'Enhanced Dipolir Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (37106, 371, 6, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (37107, 371, 7, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (37108, 371, 8, 60);
insert into RobotPart (id,  typeId, partName,                   orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (371, 3,      'Enhanced Dipolir Battery', 371,        260000,          300,          17,     16,     0);

-- Batteries - Asradon
insert into OrePrice (id, description) values (380, 'Asradon Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (38007, 380, 7, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (38008, 380, 8, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (38009, 380, 9, 15);
insert into RobotPart (id,  typeId, partName,          orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (380, 3,      'Asradon Battery', 380,        420000,          720,          18,      17,     0);

insert into OrePrice (id, description) values (381, 'Enhanced Asradon Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (38107, 381, 7, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (38108, 381, 8, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (38109, 381, 9, 60);
insert into RobotPart (id,  typeId, partName,                   orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (381, 3,      'Enhanced Asradon Battery', 381,        420000,          360,          19,     18,     0);

-- Batteries - Baratiem
insert into OrePrice (id, description) values (390, 'Baratiem Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (39008, 390,  8, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (39009, 390,  9, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (39010, 390, 10, 15);
insert into RobotPart (id,  typeId, partName,           orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (390, 3,      'Baratiem Battery', 390,        520000,          840,          20,      19,     0);

insert into OrePrice (id, description) values (391, 'Enhanced Baratiem Battery price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (39108, 391,  8, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (39109, 391,  9, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (39110, 391, 10, 60);
insert into RobotPart (id,  typeId, partName,                    orePriceId, batteryCapacity, rechargeTime, weight, volume, powerUsage)
               values (391, 3,      'Enhanced Baratiem Battery', 391,        520000,          420,          21,     20,     0);


-- Memory modules - Cerbonium
insert into OrePrice (id, description) values (401, 'Standard Memory Module price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (40101, 401, 1, 2);
insert into RobotPart (id,  typeId, partName,                 orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (401, 4,      'Standard Memory Module', 401,        8,              1,      1,      1);

insert into OrePrice (id, description) values (402, 'Enhanced Memory Module price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (40201, 402, 1, 10);
insert into RobotPart (id,  typeId, partName,                 orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (402, 4,      'Enhanced Memory Module', 402,        16,             1,      1,      2);

insert into OrePrice (id, description) values (403, 'Cerbonium Memory Module price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (40301, 403, 1, 50);
insert into RobotPart (id,  typeId, partName,                  orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (403, 4,      'Cerbonium Memory Module', 403,        24,             1,      1,      3);

-- Memory modules - Oxaria
insert into OrePrice (id, description) values (410, 'Oxaria Memory Module price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (41002, 410, 2, 20);
insert into RobotPart (id,  typeId, partName,               orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (410, 4,      'Oxaria Memory Module', 410,        32,             1,      1,      4);

insert into OrePrice (id, description) values (411, 'Enhanced Oxaria Memory Module price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (41101, 411, 1, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (41102, 411, 2, 50);
insert into RobotPart (id,  typeId, partName,                        orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (411, 4,      'Enhanced Oxaria Memory Module', 411,        48,             1,      1,      5);

-- Memory modules - Lithabine
insert into OrePrice (id, description) values (420, 'Lithabine Memory Module price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (42001, 420, 1, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (42002, 420, 2, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (42003, 420, 3, 15);
insert into RobotPart (id,  typeId, partName,                  orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (420, 4,      'Lithabine Memory Module', 420,        64,             1,      1,      6);

insert into OrePrice (id, description) values (421, 'Enhanced Lithabine Memory Module price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (42101, 421, 1, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (42102, 421, 2, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (42103, 421, 3, 60);
insert into RobotPart (id,  typeId, partName,                           orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (421, 4,      'Enhanced Lithabine Memory Module', 421,        80,             1,      1,      7);

-- Memory modules - Neudralion
insert into OrePrice (id, description) values (430, 'Neudralion Memory Module price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (43002, 430, 2, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (43003, 430, 3, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (43004, 430, 4, 15);
insert into RobotPart (id,  typeId, partName,                   orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (430, 4,      'Neudralion Memory Module', 430,        96,             1,      1,      8);

insert into OrePrice (id, description) values (431, 'Enhanced Neudralion Memory Module price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (43102, 431, 2, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (43103, 431, 3, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (43104, 431, 4, 60);
insert into RobotPart (id,  typeId, partName,                            orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (431, 4,      'Enhanced Neudralion Memory Module', 431,        112,            1,      1,      9);

-- Memory modules - Complatix
insert into OrePrice (id, description) values (440, 'Complatix Memory Module price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (44003, 440, 3, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (44004, 440, 4, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (44005, 440, 5, 15);
insert into RobotPart (id,  typeId, partName,                  orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (440, 4,      'Complatix Memory Module', 440,        128,            1,      1,      10);

insert into OrePrice (id, description) values (441, 'Enhanced Complatix Memory Module price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (44103, 441, 3, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (44104, 441, 4, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (44105, 441, 5, 60);
insert into RobotPart (id,  typeId, partName,                           orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (441, 4,      'Enhanced Complatix Memory Module', 441,        160,            1,      1,      11);

-- Memory modules - Prantum
insert into OrePrice (id, description) values (450, 'Prantum Memory Module price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (45004, 450, 4, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (45005, 450, 5, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (45006, 450, 6, 15);
insert into RobotPart (id,  typeId, partName,                orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (450, 4,      'Prantum Memory Module', 450,        192,            1,      1,      12);

insert into OrePrice (id, description) values (451, 'Enhanced Prantum Memory Module price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (45104, 451, 4, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (45105, 451, 5, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (45106, 451, 6, 60);
insert into RobotPart (id,  typeId, partName,                         orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (451, 4,      'Enhanced Prantum Memory Module', 451,        224,            1,      1,      13);

-- Memory modules - Raxia
insert into OrePrice (id, description) values (460, 'Raxia Memory Module price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (46005, 460, 5, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (46006, 460, 6, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (46007, 460, 7, 15);
insert into RobotPart (id,  typeId, partName,              orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (460, 4,      'Raxia Memory Module', 460,        256,            1,      1,      14);

insert into OrePrice (id, description) values (461, 'Enhanced Raxia Memory Module price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (46105, 461, 5, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (46106, 461, 6, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (46107, 461, 7, 60);
insert into RobotPart (id,  typeId, partName,                       orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (461, 4,      'Enhanced Raxia Memory Module', 461,        288,            1,      1,      15);

-- Memory modules - Dipolir
insert into OrePrice (id, description) values (470, 'Dipolir Memory Module price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (47006, 470, 6, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (47007, 470, 7, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (47008, 470, 8, 15);
insert into RobotPart (id,  typeId, partName,                orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (470, 4,      'Dipolir Memory Module', 470,        320,            1,      1,      16);

insert into OrePrice (id, description) values (471, 'Enhanced Dipolir Memory Module price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (47106, 471, 6, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (47107, 471, 7, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (47108, 471, 8, 60);
insert into RobotPart (id,  typeId, partName,                         orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (471, 4,      'Enhanced Dipolir Memory Module', 471,        352,            1,      1,      17);

-- Memory modules - Asradon
insert into OrePrice (id, description) values (480, 'Asradon Memory Module price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (48007, 480, 7, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (48008, 480, 8, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (48009, 480, 9, 15);
insert into RobotPart (id,  typeId, partName,                orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (480, 4,      'Asradon Memory Module', 480,        384,            1,      1,      18);

insert into OrePrice (id, description) values (481, 'Enhanced Asradon Memory Module price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (48107, 481, 7, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (48108, 481, 8, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (48109, 481, 9, 60);
insert into RobotPart (id,  typeId, partName,                         orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (481, 4,      'Enhanced Asradon Memory Module', 481,        416,            1,      1,      19);

-- Memory modules - Baratiem
insert into OrePrice (id, description) values (490, 'Baratiem Memory Module price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (49008, 490,  8, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (49009, 490,  9, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (49010, 490, 10, 15);
insert into RobotPart (id,  typeId, partName,                 orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (490, 4,      'Baratiem Memory Module', 490,        448,            1,      1,      20);

insert into OrePrice (id, description) values (491, 'Enhanced Baratiem Memory Module price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (49108, 491,  8, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (49109, 491,  9, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (49110, 491, 10, 60);
insert into RobotPart (id,  typeId, partName,                          orePriceId, memoryCapacity, weight, volume, powerUsage)
               values (491, 4,      'Enhanced Baratiem Memory Module', 491,        480,            1,      1,      21);


-- CPUs - Cerbonium
insert into OrePrice (id, description) values (501, 'Standard CPU price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (50101, 501, 1, 2);
insert into RobotPart (id,  typeId, partName,       orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (501, 5,      'Standard CPU', 501,        2,           1,      1,      1);

insert into OrePrice (id, description) values (502, 'Enhanced CPU price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (50201, 502, 1, 10);
insert into RobotPart (id,  typeId, partName,       orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (502, 5,      'Enhanced CPU', 502,        4,           1,      1,      1);

insert into OrePrice (id, description) values (503, 'Cerbonium CPU price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (50301, 503, 1, 50);
insert into RobotPart (id,  typeId, partName,        orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (503, 5,      'Cerbonium CPU', 503,        8,           1,      1,      2);

-- CPUs - Oxaria
insert into OrePrice (id, description) values (510, 'Oxaria CPU price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (51002, 510, 2, 20);
insert into RobotPart (id,  typeId, partName,     orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (510, 5,      'Oxaria CPU', 510,        12,           1,      1,      3);

insert into OrePrice (id, description) values (511, 'Enhanced Oxaria CPU price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (51101, 511, 1, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (51102, 511, 2, 50);
insert into RobotPart (id,  typeId, partName,              orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (511, 5,      'Enhanced Oxaria CPU', 511,        16,          1,      1,      4);

-- CPUs - Lithabine
insert into OrePrice (id, description) values (520, 'Lithabine CPU price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (52001, 520, 1, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (52002, 520, 2, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (52003, 520, 3, 15);
insert into RobotPart (id,  typeId, partName,        orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (520, 5,      'Lithabine CPU', 520,        20,          1,      1,      5);

insert into OrePrice (id, description) values (521, 'Enhanced Lithabine CPU price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (52101, 521, 1, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (52102, 521, 2, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (52103, 521, 3, 60);
insert into RobotPart (id,  typeId, partName,                 orePriceId, cpuCapacity,  weight, volume, powerUsage)
               values (521, 5,      'Enhanced Lithabine CPU', 521,        24,           1,      1,      6);

-- CPUs - Neudralion
insert into OrePrice (id, description) values (530, 'Neudralion CPU price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (53002, 530, 2, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (53003, 530, 3, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (53004, 530, 4, 15);
insert into RobotPart (id,  typeId, partName,         orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (530, 5,      'Neudralion CPU', 530,        28,          1,      1,      7);

insert into OrePrice (id, description) values (531, 'Enhanced Neudralion CPU price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (53102, 531, 2, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (53103, 531, 3, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (53104, 531, 4, 60);
insert into RobotPart (id,  typeId, partName,                  orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (531, 5,      'Enhanced Neudralion CPU', 531,        32,          1,      1,      8);

-- CPUs - Complatix
insert into OrePrice (id, description) values (540, 'Complatix CPU price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (54003, 540, 3, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (54004, 540, 4, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (54005, 540, 5, 15);
insert into RobotPart (id,  typeId, partName,        orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (540, 5,      'Complatix CPU', 540,        36,          1,      1,      9);

insert into OrePrice (id, description) values (541, 'Enhanced Complatix CPU price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (54103, 541, 3, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (54104, 541, 4, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (54105, 541, 5, 60);
insert into RobotPart (id,  typeId, partName,                 orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (541, 5,      'Enhanced Complatix CPU', 541,        40,          1,      1,      10);

-- CPUs - Prantum
insert into OrePrice (id, description) values (550, 'Prantum CPU price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (55004, 550, 4, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (55005, 550, 5, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (55006, 550, 6, 15);
insert into RobotPart (id,  typeId, partName,      orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (550, 5,      'Prantum CPU', 550,        44,          1,      1,      11);

insert into OrePrice (id, description) values (551, 'Enhanced Prantum CPU price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (55104, 551, 4, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (55105, 551, 5, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (55106, 551, 6, 60);
insert into RobotPart (id,  typeId, partName,               orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (551, 5,      'Enhanced Prantum CPU', 551,        48,          1,      1,      12);

-- CPUs - Raxia
insert into OrePrice (id, description) values (560, 'Raxia CPU price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (56005, 560, 5, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (56006, 560, 6, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (56007, 560, 7, 15);
insert into RobotPart (id,  typeId, partName,    orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (560, 5,      'Raxia CPU', 560,        52,          1,      1,      13);

insert into OrePrice (id, description) values (561, 'Enhanced Raxia CPU price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (56105, 561, 5, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (56106, 561, 6, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (56107, 561, 7, 60);
insert into RobotPart (id,  typeId, partName,             orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (561, 5,      'Enhanced Raxia CPU', 561,        56,          1,      1,      14);

-- CPUs - Dipolir
insert into OrePrice (id, description) values (570, 'Dipolir CPU price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (57006, 570, 6, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (57007, 570, 7, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (57008, 570, 8, 15);
insert into RobotPart (id,  typeId, partName,      orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (570, 5,      'Dipolir CPU', 570,        60,          1,      1,      15);

insert into OrePrice (id, description) values (571, 'Enhanced Dipolir CPU price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (57106, 571, 6, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (57107, 571, 7, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (57108, 571, 8, 60);
insert into RobotPart (id,  typeId, partName,               orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (571, 5,      'Enhanced Dipolir CPU', 571,        64,          1,      1,      16);

-- CPUs - Asradon
insert into OrePrice (id, description) values (580, 'Asradon CPU price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (58007, 580, 7, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (58008, 580, 8, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (58009, 580, 9, 15);
insert into RobotPart (id,  typeId, partName,      orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (580, 5,      'Asradon CPU', 580,        68,          1,      1,      17);

insert into OrePrice (id, description) values (581, 'Enhanced Asradon CPU price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (58107, 581, 7, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (58108, 581, 8, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (58109, 581, 9, 60);
insert into RobotPart (id,  typeId, partName,               orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (581, 5,      'Enhanced Asradon CPU', 581,        72,          1,      1,      18);

-- CPUs - Baratiem
insert into OrePrice (id, description) values (590, 'Baratiem CPU price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (59008, 590,  8, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (59009, 590,  9, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (59010, 590, 10, 15);
insert into RobotPart (id,  typeId, partName,       orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (590, 5,      'Baratiem CPU', 590,        76,          1,      1,      19);

insert into OrePrice (id, description) values (591, 'Enhanced Baratiem CPU price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (59108, 591,  8, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (59109, 591,  9, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (59120, 591, 10, 60);
insert into RobotPart (id,  typeId, partName,                orePriceId, cpuCapacity, weight, volume, powerUsage)
               values (591, 5,      'Enhanced Baratiem CPU', 591,        80,          1,      1,      20);


-- Engines - Cerbonium
insert into OrePrice (id, description) values (601, 'Standard Engine price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (60101, 601, 1, 2);
insert into RobotPart (id,  typeId, partName,          orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (601, 6,      'Standard Engine', 601,        8,               8,                8,              8,      4,      8);

insert into OrePrice (id, description) values (602, 'Enhanced Engine price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (60201, 602, 1, 10);
insert into RobotPart (id,  typeId, partName,          orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (602, 6,      'Enhanced Engine', 602,        12,              12,               12,             9 ,     5,      12);

insert into OrePrice (id, description) values (603, 'Cerbonium Engine price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (60301, 603, 1, 50);
insert into RobotPart (id,  typeId, partName,           orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (603, 6,      'Cerbonium Engine', 603,        16,              16,               16,             10,     6,      15);

-- Engines - Oxaria
insert into OrePrice (id, description) values (610, 'Oxaria Engine price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (61002, 610, 2, 20);
insert into RobotPart (id,  typeId, partName,        orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (610, 6,      'Oxaria Engine', 610,        24,              24,               24,             11,     7,      20);

insert into OrePrice (id, description) values (611, 'Enhanced Oxaria Engine price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (61101, 611, 1, 100);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (61102, 611, 2, 50);
insert into RobotPart (id,  typeId, partName,                 orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (611, 6,      'Enhanced Oxaria Engine', 611,        32,              32,               32,             12,     8,      25);

-- Engines - Lithabine
insert into OrePrice (id, description) values (620, 'Lithabine Engine price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (62001, 620, 1, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (62002, 620, 2, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (62003, 620, 3, 15);
insert into RobotPart (id,  typeId, partName,           orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (620, 6,      'Lithabine Engine', 620,        40,              40,               40,             13,     9,     28);

insert into OrePrice (id, description) values (621, 'Enhanced Lithabine Engine price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (62101, 621, 1, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (62102, 621, 2, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (62103, 621, 3, 60);
insert into RobotPart (id,  typeId, partName,                    orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (621, 6,      'Enhanced Lithabine Engine', 621,        48,              48,               48,             14,     10,     30);

-- Engines - Neudralion
insert into OrePrice (id, description) values (630, 'Neudralion Engine price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (63002, 630, 2, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (63003, 630, 3, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (63004, 630, 4, 15);
insert into RobotPart (id,  typeId, partName,            orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (630, 6,      'Neudralion Engine', 630,        64,              64,               64,             15,     11,     35);

insert into OrePrice (id, description) values (631, 'Enhanced Neudralion Engine price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (63102, 631, 2, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (63103, 631, 3, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (63104, 631, 4, 60);
insert into RobotPart (id,  typeId, partName,                     orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (631, 6,      'Enhanced Neudralion Engine', 631,        80,              80,               80,             16,     12,     40);

-- Engines - Complatix
insert into OrePrice (id, description) values (640, 'Complatix Engine price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (64003, 640, 3, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (64004, 640, 4, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (64005, 640, 5, 15);
insert into RobotPart (id,  typeId, partName,           orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (640, 6,      'Complatix Engine', 640,        96,              96,               96,             17,     13,     45);

insert into OrePrice (id, description) values (641, 'Enhanced Complatix Engine price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (64103, 641, 3, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (64104, 641, 4, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (64105, 641, 5, 60);
insert into RobotPart (id,  typeId, partName,                    orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (641, 6,      'Enhanced Complatix Engine', 641,        112,             112,              112,            18,     14,     50);

-- Engines - Prantum
insert into OrePrice (id, description) values (650, 'Prantum Engine price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (65004, 650, 4, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (65005, 650, 5, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (65006, 650, 6, 15);
insert into RobotPart (id,  typeId, partName,         orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (650, 6,      'Prantum Engine', 650,        128,             128,              128,            19,     15,     55);

insert into OrePrice (id, description) values (651, 'Enhanced Prantum Engine price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (65104, 651, 4, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (65105, 651, 5, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (65106, 651, 6, 60);
insert into RobotPart (id,  typeId, partName,                  orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (651, 6,      'Enhanced Prantum Engine', 651,        140,             140,              140,            20,     16,     60);

-- Engines - Raxia
insert into OrePrice (id, description) values (660, 'Raxia Engine price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (66005, 660, 5, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (66006, 660, 6, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (66007, 660, 7, 15);
insert into RobotPart (id,  typeId, partName,       orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (660, 6,      'Raxia Engine', 660,        156,             156,              172,            21,     17,     65);

insert into OrePrice (id, description) values (661, 'Enhanced Raxia Engine price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (66105, 661, 5, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (66106, 661, 6, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (66107, 661, 7, 60);
insert into RobotPart (id,  typeId, partName,                orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (661, 6,      'Enhanced Raxia Engine', 661,        172,             172,              188,            22,     18,     70);

-- Engines - Dipolir
insert into OrePrice (id, description) values (670, 'Dipolir Engine price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (67006, 670, 6, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (67007, 670, 7, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (67008, 670, 8, 15);
insert into RobotPart (id,  typeId, partName,         orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (670, 6,      'Dipolir Engine', 670,        188,             188,              220,            23,     19,     75);

insert into OrePrice (id, description) values (671, 'Enhanced Dipolir Engine price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (67106, 671, 6, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (67107, 671, 7, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (67108, 671, 8, 60);
insert into RobotPart (id,  typeId, partName,                  orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (671, 6,      'Enhanced Dipolir Engine', 671,        204,             204,              252,            24,     20,     80);

-- Engines - Asradon
insert into OrePrice (id, description) values (680, 'Asradon Engine price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (68007, 680, 7, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (68008, 680, 8, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (68009, 680, 9, 15);
insert into RobotPart (id,  typeId, partName,         orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (680, 6,      'Asradon Engine', 680,        220,             220,              284,            25,     21,     85);

insert into OrePrice (id, description) values (681, 'Enhanced Asradon Engine price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (68107, 681, 7, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (68108, 681, 8, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (68109, 681, 9, 60);
insert into RobotPart (id,  typeId, partName,                  orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (681, 6,      'Enhanced Asradon Engine', 681,        236,             236,              316,            26,     22,     90);

-- Engines - Baratiem
insert into OrePrice (id, description) values (690, 'Baratiem Engine price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (69008, 690,  8, 300);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (69009, 690,  9, 150);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (69010, 690, 10, 15);
insert into RobotPart (id,  typeId, partName,          orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (690, 6,      'Baratiem Engine', 690,        252,             252,              348,            27,     23,     95);

insert into OrePrice (id, description) values (691, 'Enhanced Baratiem Engine price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (69108, 691,  8, 500);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (69109, 691,  9, 250);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (69110, 691, 10, 60);
insert into RobotPart (id,  typeId, partName,                   orePriceId, forwardCapacity, backwardCapacity, rotateCapacity, weight, volume, powerUsage)
               values (691, 6,      'Enhanced Baratiem Engine', 691,        268,             268,              380,            28,     24,     100);


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
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1201, 3, 5, 5);

insert into OrePrice (id, description) values (1202, 'Mining Area Lithabine-2 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (12021, 1202, 1, 15);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (12022, 1202, 2, 10);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (12023, 1202, 3, 1);
insert into MiningArea (id,   areaName,      orePriceId, sizeX, sizeY, maxMoves, miningTime, taxRate, aiRobotId)
                values (1202, 'Lithabine-2', 1202,       60,    60,    700,      240,        10,      3);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1202, 1, 10, 6);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1202, 2, 10, 5);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1202, 3, 5, 5);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1202, 3, 5, 5);

insert into OrePrice (id, description) values (1203, 'Mining Area Lithabine-3 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (12031, 1203, 1, 20);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (12032, 1203, 2, 15);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (12033, 1203, 3, 2);
insert into MiningArea (id,   areaName,      orePriceId, sizeX, sizeY, maxMoves, miningTime, taxRate, aiRobotId)
                values (1203, 'Lithabine-3', 1203,       80,    80,    1400,     480,        0,       3);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1203, 1, 10, 6);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1203, 2, 10, 5);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1203, 3, 5, 5);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1203, 3, 5, 5);

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
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1501, 6, 4, 5);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1501, 6, 4, 5);

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
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1701, 8, 3, 4);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1701, 8, 3, 4);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1701, 8, 3, 4);

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
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1801, 9,  3, 3);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1801, 9,  3, 3);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1801, 9,  3, 3);

-- Baratiem
insert into OrePrice (id, description) values (1901, 'Mining Area Baratiem-1 price');
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (19011, 1901, 1, 50);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (19012, 1901, 2, 45);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (19013, 1901, 3, 40);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (19014, 1901, 4, 35);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (19015, 1901, 5, 30);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (19016, 1901, 6, 25);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (19017, 1901, 7, 20);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (19018, 1901, 8, 15);
insert into OrePriceAmount (id, orePriceId, oreId, amount) values (19019, 1901, 9, 10);
insert into MiningArea (id,   areaName,     orePriceId, sizeX, sizeY, maxMoves, miningTime, taxRate, aiRobotId)
                values (1901, 'Baratiem-1', 1901,       110,   110,   3200,     14400,      70,      3);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1901,  1, 15, 15);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1901,  1, 15, 15);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1901,  2, 15, 15);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1901, 10,  2, 3);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1901, 10,  2, 3);
insert into MiningAreaOreSupply (miningAreaId, oreId, supply, radius) values (1901, 10,  2, 3);


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
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2083, 208, 1101, 350.0);


insert into AchievementStep (id,  achievementId, step, achievementPoints, miningQueueReward)
                     values (209, 2,             9,    10,                1);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (2091, 209, 6, 250);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2092, 209, 1002, 800.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2093, 209, 1101, 400.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2094, 209, 1201, 250.0);


insert into AchievementStep (id,  achievementId, step, achievementPoints, miningQueueReward)
                     values (210, 2,             10,   10,                1);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (2101, 210, 7, 250);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2102, 210, 1003, 900.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2103, 210, 1103, 650.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2104, 210, 1201, 350.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2105, 210, 1301, 250.0);


insert into AchievementStep (id,  achievementId, step, achievementPoints, miningQueueReward)
                     values (211, 2,             11,   10,                1);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (2111, 211, 8, 250);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2112, 211, 1103, 650.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2113, 211, 1203, 500.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2114, 211, 1302, 450.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2115, 211, 1401, 400.0);


insert into AchievementStep (id,  achievementId, step, achievementPoints, miningQueueReward)
                     values (212, 2,             12,   10,                1);

insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2121, 212, 1103, 800.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2122, 212, 1203, 600.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2123, 212, 1302, 550.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2124, 212, 1402, 500.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2125, 212, 1501, 500.0);


insert into AchievementStep (id,  achievementId, step, achievementPoints, miningQueueReward)
                     values (213, 2,             13,   10,                1);

insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2131, 213, 1103, 850.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2132, 213, 1203, 650.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2133, 213, 1302, 600.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2134, 213, 1402, 550.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2135, 213, 1501, 550.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2136, 213, 1601, 500.0);


insert into AchievementStep (id,  achievementId, step, achievementPoints, miningQueueReward)
                     values (214, 2,             14,   10,                1);

insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2141, 214, 1103, 900.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2142, 214, 1203, 700.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2143, 214, 1302, 650.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2144, 214, 1402, 600.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2145, 214, 1501, 600.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2146, 214, 1601, 550.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2147, 214, 1701, 500.0);


insert into AchievementStep (id,  achievementId, step, achievementPoints, miningQueueReward)
                     values (215, 2,             15,   10,                1);

insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2151, 215, 1203, 800.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2152, 215, 1302, 750.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2153, 215, 1402, 700.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2154, 215, 1501, 650.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2155, 215, 1601, 600.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2156, 215, 1701, 550.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2157, 215, 1801, 500.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (2158, 215, 1901, 450.0);


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
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (3024, 302, 1101, 300.0);

-- Neudralion-1
insert into AchievementStep (id,  achievementId, step, achievementPoints, miningAreaId)
                     values (303, 3,             3,    10,                1301);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (3031, 303, 1, 5000);
insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (3032, 303, 2, 1000);
insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (3033, 303, 3, 250);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (3034, 303, 1001, 700.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (3035, 303, 1101, 350.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (3036, 303, 1201, 200.0);

-- Complatix-1
insert into AchievementStep (id,  achievementId, step, achievementPoints, miningAreaId)
                     values (304, 3,             4,    10,                1401);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (3041, 304, 2, 5000);
insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (3042, 304, 3, 1000);
insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (3043, 304, 4, 250);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (3044, 304, 1101, 400.0);
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

-- Baratiem-1
insert into AchievementStep (id,  achievementId, step, achievementPoints, miningAreaId)
                     values (309, 3,             9,    10,                1901);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (3091, 309, 7, 5000);
insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (3092, 309, 8, 1000);
insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (3093, 309, 9, 250);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (3094, 309, 1601, 400.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (3095, 309, 1701, 250.0);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (3096, 309, 1801, 200.0);


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

insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (1001, 10,            1,    10,                1,     50);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (10011, 1001, 1, 50);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (1002, 10,            2,    10,                1,     75);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (10021, 1002, 1, 100);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (1003, 10,            3,    10,                1,     150);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (10031, 1003, 1, 250);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (1004, 10,            4,    10,                1,     250);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (10041, 1004, 1, 1000);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (1005, 10,            5,    10,                1,     1000);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (10051, 1005, 1, 2500);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (1006, 10,            6,    10,                1,     2000);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount)              values (10061, 1006, 1, 10000);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (10062, 1006, 1001, 800.0);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (1007, 10,            7,    10,                1,     5000);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount)              values (10071, 1007, 1, 50000);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (10072, 1007, 1002, 800.0);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (1008, 10,            8,    10,                1,     9999);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount)              values (10081, 1008, 1, 100000);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (10082, 1008, 1003, 800.0);


-- Achievements - Cerbonium - Mining score
insert into Achievement (id, title,                       description)
                 values (11, 'Improved Cerbonium mining', 'Improve your mining efficiency for Cerbonium ore');

insert into AchievementPredecessor (id, predecessorId, predecessorStep, successorId) values (1101, 10, 4, 11);

insert into AchievementStep (id,   achievementId, step, achievementPoints, miningAreaId)
                     values (1101, 11,            1,    10,                1002);

insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (110101, 1101, 1001, 760.0);


insert into AchievementStep (id,   achievementId, step, achievementPoints, miningAreaId)
                     values (1102, 11,            2,    10,                1003);

insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (110201, 1102, 1002, 800.0);


-- Achievements - Oxaria - Quantity mining
insert into Achievement (id, title,           description)
                 values (20, 'Oxaria mining', 'Mine Oxaria');

insert into AchievementPredecessor (id, predecessorId, predecessorStep, successorId) values (2001, 3, 1, 20);

insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (2001, 20,            1,    10,                2,     50);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (20011, 2001, 2, 50);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (2002, 20,            2,    10,                2,     75);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (20021, 2002, 2, 100);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (2003, 20,            3,    10,                2,     150);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (20031, 2003, 2, 250);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (2004, 20,            4,    10,                2,     250);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (20041, 2004, 2, 1000);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (2005, 20,            5,    10,                2,     1000);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (20051, 2005, 2, 2500);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (2006, 20,            6,    10,                2,     2000);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount)              values (20061, 2006, 2, 10000);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (20062, 2006, 1101, 800.0);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (2007, 20,            7,    10,                2,     5000);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount)              values (20071, 2007, 2, 50000);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (20072, 2007, 1102, 800.0);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (2008, 20,            8,    10,                2,     9999);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount)              values (20081, 2008, 2, 100000);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (20082, 2008, 1103, 800.0);


-- Achievements - Oxaria - Mining score
insert into Achievement (id, title,                    description)
                 values (21, 'Improved Oxaria mining', 'Improve your mining efficiency for Oxaria ore');

insert into AchievementPredecessor (id, predecessorId, predecessorStep, successorId) values (2101, 20, 3, 21);

insert into AchievementStep (id,   achievementId, step, achievementPoints, miningAreaId)
                     values (2101, 21,            1,    10,                1102);

insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (210101, 2101, 1101, 400.0);


insert into AchievementStep (id,   achievementId, step, achievementPoints, miningAreaId)
                     values (2102, 21,            2,    10,                1103);

insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (210201, 2102, 1102, 450.0);


-- Achievements - Lithabine - Quantity mining
insert into Achievement (id, title,              description)
                 values (30, 'Lithabine mining', 'Mine Lithabine');

insert into AchievementPredecessor (id, predecessorId, predecessorStep, successorId) values (3001, 3, 2, 30);

insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (3001, 30,            1,    10,                3,     50);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (30011, 3001, 3, 50);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (3002, 30,            2,    10,                3,     75);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (30021, 3002, 3, 100);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (3003, 30,            3,    10,                3,     150);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (30031, 3003, 3, 250);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (3004, 30,            4,    10,                3,     250);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (30041, 3004, 3, 1000);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (3005, 30,            5,    10,                3,     1000);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (30051, 3005, 3, 2500);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (3006, 30,            6,    10,                3,     2000);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount)              values (30061, 3006, 3, 10000);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (30062, 3006, 1201, 800.0);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (3007, 30,            7,    10,                3,     5000);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount)              values (30071, 3007, 3, 50000);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (30072, 3007, 1202, 800.0);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (3008, 30,            8,    10,                3,     9999);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount)              values (30081, 3008, 3, 100000);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (30082, 3008, 1203, 800.0);


-- Achievements - Lithabine - Mining score
insert into Achievement (id, title,                       description)
                 values (31, 'Improved Lithabine mining', 'Improve your mining efficiency for Lithabine ore');

insert into AchievementPredecessor (id, predecessorId, predecessorStep, successorId) values (3101, 30, 3, 31);

insert into AchievementStep (id,   achievementId, step, achievementPoints, miningAreaId)
                     values (3101, 31,            1,    10,                1202);

insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (310101, 3101, 1201, 400.0);


insert into AchievementStep (id,   achievementId, step, achievementPoints, miningAreaId)
                     values (3102, 31,            2,    10,                1203);

insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (310201, 3102, 1202, 600.0);


-- Achievements - Neudralion - Quantity mining
insert into Achievement (id, title,               description)
                 values (40, 'Neudralion mining', 'Mine Neudralion');

insert into AchievementPredecessor (id, predecessorId, predecessorStep, successorId) values (4001, 3, 3, 40);

insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (4001, 40,            1,    10,                4,     50);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (40011, 4001, 4, 50);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (4002, 40,            2,    10,                4,     75);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (40021, 4002, 4, 100);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (4003, 40,            3,    10,                4,     150);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (40031, 4003, 4, 250);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (4004, 40,            4,    10,                4,     250);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (40041, 4004, 4, 1000);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (4005, 40,            5,    10,                4,     1000);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (40051, 4005, 4, 2500);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (4006, 40,            6,    10,                4,     2000);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount)              values (40061, 4006, 4, 10000);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (40062, 4006, 1301, 800.0);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (4007, 40,            7,    10,                4,     5000);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount)              values (40071, 4007, 4, 50000);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (40072, 4007, 1302, 800.0);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (4008, 40,            8,    10,                4,     9999);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount)              values (40081, 4008, 4, 100000);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (40082, 4008, 1302, 900.0);


-- Achievements - Neudralion - Mining score
insert into Achievement (id, title,                        description)
                 values (41, 'Improved Neudralion mining', 'Improve your mining efficiency for Neudralion ore');

insert into AchievementPredecessor (id, predecessorId, predecessorStep, successorId) values (4101, 40, 3, 41);

insert into AchievementStep (id,   achievementId, step, achievementPoints, miningAreaId)
                     values (4101, 41,            1,    10,                1302);

insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (410101, 4101, 1301, 350.0);


-- Achievements - Complatix - Quantity mining
insert into Achievement (id, title,              description)
                 values (50, 'Complatix mining', 'Mine Complatix');

insert into AchievementPredecessor (id, predecessorId, predecessorStep, successorId) values (5001, 3, 4, 50);

insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (5001, 50,            1,    10,                5,     50);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (50011, 5001, 5, 50);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (5002, 50,            2,    10,                5,     75);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (50021, 5002, 5, 100);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (5003, 50,            3,    10,                5,     150);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (50031, 5003, 5, 250);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (5004, 50,            4,    10,                5,     250);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (50041, 5004, 5, 1000);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (5005, 50,            5,    10,                5,     1000);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (50051, 5005, 5, 2500);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (5006, 50,            6,    10,                5,     2000);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount)              values (50061, 5006, 5, 10000);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (50062, 5006, 1401, 800.0);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (5007, 50,            7,    10,                5,     5000);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount)              values (50071, 5007, 5, 50000);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (50072, 5007, 1402, 800.0);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (5008, 50,            8,    10,                5,     9999);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount)              values (50081, 5008, 5, 100000);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (50082, 5008, 1402, 900.0);


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

insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (6001, 60,            1,    10,                6,     50);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (60011, 6001, 6, 50);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (6002, 60,            2,    10,                6,     75);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (60021, 6002, 6, 100);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (6003, 60,            3,    10,                6,     150);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (60031, 6003, 6, 250);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (6004, 60,            4,    10,                6,     250);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (60041, 6004, 6, 1000);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (6005, 60,            5,    10,                6,     1000);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (60051, 6005, 6, 2500);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (6006, 60,            6,    10,                6,     2000);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (60061, 6006, 6, 10000);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (60062, 6006, 1501, 800.0);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (6007, 60,            7,    10,                6,     5000);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (60071, 6007, 6, 50000);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (60072, 6007, 1501, 850.0);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (6008, 60,            8,    10,                6,     9999);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (60081, 6008, 6, 100000);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (60082, 6008, 1501, 900.0);


-- Achievements - Raxia - Quantity mining
insert into Achievement (id, title,          description)
                 values (70, 'Raxia mining', 'Mine Raxia');

insert into AchievementPredecessor (id, predecessorId, predecessorStep, successorId) values (7001, 3, 6, 70);

insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (7001, 70,            1,    10,                7,     50);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (70011, 7001, 7, 50);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (7002, 70,            2,    10,                7,     75);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (70021, 7002, 7, 100);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (7003, 70,            3,    10,                7,     150);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (70031, 7003, 7, 250);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (7004, 70,            4,    10,                7,     250);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (70041, 7004, 7, 1000);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (7005, 70,            5,    10,                7,     1000);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (70051, 7005, 7, 2500);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (7006, 70,            6,    10,                7,     2000);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (70061, 7006, 7, 10000);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (70062, 7006, 1601, 800.0);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (7007, 70,            7,    10,                7,     5000);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (70071, 7007, 7, 50000);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (70072, 7007, 1601, 850.0);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (7008, 70,            8,    10,                7,     9999);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (70081, 7008, 7, 100000);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (70082, 7008, 1601, 900.0);


-- Achievements - Dipolir - Quantity mining
insert into Achievement (id, title,            description)
                 values (80, 'Dipolir mining', 'Mine Dipolir');

insert into AchievementPredecessor (id, predecessorId, predecessorStep, successorId) values (8001, 3, 7, 80);

insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (8001, 80,            1,    10,                8,     50);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (80011, 8001, 8, 50);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (8002, 80,            2,    10,                8,     75);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (80021, 8002, 8, 100);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (8003, 80,            3,    10,                8,     150);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (80031, 8003, 8, 250);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (8004, 80,            4,    10,                8,     250);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (80041, 8004, 8, 1000);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (8005, 80,            5,    10,                8,     1000);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (80051, 8005, 8, 2500);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (8006, 80,            6,    10,                8,     2000);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (80061, 8006, 8, 10000);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (80062, 8006, 1701, 800.0);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (8007, 80,            7,    10,                8,     5000);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (80071, 8007, 8, 50000);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (80072, 8007, 1701, 850.0);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (8008, 80,            8,    10,                8,     9999);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (80081, 8008, 8, 100000);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (80082, 8008, 1701, 900.0);


-- Achievements - Asradon - Quantity mining
insert into Achievement (id, title,            description)
                 values (90, 'Asradon mining', 'Mine Asradon');

insert into AchievementPredecessor (id, predecessorId, predecessorStep, successorId) values (9001, 3, 8, 90);

insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (9001, 90,            1,    10,                9,     50);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (90011, 9001, 9, 50);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (9002, 90,            2,    10,                9,     75);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (90021, 9002, 9, 100);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (9003, 90,            3,    10,                9,     150);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (90031, 9003, 9, 250);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (9004, 90,            4,    10,                9,     250);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (90041, 9004, 9, 1000);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (9005, 90,            5,    10,                9,     1000);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (90051, 9005, 9, 2500);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (9006, 90,            6,    10,                9,     2000);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (90061, 9006, 9, 10000);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (90062, 9006, 1801, 800.0);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (9007, 90,            7,    10,                9,     5000);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (90071, 9007, 9, 50000);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (90072, 9007, 1801, 850.0);


insert into AchievementStep (id,   achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (9008, 90,            8,    10,                9,     9999);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (90081, 9008, 9, 100000);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (90082, 9008, 1801, 900.0);


-- Achievements - Baratiem - Quantity mining
insert into Achievement (id,  title,            description)
                 values (100, 'Baratiem mining', 'Mine Baratiem');

insert into AchievementPredecessor (id, predecessorId, predecessorStep, successorId) values (10001, 3, 9, 100);

insert into AchievementStep (id,    achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (10001, 100,           1,    10,                10,    50);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (100011, 10001, 10, 50);


insert into AchievementStep (id,    achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (10002, 100,           2,    10,                10,    75);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (100021, 10002, 10, 100);


insert into AchievementStep (id,    achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (10003, 100,           3,    10,                10,    150);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (100031, 10003, 10, 250);


insert into AchievementStep (id,    achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (10004, 100,           4,    10,                10,    250);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (100041, 10004, 10, 1000);


insert into AchievementStep (id,    achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (10005, 100,           5,    10,                10,    1000);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (100051, 10005, 10, 2500);


insert into AchievementStep (id,    achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (10006, 100,           6,    10,                10,    2000);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (100061, 10006, 10, 10000);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (100062, 10006, 1901, 800.0);


insert into AchievementStep (id,    achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (10007, 100,           7,    10,                10,    5000);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (100071, 10007, 10, 50000);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (100072, 10007, 1901, 850.0);


insert into AchievementStep (id,    achievementId, step, achievementPoints, oreId, maxOreReward)
                     values (10008, 100,           8,    10,                10,    9999);

insert into AchievementStepMiningTotalRequirement (id, achievementStepId, oreId, amount) values (100081, 10008, 10, 100000);
insert into AchievementStepMiningScoreRequirement (id, achievementStepId, miningAreaId, minimumScore) values (100082, 10008, 1901, 900.0);


-- Calculate the tier levels
update RobotPart
set tierId = 
(
select max(OrePriceAmount.oreId)
from OrePriceAmount
where OrePriceAmount.orePriceId = RobotPart.orePriceId
);
