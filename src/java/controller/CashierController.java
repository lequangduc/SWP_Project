/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.AccountDAO;
import DAO.ReservationDAO;
import entity.Account;
import entity.Reservation_details;
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
public class CashierController extends HttpServlet {

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
            out.println("<title>Servlet CashierController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CashierController at " + request.getContextPath() + "</h1>");
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
        String setstatus = request.getParameter("setstatus");
        String id = request.getParameter("id");
        String idbill = request.getParameter("idbill");
        String action = request.getParameter("action");
        if (action != null) {
            if (action.equals("bill")) {
                try {
                    boolean boo = new ReservationDAO().createBill(Integer.parseInt(idbill),Integer.parseInt(id));
                    boolean bo = new ReservationDAO().setStatus("available", Integer.parseInt(id));

                } catch (SQLException ex) {
                    Logger.getLogger(CashierController.class.getName()).log(Level.SEVERE, null, ex);
                }
            }else if(action.equals("addreservation")){
                try {
                    Account account = new AccountDAO().getAccount("guest", "guest");
                    int tableid = Integer.parseInt(id);
                    boolean b1 = new ReservationDAO().addGuestReservation(tableid,account.getAccount_id());
                    boolean b2 = new ReservationDAO().setStatus("occupied",Integer.parseInt(id) );
                } catch (SQLException ex) {
                    Logger.getLogger(CashierController.class.getName()).log(Level.SEVERE, null, ex);
                }
                
            
            }
            request.getRequestDispatcher("./TableReservationDetails.jsp?id=".concat(id)).forward(request, response);
        } else if (setstatus != null) {
            String link = "./TableReservationDetails.jsp?id=" + id;
            int idstatus = Integer.parseInt(id);
            try {
                boolean b = new ReservationDAO().setStatus(setstatus, idstatus);
                if (b) {

                    request.getRequestDispatcher(link).forward(request, response);
                } else {
                    request.setAttribute("errMessage", "Error Update Status");
                    request.getRequestDispatcher(link).forward(request, response);
                }
            } catch (SQLException ex) {
                Logger.getLogger(CashierController.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            request.setAttribute("errMessage", "Error Update Status");
            request.getRequestDispatcher("./TableReservationDetails.jsp?id=".concat(id)).forward(request, response);
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
        String action = request.getParameter("action");
        String id = request.getParameter("id");
        switch (action) {
            case "addneworder":
                String idorder = request.getParameter("idorder");
                String foodid = request.getParameter("food");
                String quantity = request.getParameter("quantity");
//                try ( PrintWriter out = response.getWriter()) {
//
//                    out.println(idorder);
//                    out.println(foodid);
//                    out.println(foodid);
//                }
                Reservation_details res = new Reservation_details(Integer.parseInt(idorder), Integer.parseInt(foodid), Integer.parseInt(quantity));
                boolean b;
                try {
                    b = new ReservationDAO().addOrder(res);
                    if (b) {
                        request.getRequestDispatcher("./TableReservationDetails.jsp?id=".concat(id)).forward(request, response);
                    } else {

                        request.getRequestDispatcher("./TableReservationDetails.jsp?id=".concat(id)).forward(request, response);
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(ManageFood.class.getName()).log(Level.SEVERE, null, ex);
                }

                break;
            default:
                throw new AssertionError();
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
