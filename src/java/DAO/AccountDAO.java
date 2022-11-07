/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

import DBContext.DBContext;
import entity.Account;

/**
 *
 * @author LENOVO
 */
public class AccountDAO implements Serializable {

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
                switch (role_id) {
                    case 1:
                        accounts.add(new Account(id, name, phone, email, username, password, "Manager"));
                        break;
                    case 2:
                        accounts.add(new Account(id, name, phone, email, username, password, "Cashier"));
                        break;
                    case 3:
                        accounts.add(new Account(id, name, phone, email, username, password, "Customer"));
                        break;
                    case 4:
                        accounts.add(new Account(id, name, phone, email, username, password, "Kitchen staff"));
                        break;
                    default:
                        break;
                }
                // accounts.add(new Account(id, name, phone, email, username, password,
                // role_id));
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
            String sql = "insert into account values (?, ? , ?, ?, ?, ?) ";
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
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

    public void updateAccount(int id, String username, String password, String email, String phone, String name)
            throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        // ResultSet rs = null;

        try {
            String sql = "update account set name=?, phone=?, email=?, username=?, password=? where account_id=?";
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(6, id);
            ps.setString(1, name);
            ps.setString(2, phone);
            ps.setString(3, email);
            ps.setString(4, username);
            ps.setString(5, password);
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
    public Account getAccountByID(int iduser) throws SQLException{
         Account a = null;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String sql = "select * from account \n"
                    + "where account_id = ?";
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, iduser);
            rs = ps.executeQuery();
            if (rs.next()) {
                int id = rs.getInt("account_id");
                String name = rs.getString("name").trim();
                String phone = rs.getString("phone").trim();
                String email = rs.getString("email").trim();
                String username = rs.getString("username").trim();
                String password = rs.getString("password").trim();
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
}
