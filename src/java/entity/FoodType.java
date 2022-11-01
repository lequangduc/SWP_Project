/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

/**
 *
 * @author admin
 */
public class FoodType {
    private int idfoodtype;
    private String foodtypename;

    public FoodType() {
    }

    public FoodType(int idfoodtype, String foodtypename) {
        this.idfoodtype = idfoodtype;
        this.foodtypename = foodtypename;
    }

    public int getIdfoodtype() {
        return idfoodtype;
    }

    public void setIdfoodtype(int idfoodtype) {
        this.idfoodtype = idfoodtype;
    }

    public String getFoodtypename() {
        return foodtypename;
    }

    public void setFoodtypename(String foodtypename) {
        this.foodtypename = foodtypename;
    }

    @Override
    public String toString() {
        return "FoodType{" + "idfoodtype=" + idfoodtype + ", foodtypename=" + foodtypename + '}';
    }
    
}
