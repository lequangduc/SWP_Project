package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import DBContext.DBContext;
import entity.Tables;

public class TableDAO {
    
    public ArrayList<Tables> getTables() {
        ArrayList<Tables> tables = new ArrayList<>();
        try {
            Connection conn = new DBContext().getConnection();
            String sql = "SELECT * FROM tables";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int table_id = rs.getInt("table_id");
                String status = rs.getString("status");
                int capacity = rs.getInt("capacity");
                
                tables.add(new Tables(table_id, status, capacity));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return tables;
    }

    public void createTable(int table_id, String status, int capacity) {
        try {
            Connection conn = new DBContext().getConnection();
            String sql = "INSERT INTO tables VALUES(?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, table_id);
            ps.setString(2, status);
            ps.setInt(3, capacity);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public void updateTable(int table_id, String status, int capacity) {
        try {
            Connection conn = new DBContext().getConnection();
            String sql = "UPDATE tables SET status = ?, capacity = ? WHERE table_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, capacity);
            ps.setInt(3, table_id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
