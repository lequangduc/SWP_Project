/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import Context.DBContext;
import entity.*;

/**
 *
 * @author Admin
 */
public class TableReservationDAO {
    public ArrayList<Table> getTables() {
        ArrayList<Table> tables = new ArrayList<>();
        try {
            Connection conn = new DBContext().getConnection();
            String sql = "SELECT * FROM tables";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int table_id = rs.getInt(1);
                String status = rs.getString(3);
                int type_id = rs.getInt(2);

                tables.add(new Table(table_id, type_id, status));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return tables;
    }

    public void createTable(int table_id, int type_id, String status) {
        try {
            Connection conn = new DBContext().getConnection();
            String sql = "INSERT INTO tables VALUES(?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, table_id);
            ps.setString(3, status);
            ps.setInt(2, type_id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateTable(int table_id, String status) {
        try {
            Connection conn = new DBContext().getConnection();
            String sql = "UPDATE tables SET status = ? WHERE table_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, table_id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public ArrayList<Table> getTablesBy(String type_ID) {
        String query = "  select * from tables where tabletype_id = ?;";
        ArrayList<Table> list = new ArrayList<Table>();
        try {
            Connection conn = new DBContext().getConnection();
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, type_ID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Table(rs.getInt(1), rs.getInt(2), rs.getString(3)));
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return list;
    }
}
