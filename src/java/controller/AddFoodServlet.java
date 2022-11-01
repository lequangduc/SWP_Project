/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.FoodDAO;
import entity.Food;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author admin
 */
public class AddFoodServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddFoodServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddFoodServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
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
        FoodDAO pdao = new FoodDAO();

        String name = request.getParameter("name");
        String type = request.getParameter("type");
        String price = request.getParameter("price");
        String image = request.getParameter("image");
        String info = request.getParameter("info");

        Food p = null;
        try {
            p = new Food(name, Float.parseFloat(price), pdao.getFoodTypeId(type), info, image);
        } catch (SQLException ex) {
            Logger.getLogger(AddFoodServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        boolean added = false;
        try {
            added = pdao.addFood(p);
        } catch (SQLException ex) {
            Logger.getLogger(AddFoodServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        if (added) {
            request.setAttribute("type", null);
            request.getRequestDispatcher("./AdminPage/ListFood.jsp").forward(request, response);
        } else {
            request.setAttribute("errMessage", "Error add to database" + p);
            request.getRequestDispatcher("./AdminPage/AddFoodPage.jsp").forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
