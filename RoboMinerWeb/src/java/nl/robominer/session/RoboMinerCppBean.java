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

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.PostConstruct;
import javax.ejb.Singleton;

/**
 *
 * @author Arnoud Jagerman
 */
@Singleton
public class RoboMinerCppBean {

    private boolean myIsInitialized;
    private String myBinaryLocation;
    
    @PostConstruct
    void init() {
        myIsInitialized = false;
        // TODO: Initialize binary with bean-settings instead of parameter
    }
    
    void init(String binaryLocation)
    {
        try {
            if (!myIsInitialized)
            {
                myBinaryLocation = binaryLocation;
            
                Process p = Runtime.getRuntime().exec("chmod 775 " + binaryLocation);
                p.waitFor();
                
                myIsInitialized = true;
            }
        } catch (IOException | InterruptedException ex) {
            Logger.getLogger(RoboMinerCppBean.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void verifyCode(String binaryLocation, long id) {
        try {
            init(binaryLocation);
            
            Process p = Runtime.getRuntime().exec(myBinaryLocation + " verify " + id);
            p.waitFor();
        } catch (IOException | InterruptedException ex) {
            Logger.getLogger(RoboMinerCppBean.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
