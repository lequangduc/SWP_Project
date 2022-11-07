/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.sql.Blob;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import DAO.TableDAO;
import Context.DBContext;
import entity.Table;
import entity.TableDetail;
import entity.TableType;

/**
 *
 * @author Admin
 */

// @WebServlet(name = "uploadImage", urlPatterns = { "/uploadImage" })
// web servlet
@WebServlet(name = "TableMapServlet", urlPatterns = { "SWP_Project/TableMapServlet" })
@MultipartConfig(maxFileSize = 16177216) // 1.5mb
public class TableMapServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    // PrintWriter out;
    DBContext db = new DBContext();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

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
        if (request.getParameter("action").equals("viewTableMap")) {
            getTableMap(request, response);
            request.setAttribute("tableList", tableDetails);
            request.getRequestDispatcher("/AdminPage/tablesetting.jsp").forward(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    ArrayList<Table> tables = new TableDAO().getAllTable();
    ArrayList<TableType> tableTypes = new TableDAO().getAllTableType();
    ArrayList<TableDetail> tableDetails = new ArrayList<>();
    ArrayList<String> tableTypeNames = new TableServlet().getTableTypes(tableTypes);

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // out = response.getWriter();
        int result = 0;
        Part part = request.getPart("table-map");
        if (part == null) {
            tableDetails = new TableServlet().getTableList(tables, tableTypes);
            request.setAttribute("tableList", tableDetails);
            request.getRequestDispatcher("/AdminPage/tablesetting.jsp").forward(request, response);
        }
        if (part != null) {
            try {
                Connection con = db.getConnection();
                PreparedStatement ps = con.prepareStatement("insert into data(image) values(?)");
                InputStream is = part.getInputStream();
                ps.setBlob(1, is);
                result = ps.executeUpdate();
                if (result > 0) {
                    // response.sendRedirect("/AdminPage/tablesetting.jsp?message=Successfully+uploaded!");
                    request.setAttribute("message", "Successfully uploaded");
                    tableDetails = new TableServlet().getTableList(tables, tableTypes);
                    request.setAttribute("tableList", tableDetails);
                    request.getRequestDispatcher("/AdminPage/tablesetting.jsp").forward(request, response);
                } else {
                    response.sendRedirect("/AdminPage/tablesetting.jsp");
                }
            } catch (Exception e) {
                // out.println(e);
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

    // public void getTableMap()

    // display image table map from database
    public void getTableMap(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("image/jpeg");
        try {
            Connection con = db.getConnection();
            PreparedStatement ps = con.prepareStatement("select top 1 * from data order by id desc");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Blob b = rs.getBlob(2);
                byte barr[] = b.getBytes(1, (int) b.length());
                response.getOutputStream().write(barr);
            }
        } catch (Exception e) {
            // out.println(e);
        }
    }

}
