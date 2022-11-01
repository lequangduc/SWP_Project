/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author LENOVO
 */
public class Table {
    private int tableID;
    private int tabletypeID;
    private String status;

    public Table() {
    }

    public Table(int tableID, int tabletypeID, String status) {
        this.tableID = tableID;
        this.tabletypeID = tabletypeID;
        this.status = status;
    }

    public int getTableID() {
        return tableID;
    }

    public void setTableID(int tableID) {
        this.tableID = tableID;
    }

    public int getTabletypeID() {
        return tabletypeID;
    }

    public void setTabletypeID(int tabletypeID) {
        this.tabletypeID = tabletypeID;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

}
