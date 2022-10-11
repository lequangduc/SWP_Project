/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.util.Date;

/**
 *
 * @author LENOVO
 */
public class Reservation {
    private int reservation_id;
    private int table_id;
    private int customer_id;
    private Date dateReservation;

    public Reservation(int reservation_id, int table_id, int customer_id, Date dateReservation) {
        this.reservation_id = reservation_id;
        this.table_id = table_id;
        this.customer_id = customer_id;
        this.dateReservation = dateReservation;
    }

    public Reservation(int table_id, int customer_id, Date dateReservation) {
        this.table_id = table_id;
        this.customer_id = customer_id;
        this.dateReservation = dateReservation;
    }
    
    public int getReservation_id() {
        return reservation_id;
    }

    public void setReservation_id(int reservation_id) {
        this.reservation_id = reservation_id;
    }

    public int getTable_id() {
        return table_id;
    }

    public void setTable_id(int table_id) {
        this.table_id = table_id;
    }

    public int getCustomer_id() {
        return customer_id;
    }

    public void setCustomer_id(int customer_id) {
        this.customer_id = customer_id;
    }

    public Date getDateReservation() {
        return dateReservation;
    }

    public void setDateReservation(Date dateReservation) {
        this.dateReservation = dateReservation;
    }
    
}
