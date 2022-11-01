/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.TableDAO;
import entity.Table;
import entity.TableDetail;
import entity.TableType;

/**
 *
 * @author Admin
 */
public class TableServlet extends HttpServlet {

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
            out.println("<title>Servlet TableServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet TableServlet at " + request.getContextPath() + "</h1>");
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
    ArrayList<Table> tables = new TableDAO().getAllTable();
    ArrayList<TableType> tableTypes = new TableDAO().getAllTableType();
    ArrayList<TableDetail> tableDetails = new ArrayList<>();
    ArrayList<String> tableTypeNames = getTableTypes(tableTypes);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action.equals("managetablelist")) {
            // for (Table table : tables) {
            // for (TableType tableType : tableTypes) {
            // if (table.getTabletypeID() == tableType.getTabletypeID()) {
            // tableDetails.add(new TableDetail(table.getTableID(), table.getStatus(),
            // tableType.getTabletypeName(), tableType.getCapacity()));
            // }
            // }
            // }
            // add typename
            // for (TableType tableType : tableTypes) {
            // tableTypeNames.add(tableType.getTabletypeName());
            // }
            tableDetails = getTableList(tables, tableTypes);
            request.setAttribute("tableTypeName", tableTypeNames);
            request.setAttribute("tableList", tableDetails);
            request.getRequestDispatcher("/AdminPage/tablelist.jsp").forward(request, response);
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
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action.equals("searchtable")) {
            String status = request.getParameter("status_search");
            String type = request.getParameter("type_search");
            ArrayList<TableDetail> tableDetailsSearch = new ArrayList<>();
            if (status.equals("all") && type.equals("all")) {
                tableDetailsSearch = getTableList(tables, tableTypes);
            } else if (!status.equals("all") && type.equals("all")) {
                for (TableDetail tableDetail : tableDetails) {
                    if (tableDetail.getStatus().equals(status)) {
                        tableDetailsSearch.add(tableDetail);
                    }
                }
            } else if (status.equals("all") && !type.equals("all")) {
                for (TableDetail tableDetail : tableDetails) {
                    if (tableDetail.getType().equals(type)) {
                        tableDetailsSearch.add(tableDetail);
                    }
                }
            } else {
                for (TableDetail tableDetail : tableDetails) {
                    if (tableDetail.getStatus().equals(status) && tableDetail.getType().equals(type)) {
                        tableDetailsSearch.add(tableDetail);
                    }
                }
            }
            request.setAttribute("tableTypeName", tableTypeNames);
            request.setAttribute("tableList", tableDetailsSearch);
            request.getRequestDispatcher("/AdminPage/tablelist.jsp").forward(request, response);

        } else if (action.equals("addtable")) {
            String status = request.getParameter("status_add");
            String type = request.getParameter("type_add");
            // set quantity throw type T14->14
            int quantity = Integer.parseInt(type.substring(1));
            // serach typeID throw type T14->14
            int typeID = 0;
            for (TableType tableType : tableTypes) {
                if (tableType.getTabletypeName().equals(type)) {
                    typeID = tableType.getTabletypeID();
                }
            }
            // add table
            new TableDAO().addTable(typeID, status);

            tableDetails = getTableList(new TableDAO().getAllTable(), new TableDAO().getAllTableType());
            request.setAttribute("tableTypeName", tableTypeNames);
            request.setAttribute("tableList", tableDetails);
            request.getRequestDispatcher("/AdminPage/tablelist.jsp").forward(request, response);

        } else if (action.equals("updatetable")) {
            String id = request.getParameter("idtable_makeupdate");
            String status = request.getParameter("status_update");
            String type = request.getParameter("type_update");
            // get tabletypeID throw type T14->14
            int typeID = 0;
            for (TableType tableType : tableTypes) {
                if (tableType.getTabletypeName().equals(type)) {
                    typeID = tableType.getTabletypeID();
                }
            }
            // update table
            new TableDAO().updateTable(Integer.parseInt(id), typeID, status);

            tableDetails = getTableList(new TableDAO().getAllTable(), new TableDAO().getAllTableType());
            request.setAttribute("tableTypeName", tableTypeNames);
            request.setAttribute("tableList", tableDetails);
            request.getRequestDispatcher("/AdminPage/tablelist.jsp").forward(request, response);
            // request.getRequestDispatcher("/AdminPage/test.jsp").forward(request,
            // response);
        } else if (action.equals("deletetable")) {
            String id = request.getParameter("idtable_makedelete");
            // delete table
            new TableDAO().deleteTable(Integer.parseInt(id));

            tableDetails = getTableList(new TableDAO().getAllTable(), new TableDAO().getAllTableType());
            request.setAttribute("tableTypeName", tableTypeNames);
            request.setAttribute("tableList", tableDetails);
            request.getRequestDispatcher("/AdminPage/tablelist.jsp").forward(request, response);
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

    // get table deatail

    public ArrayList<TableDetail> getTableList(ArrayList<Table> tables, ArrayList<TableType> tableTypes) {
        ArrayList<TableDetail> tableDetails = new ArrayList<>();
        for (Table table : tables) {
            for (TableType tableType : tableTypes) {
                if (table.getTabletypeID() == tableType.getTabletypeID()) {
                    tableDetails.add(new TableDetail(table.getTableID(), table.getStatus(),
                            tableType.getTabletypeName(), tableType.getCapacity()));
                }
            }
        }
        return tableDetails;
    }

    public ArrayList<String> getTableTypes(ArrayList<TableType> tableTypes) {
        ArrayList<String> tableTypeNames = new ArrayList<>();
        for (TableType tableType : tableTypes) {
            tableTypeNames.add(tableType.getTabletypeName());
        }
        return tableTypeNames;
    }

}
