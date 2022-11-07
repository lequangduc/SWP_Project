/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.FoodDAO;
import DAO.ReservationDAO;
import entity.Food;
import entity.FoodType;
import entity.Reservation_details;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author admin
 */
public class ManageFood extends HttpServlet {

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
            out.println("<title>Servlet ManageFood</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManageFood at " + request.getContextPath() + "</h1>");
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
        FoodDAO pdao = new FoodDAO();
        String link = request.getParameter("link");
        String type = request.getParameter("type");
        if (link != null) {
            request.getRequestDispatcher("./AdminPage/" + link).forward(request, response);
        } else {
            
            String id = request.getParameter("id");
            
            if (type.equals("deletetypefood")) {
                String idtype = request.getParameter("idtype");
                
                try {
                    if (pdao.countDish(Integer.parseInt(idtype)) > 0) {
                        request.setAttribute("Status", "Update Failed");
                        
                    } else {
                        boolean deleted = pdao.deleteFoodType(Integer.parseInt(idtype));
                        if (deleted) {
                            request.setAttribute("Status", "Delete Successful");
                        } else {
                            request.setAttribute("Status", "Delete Failed");
                        }
                    }
                    
                } catch (SQLException ex) {
                    Logger.getLogger(ManageFood.class.getName()).log(Level.SEVERE, null, ex);
                }
                
            }
            
            
            
            if ("all".equals(type)) {
                request.setAttribute("type", null);
            } else {
                try {
                    request.setAttribute("type", pdao.getFoodTypeId(type));
                } catch (SQLException ex) {
                    Logger.getLogger(ManageFood.class.getName()).log(Level.SEVERE, null, ex);
                }
                
            }
            
            
            request.getRequestDispatcher("ManageFood?link=ListFood.jsp").forward(request, response);
        }
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
        FoodDAO dao = new FoodDAO();
        String action = request.getParameter("action");
        switch (action) {
            case "updatefood":
                int id = Integer.parseInt(request.getParameter("idfood"));
                String name = request.getParameter("name");
                int type = 0;
                 {
                    try {
                        type = dao.getFoodTypeId(request.getParameter("type"));
                    } catch (SQLException ex) {
                        Logger.getLogger(ManageFood.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
                float price = Float.parseFloat(request.getParameter("price"));
                String info = request.getParameter("info");
                String image = request.getParameter("image");
                Food food = new Food(id, name, price, type, info, image);
                 {
                    try {
                        boolean b = dao.updateFood(food);
                        if (b) {
                            request.setAttribute("Status", "Update Successful");
                        } else {
                            request.setAttribute("Status", "Update Failed");
                        }
                        
                    } catch (SQLException ex) {
                        Logger.getLogger(ManageFood.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    request.getRequestDispatcher("./AdminPage/ListFood.jsp").forward(request, response);
                }
                break;
            case "updatetypefood":
                String typeid = request.getParameter("idfoodtype");
                String typename = request.getParameter("foodtypename");
                FoodType ft = new FoodType(Integer.parseInt(typeid), typename);
                boolean boo;
                try {
                    boo = dao.updateFoodType(ft);
                    if (boo) {
                        request.setAttribute("Status", "Update Successful");
                    } else {
                        request.setAttribute("Status", "Update Failed");
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(ManageFood.class.getName()).log(Level.SEVERE, null, ex);
                }
                request.getRequestDispatcher("./AdminPage/ListFoodType.jsp").forward(request, response);
                break;
            
            case "addtype":
                String nametype = request.getParameter("typename");
                boolean added;
                try {
                    added = dao.addFoodType(nametype);
                    if (added) {
                        request.setAttribute("Status", "Add Successful");
                    } else {
                        request.setAttribute("Status", "Add Failed");
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(ManageFood.class.getName()).log(Level.SEVERE, null, ex);
                }
                request.getRequestDispatcher("AdminPage/ListFoodType.jsp").forward(request, response);
                ;
                break;
            
            default: {
                try {
                    throw new Exception();
                } catch (Exception ex) {
                    Logger.getLogger(ManageFood.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
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
