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

package nl.robominer.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.transaction.HeuristicMixedException;
import javax.transaction.HeuristicRollbackException;
import javax.transaction.NotSupportedException;
import javax.transaction.RollbackException;
import javax.transaction.SystemException;
import nl.robominer.businessentity.UserAssets;
import nl.robominer.entity.RobotPart;
import nl.robominer.entity.RobotPartType;
import nl.robominer.entity.Users;
import nl.robominer.session.RobotPartFacade;
import nl.robominer.session.UsersFacade;

/**
 *
 * @author Arnoud Jagerman
 */
@WebServlet(name = "ShopServlet", urlPatterns = {"/shop"})
public class ShopServlet extends RoboMinerServletBase {

    @EJB
    private UsersFacade usersFacade;
    
    @EJB
    private RobotPartFacade robotPartFacade;
    
    @EJB
    private UserAssets userAssets;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int userId = (int) request.getSession().getAttribute("userId");

        try {
            userAssets.updateUserAssets(userId);
        }
        catch (IllegalStateException | SecurityException | HeuristicMixedException | HeuristicRollbackException | NotSupportedException | RollbackException | SystemException exc) {
            throw new ServletException(exc);
        }

        int buyRobotPartId = getItemId(request, "buyRobotPartId");
        int selectedRobotPartTypeId = getItemId(request, "selectedRobotPartTypeId");

        if (buyRobotPartId > 0) {
            
            try {
                userAssets.buyRobotPart(userId, buyRobotPartId);
            }
            catch (IllegalStateException | SecurityException | HeuristicMixedException | HeuristicRollbackException | NotSupportedException | RollbackException | SystemException exc) {
                throw new ServletException(exc);
            }
        }
        
        // Add the user item
        Users user = usersFacade.findById(userId);
        request.setAttribute("user", user);
        
        Map< RobotPartType, List<RobotPart> > robotPartMap = robotPartFacade.findAllMapped();
        request.setAttribute("robotPartMap", robotPartMap);
        
        // Add the previous selected part type selection
        request.setAttribute("selectedRobotPartTypeId", selectedRobotPartTypeId);
        
        request.getRequestDispatcher("/WEB-INF/view/shop.jsp").forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Shopping servlet";
    }

}
