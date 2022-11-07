/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Context.DBContext;
import com.itextpdf.text.Anchor;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import entity.Food;
import entity.Reservation;
import entity.Reservation_details;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
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

    public static int nowReservation = -1;

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

    public boolean checkAddFoodType(Reservation re) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        int rs = 0;
        try {
            String sql = "INSERT INTO reservation values(?,?,?)";
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);

            ps.setInt(1, re.getTable_id());
            ps.setInt(2, re.getCustomer_id());
            ps.setDate(3, (java.sql.Date) re.getDateReservation());
            // ps.setInt(5, re.getNoPeople());

            rs = ps.executeUpdate();
            if (rs > 0) {
                return true;
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
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

                long diff = d2.getTime() - d1.getTime();// as given

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
            System.out.println(nowReservation);
            return s;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        } finally {
            rs.close();
            ps.close();
            conn.close();
        }
        return (long) -10000;
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

        int reservation = nowReservation;
        System.out.println(getReservationByID(reservation));
        return getReservationByID(reservation);

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


    public ArrayList<Reservation_details> getListDetail(int id) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        ArrayList<Reservation_details> list = new ArrayList<>();
        try {
            String sql = "select * from reservationDetail where reservation_id = ?";
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);

            rs = ps.executeQuery();
            while (rs.next()) {
                int iddetail = rs.getInt(1);
                int food_id = rs.getInt(2);
                int quantity = rs.getInt(3);
                Reservation_details res = new Reservation_details(iddetail, food_id, quantity);
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

    public float getTotalPrice(int id) throws SQLException {
        ArrayList<Reservation_details> list = getListDetail(id);
        float result = 0;
        for (Reservation_details detail : list) {
            Food fo = new FoodDAO().getFoodByID(detail.getFood_id());
            result += detail.getQuantity() * fo.getPrice();
        }
        return result;
    }

    public boolean createBill(int id) throws SQLException {
        Document document = new Document(PageSize.A4, 50, 50, 50, 50);

        try {

            // Tạo đối tượng PdfWriter
            PdfWriter.getInstance(document, new FileOutputStream("D:\\".concat("Bills\\"+id + ".pdf")));

            // Mở file để thực hiện ghi
            document.open();

            // Thêm nội dung sử dụng add function
            Paragraph centerAlignedParagraph = new Paragraph("Restaurant");
            centerAlignedParagraph.setAlignment(Element.ALIGN_CENTER);
            document.add(centerAlignedParagraph);
            centerAlignedParagraph = new Paragraph("Khu do thi FPT - Nam ky khoi nghia");
            centerAlignedParagraph.setAlignment(Element.ALIGN_CENTER);
            document.add(centerAlignedParagraph);
            centerAlignedParagraph = new Paragraph("----------------------------------");
            centerAlignedParagraph.setAlignment(Element.ALIGN_CENTER);
            document.add(centerAlignedParagraph);
            Paragraph leftAlignedParagraph = new Paragraph("Bill ID: " + "RES00" + id);
            leftAlignedParagraph.setAlignment(Element.ALIGN_LEFT);
            document.add(leftAlignedParagraph);
            leftAlignedParagraph = new Paragraph("Time Reservation : " + getReservationByID(id).getDateReservation());
            leftAlignedParagraph.setAlignment(Element.ALIGN_LEFT);
            document.add(leftAlignedParagraph);
            centerAlignedParagraph = new Paragraph("------------------------------------------------------");
            centerAlignedParagraph.setAlignment(Element.ALIGN_CENTER);
            document.add(centerAlignedParagraph);

            PdfPTable table = new PdfPTable(3); // Create 2 columns in table.

            // Create cells
            PdfPCell cell1 = new PdfPCell(new Paragraph("Food"));
            PdfPCell cell2 = new PdfPCell(new Paragraph("Quantity"));
            PdfPCell cell3 = new PdfPCell(new Paragraph("Price"));
            table.addCell(cell1);
            table.addCell(cell2);
            table.addCell(cell3);
            ArrayList<Reservation_details> list = getListDetail(id);
            for (int i = 0; i < list.size(); i++) {
                Food fo = new FoodDAO().getFoodByID(list.get(i).getFood_id());
                PdfPCell cell4 = new PdfPCell(new Paragraph(fo.getName()));
                PdfPCell cell5 = new PdfPCell(new Paragraph("" + list.get(i).getQuantity()));
                PdfPCell cell6 = new PdfPCell(new Paragraph("" + fo.getPrice() * list.get(i).getQuantity()));
                // Add cells in table
                table.addCell(cell4);
                table.addCell(cell5);
                table.addCell(cell6);
            }
            // Add table in document
            document.add(table);
            Paragraph leftFooterAlignedParagraph = new Paragraph("Total Price : " + getTotalPrice(id));
            leftFooterAlignedParagraph.setAlignment(Element.ALIGN_LEFT);
            document.add(leftFooterAlignedParagraph);
            Paragraph centerFooterAlignedParagraph = new Paragraph("----------------------------------");
            centerFooterAlignedParagraph.setAlignment(Element.ALIGN_CENTER);
            document.add(centerFooterAlignedParagraph);
            centerFooterAlignedParagraph = new Paragraph("Thanks you");
            centerFooterAlignedParagraph.setAlignment(Element.ALIGN_CENTER);
            document.add(centerFooterAlignedParagraph);
            centerFooterAlignedParagraph = new Paragraph("See you again");
            centerFooterAlignedParagraph.setAlignment(Element.ALIGN_CENTER);
            document.add(centerFooterAlignedParagraph);

            // Đóng File
            document.close();
            System.out.println("Write file succes!");
            return true;
        } catch (FileNotFoundException | DocumentException e) {
            e.printStackTrace();
        }
        return false;
    }
    public boolean addGuestReservation(int id,int cusid) throws SQLException{
        Connection conn = null;
        PreparedStatement ps = null;
        int rs = 0;
        String now = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());
        try {
            String sql = "INSERT INTO reservation values(?,?,GETDATE())";
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ps.setInt(2, cusid);
            
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
    public ArrayList<Reservation> getAllReservation() {
        String sql = "Select * from Reservation";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        ArrayList<Reservation> list = new ArrayList<Reservation>();
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Reservation(
                        rs.getInt(1), rs.getInt(2),
                        rs.getInt(3), rs.getDate(4),
                        rs.getInt(5)));
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public ArrayList<Reservation> getCusReservation(int id) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql = "Select * from Reservation where customer_id = ?";
        ArrayList<Reservation> list = new ArrayList<>();
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Reservation(
                        rs.getInt(1), rs.getInt(2),
                        rs.getInt(3), rs.getDate(4)));
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public void DeleteReseravation(int id) {
        String query = "delete from reservation where reservation_id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

    }

}
