/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.UserDAO;
import DAO.ReservationDAO;
import DAO.TableReservationDAO;
import entity.Account;
import entity.Reservation;
import entity.Table;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.SQLException;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.text.ParseException;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;

// @WebServlet(name = "BookingServlet", urlPatterns = { "/BookingServlet" })
public class BookingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        // Lấy Đối tượng userLogin về = session
        Account acc = (Account) session.getAttribute("loggedAccount");

        // Check account có null ko
        // Nếu ko thì sẽ set tên và sdt của người đặt trên form
        if (acc != null) {
            request.setAttribute("name", acc.getName());
            request.setAttribute("phone", acc.getPhone());
        } else {
            request.setAttribute("LoginError", "Must login to book a table");

        }
        request.getRequestDispatcher("booking.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {

            ReservationDAO dao = new ReservationDAO();
            UserDAO aDao = new UserDAO();
            TableReservationDAO tDao = new TableReservationDAO();

            HttpSession session = request.getSession();
            Account acc = (Account) session.getAttribute("loggedAccount");

            // Check tk ko null
            if (acc != null) {
                // Lấy thông tin trên form
                String name = request.getParameter("name");
                String tableID = request.getParameter("table");

                // Chuyển đổi string date có dạng ở dưới thành date
                // Format phải đúng nếu ko sẽ báo lỗi
                SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm");
                String sdate = request.getParameter("date");
                Date date = sdf.parse(sdate);

                // Dùng hàm để check xem date mà mình đặt có lớn hơn hiện tại ko
                if (isGreatThanDateNow(date)) {
                    // Chuyển đổi date của java.util.date sang java.sql.Date
                    java.sql.Date sqlDate = new java.sql.Date(date.getTime());
                    System.out.println(sqlDate);

                    Reservation res = new Reservation(
                            autoIncreaseID(dao.getAllReservation()), Integer.parseInt(tableID),
                            acc.getAccount_id(),
                            sqlDate);
                    System.out.println(res.toString());
                    // Check thử việc thêm vào có bị lỗi ko
                    if (dao.checkAddFoodType(res)) {
                        // Sau khi đăt thành công thì sẽ chuyển đổi trạng thái của bàn rồi về lại trang
                        // home
                        tDao.updateTable(Integer.parseInt(tableID), "reserved");

                        ArrayList<Table> tables = tDao.getTables();
                        request.setAttribute("tablesTotal", tables.size());

                        int available = 0;
                        int reserved = 0;
                        int occupied = 0;
                        for (int i = 0; i < tables.size(); i++) {
                            if (tables.get(i).getStatus().equalsIgnoreCase("available")) {
                                available += 1;
                            }

                            if (tables.get(i).getStatus().equalsIgnoreCase("occupied")) {
                                occupied += 1;
                            }

                            if (tables.get(i).getStatus().equalsIgnoreCase("reserved")) {
                                reserved += 1;
                            }

                        }

                        request.setAttribute("availableTables", available);
                        request.setAttribute("reservedTables", reserved);
                        request.setAttribute("occupiedTables", occupied);
                        request.getRequestDispatcher("index.jsp").forward(request, response);
                    } else {
                        // response.sendRedirect("index.jsp");
                        System.out.println("Something wrong");
                    }
                } else // Nếu nhỏ hơn thì sẽ báo lỗi và về lại trang
                {
                    request.setAttribute("error", "Date Should Greater than Now!");
                    request.getRequestDispatcher("booking.jsp").forward(request, response);
                }

            } else { // Yêu cầu đăng nhập nếu như bấm đặt
                request.setAttribute("LoginError", "Login First!");
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }

        } catch (ParseException ex) {
            Logger.getLogger(BookingServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(BookingServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public boolean isGreatThanDateNow(Date date) {
        // Lấy thời gian hiện tại
        LocalDate now = LocalDate.now();
        ZoneId systemTimeZone = ZoneId.systemDefault();
        ZonedDateTime zonedDateTime = now.atStartOfDay(systemTimeZone);
        Date utilDate = Date.from(zonedDateTime.toInstant());

        Calendar cal1 = Calendar.getInstance();
        Calendar cal2 = Calendar.getInstance();
        cal1.setTime(utilDate);
        cal2.setTime(date);
        // check day của thời gian truyền có lớn hơn hôm nay
        return cal2.get(Calendar.DAY_OF_YEAR) > cal1.get(Calendar.DAY_OF_YEAR)
                && cal1.get(Calendar.YEAR) == cal2.get(Calendar.YEAR)
                && cal2.get(Calendar.HOUR_OF_DAY) > cal1.get(Calendar.HOUR_OF_DAY);

    }

    public int autoIncreaseID(ArrayList<Reservation> rl) {
        int id = 1000;
        for (int i = 0; i < rl.size(); i++) {
            if (id >= rl.get(i).getReservation_id()) {
                id += 1;
            }
        }
        return id;
    }

}
