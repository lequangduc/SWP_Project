/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

import DAO.AccountDAO;
import DAO.RolesDAO;
import entity.Account;
import entity.Role;

/**
 *
 * @author LENOVO
 */
public class AccountList {
    //update role id to role name
    public ArrayList<Account> accountsgetAccountList() {
        ArrayList<Account> accounts = new ArrayList<Account>();
        AccountDAO acc = new AccountDAO();
        try {
            accounts = acc.getListAccounts();
        } catch (SQLException ex) {
            Logger.getLogger(AccountList.class.getName()).log(Level.SEVERE, null, ex);
        }
        RolesDAO role = new RolesDAO();
        ArrayList<Role> roles = new ArrayList<Role>();
        try {
            roles = role.getListRoles();
        } catch (SQLException ex) {
            Logger.getLogger(AccountList.class.getName()).log(Level.SEVERE, null, ex);
        }
        for (Account account : accounts) {
            for (Role role1 : roles) {
                if (account.getRole_id() == role1.getRole_id()) {
                    account.setRole(role1.getRole());
                }
            }
        }
        return accounts;
    }
}
