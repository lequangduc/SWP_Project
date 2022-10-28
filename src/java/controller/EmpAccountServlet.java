/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.AccountDAO;
import entity.Account;

/**
 *
 * @author LENOVO
 */
public class EmpAccountServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EmpAccountServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EmpAccountServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the
    // + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        AccountDAO list = new AccountDAO();
        try {
            list.deleteAccount(id);
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        request.getRequestDispatcher("AdminPage/AccountList.jsp").forward(request, response);

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("userName");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String name = request.getParameter("name");
        int roleid = Integer.parseInt(request.getParameter("roles"));

        AccountDAO dao = new AccountDAO();
        Account b = null;
        if (username == "admin") {
            request.setAttribute("RegError", "*Username can't be admin");
            request.getRequestDispatcher("AdminPage/CreateAccount.jsp").forward(request, response);
            return;
        }
        try {
            b = dao.checkduplicateUsername(username);
        } catch (SQLException ex) {
        }
        if (b != null) {
            request.setAttribute("addErr", "*username is already exist");
            request.getRequestDispatcher("AdminPage/CreateAccount.jsp")
                    .forward(request, response);
            return;
        } else {
            Account newaccount = new Account(name, phone, email, username, password, roleid);
            try {
                dao.createAccount(newaccount);
            } catch (SQLException ex) {
            }
            Account a = null;

            try {
                a = dao.getAccount(username, password);
            } catch (SQLException ex) {
            }
            if (a == null) {
                request.setAttribute("addErr", "*Add fail");
                request.getRequestDispatcher("AdminPage/CreateAccount.jsp")
                        .forward(request, response);
            } else {
                request.setAttribute("addErr", "*Add success");
                request.getRequestDispatcher("AdminPage/CreateAccount.jsp")
                        .forward(request, response);
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
