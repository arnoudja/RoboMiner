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

package nl.robominer.session;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import nl.robominer.entity.RobotPart;
import nl.robominer.entity.RobotPartType;

/**
 *
 * @author Arnoud Jagerman
 */
@Stateless
public class RobotPartFacade extends AbstractFacade<RobotPart> {
    @PersistenceContext(unitName = "RoboMinerWebPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public RobotPartFacade() {
        super(RobotPart.class);
    }

    public Map< RobotPartType, List<RobotPart> > findAllMapped() {
        
        List<RobotPart> robotPartList = findAll();
        
        Map< RobotPartType, List<RobotPart> > result = new HashMap<>();
        
        for (RobotPart robotPart : robotPartList) {
            
            List<RobotPart> typeList = result.get(robotPart.getRobotPartType());
            
            if (typeList == null) {
                
                typeList = new ArrayList<>();
                result.put(robotPart.getRobotPartType(), typeList);
            }
            
            typeList.add(robotPart);
        }
        
        return result;
    }

}
