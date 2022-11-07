/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;


import DBContext.DBContext;
import entity.Reservation;
import entity.Reservation_details;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.concurrent.TimeUnit;

/**
 *
 * @author admin
 */
public class ReservationDAO {

    public static int nowReservation = 0;

    public boolean addFoodType(Reservation re) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        int rs = 0;
        try {
            String sql = "INSERT INTO reservation values(?,?,?)";
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, re.getTable_id());
            rs = ps.executeUpdate();
            if (rs > 0) {
                return true;
            }
        } catch (Exception e) {
            System.out.println(e);
        } finally {

            ps.close();
            conn.close();
        }
        return false;
    }

    public String getStatus(int id) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            String sql = "SELECT * FROM tables WHERE table_id = ?";
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getString(3);
            }
        } catch (Exception e) {
            System.out.println(e);
        } finally {
            rs.close();
            ps.close();
            conn.close();
        }
        return null;
    }

    public String getNextReservationInfo(int id) throws SQLException {
        long seconds = NextReservation(id);

        if (seconds > 0) {
            long S = seconds % 60;
            long H = seconds / 60;
            long M = H % 60;
            H = H / 60;
            long D = H / 24;
            H = H % 24;
            return D + ":" + H + ":" + M + ":" + S;
        } else {
            return "No Info";
        }

    }

     public Long NextReservation(int id) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String timecompare = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());
        ArrayList<String> al = new ArrayList<>();
        ArrayList<Integer> idReservation = new ArrayList<>();
        ArrayList<Long> listhours = new ArrayList<>();
        try {
            String sql = "SELECT * FROM reservation WHERE table_id = ?";
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            while (rs.next()) {
                int resid = rs.getInt(1);
                String dateStart = rs.getString(4);

                String dateStop = timecompare;

                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

                java.util.Date d1 = null;
                java.util.Date d2 = null;
                try {
                    d1 = format.parse(dateStop);
                    d2 = format.parse(dateStart);
                } catch (ParseException e) {
                    e.printStackTrace();
                }

                long diff = d2.getTime() - d1.getTime();//as given

                long seconds = TimeUnit.MILLISECONDS.toSeconds(diff);
                long minutes = TimeUnit.MILLISECONDS.toMinutes(diff) % 60;
                long hours = TimeUnit.MILLISECONDS.toHours(diff) % 24;
                long days = TimeUnit.MILLISECONDS.toDays(diff);
                al.add(days + ":" + hours + ":" + minutes + ":" + seconds);
                idReservation.add(resid);
            }
            for (String diff : al) {
                String i = diff.split(":")[3];
                long hours = Long.parseLong(i);
                listhours.add(hours);
            }
            Long s = Collections.max(listhours);
            int index = listhours.indexOf(s);
            nowReservation = idReservation.get(index);
            return s;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        } finally {
            rs.close();
            ps.close();
            conn.close();
        }
        return null;
    }

    public boolean setStatus(String status, int id) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        int rs = 0;
        try {

            String sql = "UPDATE tables SET status = ? WHERE table_id = ?";
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, id);
            rs = ps.executeUpdate();
            while (rs > 0) {
                return true;
            }
        } catch (Exception e) {
        } finally {

            ps.close();
            conn.close();
        }
        return false;

    }

    public Reservation getReservationByID(int id) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            String sql = "SELECT * FROM reservation where reservation_id = ?";
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                int reservation_id = rs.getInt(1);
                int table_id = rs.getInt(2);
                int customer_id = rs.getInt(3);
                Date dateReservation = rs.getDate(4);
                Reservation res = new Reservation(reservation_id, table_id, customer_id, dateReservation);
                return res;
            }

        } catch (Exception e) {
            System.out.println(e);
        } finally {
            rs.close();
            ps.close();
            conn.close();
        }
        return null;

    }

    public Reservation getReservation(int id) throws SQLException {

        long seconds = NextReservation(id);
        if (seconds < 1800) {
            int reservation = nowReservation;
            return getReservationByID(reservation);
        }
        return null;
    }
    public ArrayList<Reservation_details> getReservationDetailByID(int id) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        ArrayList<Reservation_details> list = new ArrayList<>();
        try {

            String sql = "select * from reservationDetail where reservation_id =?";
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            while (rs.next()) {
                int reservation_id = rs.getInt(1);
                int food_id = rs.getInt(2);
                int quantity = rs.getInt(3);
                Reservation_details res = new Reservation_details(reservation_id,food_id,quantity);
                list.add(res);
            }
            return list;

        } catch (Exception e) {
            System.out.println(e);
        } finally {
            rs.close();
            ps.close();
            conn.close();
        }
        return null;

    }
    public boolean addOrder(Reservation_details re) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        int rs = 0;
        try {
            String sql = "INSERT INTO reservationDetail values(?,?,?)";
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, re.getReservation_id());
            ps.setInt(2, re.getFood_id());
            ps.setInt(3, re.getQuantity());
            rs = ps.executeUpdate();
            if (rs > 0) {
                return true;
            }
        } catch (Exception e) {
            System.out.println(e);
        } finally {

            ps.close();
            conn.close();
        }
        return false;
    }

}
