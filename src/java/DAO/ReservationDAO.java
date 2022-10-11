/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Context.DBContext;
import entity.Reservation;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author admin
 */
public class ReservationDAO {
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
}
