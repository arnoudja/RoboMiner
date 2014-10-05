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

import nl.robominer.entity.MiningQueue;

/**
 *
 * @author Arnoud Jagerman
 */
public class MiningQueueItem {

    public enum EMiningQueueItemStatus {
        MINING("Mining"),
        RECHARGING("Recharging"),
        QUEUED("Queued"),
        UPDATING("Updating");

        private final String description;

        private EMiningQueueItemStatus(String description) {
            this.description = description;
        }

        public String getDescription() {
            return description;
        }

        public boolean isQueued() {
            return this == QUEUED;
        }
    }

    private final MiningQueue miningQueue;
    private final EMiningQueueItemStatus itemStatus;
    private final long timeLeft;
    private final boolean selected;

    public MiningQueueItem(MiningQueue miningQueue, EMiningQueueItemStatus itemStatus, long timeLeft, boolean selected) {
        
        this.miningQueue        = miningQueue;
        this.itemStatus         = itemStatus;
        this.timeLeft           = timeLeft;
        this.selected           = selected;
    }

    public MiningQueue getMiningQueue() {
        
        return miningQueue;
    }

    public EMiningQueueItemStatus getItemStatus() {
        
        return itemStatus;
    }

    public long getTimeLeft() {
        
        return timeLeft;
    }

    public boolean isSelected() {
        return selected;
    }
}
