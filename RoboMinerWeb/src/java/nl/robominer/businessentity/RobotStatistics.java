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

package nl.robominer.businessentity;

import java.util.HashMap;
import java.util.Map;
import nl.robominer.entity.Ore;

/**
 *
 * @author Arnoud Jagerman
 */
public class RobotStatistics {

    public class OreAmount {

        private int amount;

        private int tax;

        public OreAmount(int amount, int tax) {
            this.amount = amount;
            this.tax = tax;
        }

        public int getAmount() {
            return amount;
        }

        public void increaseAmount(int amount) {
            this.amount += amount;
        }

        public int getTax() {
            return tax;
        }

        public void increaseTax(int tax) {
            this.tax += tax;
        }
    }

    private int runs;

    private Map<Ore, OreAmount> oreAmountMap;

    public RobotStatistics() {

        oreAmountMap = new HashMap<>();
    }

    public int getRuns() {
        return runs;
    }
    
    public void setRuns(int runs) {
        this.runs = runs;
    }

    public Map<Ore, OreAmount> getOreAmountMap() {
        return oreAmountMap;
    }

    public void addOre(Ore ore, int amount, int tax) {

        OreAmount oreAmount = oreAmountMap.get(ore);
        
        if (oreAmount == null) {

            oreAmountMap.put(ore, new OreAmount(amount, tax));
        }
        else {
            oreAmount.increaseAmount(amount);
            oreAmount.increaseTax(tax);
        }
    }
}
