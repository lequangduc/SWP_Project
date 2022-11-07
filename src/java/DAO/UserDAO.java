package DAO;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

import Context.DBContext;
import entity.Account;

public class UserDAO implements Serializable {

    public Account getAccount(String username, String password) throws SQLException {
        Account a = null;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String sql = "select * from account \n"
                    + "where username = ? and password = ?";
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            rs = ps.executeQuery();
            if (rs.next()) {
                int id = rs.getInt("account_id");
                String name = rs.getString("name").trim();
                String phone = rs.getString("phone").trim();
                String email = rs.getString("email").trim();
                String username1 = rs.getString("username").trim();
                String password1 = rs.getString("password").trim();
                int role_id = rs.getInt("role_id");

                a = new Account(id, name, phone, email, username, password, role_id);
            }
        } catch (Exception e) {
            System.out.println(e);
        } finally {
            rs.close();
            ps.close();
            conn.close();
        }
        return a;
    }

    public ArrayList<Account> getListAccounts() throws SQLException {
        ArrayList<Account> accounts = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String sql = "select * from account order by account_id";
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("account_id");
                String name = rs.getString("name").trim();
                String phone = rs.getString("phone").trim();
                String email = rs.getString("email").trim();
                String username = rs.getString("username").trim();
                String password = rs.getString("password").trim();
                int role_id = rs.getInt("role_id");

                accounts.add(new Account(id, name, phone, email, username, password, role_id));
            }
        } catch (Exception e) {
            System.out.println(e);
        } finally {
            // rs.close();
            // ps.close();
            // conn.close();
        }
        return accounts;
    }

    public void createAccount(Account account) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        // ResultSet rs = null;
        try {
            String sql = "insert into account values (?, ?, ? , ?, ?, ?, ?) ";
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, account.getAccount_id());
            ps.setString(2, account.getName());
            ps.setString(3, account.getPhone());
            ps.setString(4, account.getEmail());
            ps.setString(5, account.getUsername());
            ps.setString(6, account.getPassword());
            ps.setInt(7, account.getRole_id());

            ps.execute();
        } catch (Exception e) {
            System.out.println(e);
        } finally {
            ps.close();
            ps.close();
        }
    }

    public void deleteAccount(int id) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        // ResultSet rs = null;
        String sql = "delete from account where account_id =?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ps.execute();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            ps.close();
            conn.close();
        }
    }

    public void updateStudent(Account account) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        // ResultSet rs = null;

        try {
            String sql = "update account set name=?, phone=?, email=?, username=?, password=?, role_id=? where account_id=?";
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(7, account.getAccount_id());
            ps.setString(1, account.getName());
            ps.setString(2, account.getPhone());
            ps.setString(3, account.getEmail());
            ps.setString(4, account.getUsername());
            ps.setString(5, account.getPassword());
            ps.setInt(6, account.getRole_id());
            ps.execute();
        } catch (Exception e) {
            System.out.println(e);
        } finally {
            ps.close();
            ps.close();
        }
    }

    public Account checkduplicateUsername(String username) throws SQLException {
        Account a = null;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String sql = "select * from account where username = ?";
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            rs = ps.executeQuery();
            if (rs.next()) {
                String name = rs.getString("name").trim();
                String phone = rs.getString("phone").trim();
                String email = rs.getString("email").trim();
                String username1 = rs.getString("username").trim();
                String password = rs.getString("password").trim();
                int role_id = rs.getInt("role_id");

                a = new Account(name, phone, email, username1, password, role_id);
            }
        } catch (Exception e) {
            System.out.println(e);
        } finally {
            rs.close();
            ps.close();
            conn.close();
        }
        return a;
    }

    public int getAccountIDBy(String name) throws SQLException {

        Account a = null;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String query = "select account_id from account where name = ?";
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, name);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            System.out.println(e);
        } finally {
            rs.close();
            ps.close();
            conn.close();
        }
        return 0;
    }
}
