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
import nl.robominer.entity.MiningArea;
import nl.robominer.entity.UserOreAsset;
import nl.robominer.session.UserOreAssetFacade;

/**
 * Base class for the RoboMiner servlets.
 * 
 * @author Arnoud Jagerman
 */
public abstract class RoboMinerServletBase extends HttpServlet {

    /**
     * The name used to store the user-id value in the session.
     */
    private static final String SESSION_USER_ID = "userId";

    /**
     * Bean to handle the user-assets transactions.
     */
    @EJB
    private UserAssets userAssets;

    /**
     * Bean to handle access to the ore-assets information for the logged-in
     * user in the database.
     */
    @EJB
    private UserOreAssetFacade userOreAssetFacade;

    /**
     * Handles the HTTP <code>GET</code> and <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    abstract void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

    /**
     * Retrieve the user-assets bean.
     *
     * @return The user-assets bean.
     */
    protected UserAssets getUserAssets() {
        return userAssets;
    }

    /**
     * Retrieve the user-id for the currently logged-in user.
     *
     * @param request The servlet request.
     * @return The user-id for the currently logged-in user.
     */
    protected int getUserId(HttpServletRequest request) {
        return (int)request.getSession().getAttribute(SESSION_USER_ID);
    }

    /**
     * Update the user-id for the currently logged-in user.
     *
     * @param request The servlet request.
     * @param userId The user-id for the currently logged-in user.
     */
    protected void setUserId(HttpServletRequest request, int userId) {
        request.getSession().setAttribute(SESSION_USER_ID, userId);
    }

    /**
     * Retrieve the id-value of a form-field, or 0 if not present.
     *
     * @param request The servlet request.
     * @param field The name of the form-field to retrieve the value for.
     * @return The id-value of the form-field specified, or 0 if not found.
     */
    protected int getItemId(HttpServletRequest request, String field) {

        String value = request.getParameter(field);
        return (value == null || value.isEmpty()) ? 0 : Integer.parseInt(value);
    }

    /**
     * Process all claimable mining results for the logged-in user and add the
     * ore-assets information for the user to the request.
     *
     * @param request The servlet request.
     * @throws ServletException when a problem occurred during the processing of
     * the claimable mining results.
     */
    protected void processAssets(HttpServletRequest request) throws ServletException {

        int userId = getUserId(request);

        try {
            userAssets.updateUserAssets(userId);
        }
        catch (IllegalStateException | SecurityException | HeuristicMixedException | HeuristicRollbackException | NotSupportedException | RollbackException | SystemException exc) {
            throw new ServletException(exc);
        }

        updateOreAssetsList(request, userId);
    }

    /**
     * If possible, subtracts the mining costs for the specified mining area
     * from the user-assets, updates the ore-assets information in the request
     * and returns true. Otherwise, returns false.
     *
     * @param request The servlet request.
     * @param miningArea The mining area to pay the mining costs for.
     * @throws ServletException when an unexpected problem occurred during the
     * subtracting of the mining costs.
     * @return true when the mining costs are subtracted successful, false when
     * the ore assets for the logged-in user aren't sufficient.
     */
    protected boolean payMiningCosts(HttpServletRequest request, MiningArea miningArea) throws ServletException {

        boolean result = false;

        int userId = getUserId(request);

        try {

            if (userAssets.payMiningCosts(userId, miningArea)) {

                result = true;

                updateOreAssetsList(request, userId);
            }
        }
        catch (IllegalStateException | SecurityException | HeuristicMixedException | HeuristicRollbackException | NotSupportedException | RollbackException | SystemException exc) {
            throw new ServletException(exc);
        }

        return result;
    }

    /**
     * If possible, subtracts the robot part costs for the specified robot part
     * from the user-assets, adds the robot part to the user assets, updates
     * the ore-assets information in the request and returns true. Otherwise,
     * returns false.
     *
     * @param request The servlet request.
     * @param robotPartId The id of the robot part to buy.
     * @throws ServletException when an unexpected problem occurred during the
     * buy process.
     * @return true when the transaction succeeded, false when the ore assets
     * for the logged-in user aren't sufficient.
     */
    protected boolean buyRobotPart(HttpServletRequest request, int robotPartId) throws ServletException {

        boolean result = false;

        int userId = getUserId(request);

        try {

            if (userAssets.buyRobotPart(userId, robotPartId)) {
                result = true;
            }

            updateOreAssetsList(request, userId);
        }
        catch (IllegalStateException | SecurityException | HeuristicMixedException | HeuristicRollbackException | NotSupportedException | RollbackException | SystemException exc) {
            throw new ServletException(exc);
        }

        return result;
    }

    /**
     * If possible, subtracts the specified robot part from the user assets,
     * adds the return-ore-price for the specified robot part to the user ore
     * assets, updates the ore-assets information in the request and returns
     * true. Otherwise, returns false.
     *
     * @param request The servlet request.
     * @param robotPartId The id of the robot part to sell.
     * @throws ServletException when an unexpected problem occurred during the
     * sell process.
     * @return true when the transaction succeeded, false when the robot part
     * assets for the logged-in user aren't sufficient.
     */
    protected boolean sellRobotPart(HttpServletRequest request, int robotPartId) throws ServletException {

        boolean result = false;

        int userId = getUserId(request);

        try {

            if (userAssets.sellRobotPart(userId, robotPartId)) {
                result = true;
            }

            updateOreAssetsList(request, userId);
        }
        catch (IllegalStateException | SecurityException | HeuristicMixedException | HeuristicRollbackException | NotSupportedException | RollbackException | SystemException exc) {
            throw new ServletException(exc);
        }

        return result;
    }

    /**
     * Updates the ore-assets information for the specified user in the request.
     *
     * @param request The servlet request.
     * @param userId The id of the user to update the ore-assets information for.
     */    
    private void updateOreAssetsList(HttpServletRequest request, int userId) {

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
