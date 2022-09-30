/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author LENOVO
 */
public class Food {
    private int food_id;
    private String name;
    private float price;
    private int foodtype_id;
    private String foodDescription;
    private String foodImage;
    public Food() {
    }

    public Food(int food_id, String name, float price, int foodtype_id, String foodDescription, String foodImage) {
        this.food_id = food_id;
        this.name = name;
        this.price = price;
        this.foodtype_id = foodtype_id;
        this.foodDescription = foodDescription;
        this.foodImage = foodImage;
    }

    
    
    

    public int getFood_id() {
        return food_id;
    }

    public void setFood_id(int food_id) {
        this.food_id = food_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public int getFoodtype_id() {
        return foodtype_id;
    }

    public void setFoodtype_id(int foodtype_id) {
        this.foodtype_id = foodtype_id;
    }

    public String getFoodDescription() {
        return foodDescription;
    }

    public void setFoodDescription(String foodDescription) {
        this.foodDescription = foodDescription;
    }

    public String getFoodImage() {
        return foodImage;
    }

    public void setFoodImage(String foodImage) {
        this.foodImage = foodImage;
    }

    
    
}
