package DAO;

import Context.DBContext;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import entity.Role;

public class RolesDAO implements Serializable {
    public ArrayList<Role> getListRoles() throws SQLException {
        ArrayList<Role> roles = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String sql = "select * from roles order by role_id";
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("role_id");
                String name = rs.getString("role").trim();
                roles.add(new Role(id, name));
            }
        } catch (Exception e) {
            System.out.println(e);
        } finally {
            ps.close();
            conn.close();
        }
        return roles;
    }
}
