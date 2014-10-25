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
import java.util.Map.Entry;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import nl.robominer.entity.Ore;
import nl.robominer.entity.RobotPart;
import nl.robominer.entity.RobotPartType;
import nl.robominer.entity.UserOreAsset;
import nl.robominer.entity.Users;
import nl.robominer.session.OreFacade;
import nl.robominer.session.RobotPartFacade;
import nl.robominer.session.UserRobotPartAssetFacade;
import nl.robominer.session.UsersFacade;

/**
 * Servlet for handling shop requests.
 *
 * @author Arnoud Jagerman
 */
@WebServlet(name = "ShopServlet", urlPatterns = {"/shop"})
public class ShopServlet extends RoboMinerServletBase
{
    /**
     * The javascript view used for displaying the shop page.
     */
    private static final String JAVASCRIPT_VIEW = "/WEB-INF/view/shop.jsp";

    /**
     * The session attribute id for storing the selected category.
     */
    private static final String SESSION_CATEGORY_ID = "shop_categoryId";

    /**
     * Bean to handle the database actions for the user information.
     */
    @EJB
    private UsersFacade usersFacade;

    /**
     * Bean to handle the database actions for the robot parts.
     */
    @EJB
    private RobotPartFacade robotPartFacade;

    /**
     * Bean to handle the database actions for the ore names.
     */
    @EJB
    private OreFacade oreFacade;

    /**
     * Bean to handle the database actions for the user robot part assets data.
     */
    @EJB
    private UserRobotPartAssetFacade userRobotPartAssetFacade;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request  servlet request
     * @param response servlet response
     *
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void processRequest(HttpServletRequest request,
                                  HttpServletResponse response)
            throws ServletException, IOException
    {
        processAssets(request);

        // Process the buy or sell request
        processRequestedTransaction(request);

        // Retrieve the form values
        int selectedRobotPartTypeId = getItemId(request, "selectedRobotPartTypeId");
        int selectedTierId          = getItemId(request, "selectedTierId");

        Users user = usersFacade.findById(getUserId(request));

        if (selectedRobotPartTypeId <= 0 &&
            request.getSession().getAttribute(SESSION_CATEGORY_ID) != null)
        {
            selectedRobotPartTypeId = (int)request.getSession().getAttribute(
                    SESSION_CATEGORY_ID);
        }

        // Initially select the highest tier the user has ore for
        if (selectedTierId < 1)
        {
            for (Entry<Ore, UserOreAsset> userOreAssetMapEntry :
                    user.getUserOreAssetMap().entrySet())
            {
                if (userOreAssetMapEntry.getValue().getAmount() > 0 &&
                    userOreAssetMapEntry.getValue().getOre().getId() > selectedTierId)
                {
                    selectedTierId = userOreAssetMapEntry.getValue().getOre().getId();
                }
            }
        }

        // Add the user item
        request.setAttribute("user", user);

        // Add the robot parts
        Map< RobotPartType, List<RobotPart>> robotPartMap =
                robotPartFacade.findAllMapped();
        request.setAttribute("robotPartMap", robotPartMap);

        // Add the ore list
        List<Ore> oreList = oreFacade.findAll();
        request.setAttribute("oreList", oreList);

        // Add the previous selected part type and selection
        request.setAttribute("selectedRobotPartTypeId", selectedRobotPartTypeId);
        request.setAttribute("selectedTierId", selectedTierId);

        // Store the selected category in the session
        request.getSession().setAttribute(SESSION_CATEGORY_ID,
                                          selectedRobotPartTypeId);

        request.getRequestDispatcher(JAVASCRIPT_VIEW).forward(request, response);
    }

    /**
     * Process the buy or sell request, if present.
     *
     * @param request The servlet request data.
     */
    private void processRequestedTransaction(HttpServletRequest request)
    {
        int buyRobotPartId          = getItemId(request, "buyRobotPartId");
        int sellRobotPartId         = getItemId(request, "sellRobotPartId");

        Users user = usersFacade.findById(getUserId(request));

        // Process the buy or sell request
        if (buyRobotPartId > 0)
        {
            RobotPart robotPart = robotPartFacade.find(buyRobotPartId);
            user.buyRobotPart(robotPart);
            usersFacade.edit(user);
            updateOreAssetsList(request, user.getId());
        }
        else if (sellRobotPartId > 0)
        {
            RobotPart robotPart = robotPartFacade.find(sellRobotPartId);
            user.sellRobotPart(robotPart);
            usersFacade.edit(user);
            updateOreAssetsList(request, user.getId());
            userRobotPartAssetFacade.clearByUsersId(user.getId());
        }
    }
    
    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo()
    {
        return "Shopping servlet";
    }
}
