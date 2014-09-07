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
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.transaction.HeuristicMixedException;
import javax.transaction.HeuristicRollbackException;
import javax.transaction.NotSupportedException;
import javax.transaction.RollbackException;
import javax.transaction.SystemException;
import nl.robominer.businessentity.UserAssets;
import nl.robominer.entity.UserOreAsset;
import nl.robominer.session.UserOreAssetFacade;

/**
 *
 * @author Arnoud Jagerman
 */
public abstract class RoboMinerServletBase extends HttpServlet {

    @EJB
    private UserAssets userAssets;

    @EJB
    private UserOreAssetFacade userOreAssetFacade;

    abstract void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

    protected UserAssets getUserAssets() {
        return userAssets;
    }

    protected int getItemId(HttpServletRequest request, String field) {
        
        String value = request.getParameter(field);
        return (value == null || value.isEmpty()) ? 0 : Integer.parseInt(value);
    }

    protected void processAssets(HttpServletRequest request) throws ServletException {
        
        int userId = (int) request.getSession().getAttribute("userId");

        try {
            userAssets.updateUserAssets(userId);
        }
        catch (IllegalStateException | SecurityException | HeuristicMixedException | HeuristicRollbackException | NotSupportedException | RollbackException | SystemException exc) {
            throw new ServletException(exc);
        }

        // Add the list of ore assets
        List<UserOreAsset> userOreAssetList = userOreAssetFacade.findByUsersId(userId);
        request.setAttribute("oreAssetList", userOreAssetList);
    }
    
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
