/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;



import DBContext.DBContext;
import entity.Food;
import entity.FoodType;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author admin
 */
public class FoodDAO {

    public boolean addFoodType(String name) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        int rs = 0;
        try {
            String sql = "INSERT INTO foodtype values(?)";
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            rs = ps.executeUpdate();
            if (rs > 0) {
                return true;
            }
        } catch (Exception e) {
            System.out.println(e);
        } finally {

            ps.close();
            conn.close();
        }
        return false;
    }

    public boolean deleteFoodType(int id) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        int rs = 0;
        try {
            String sql = "DELETE from foodtype where foodtype_id = ? ";
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeUpdate();
            if (rs > 0) {
                return true;
            }
        } catch (Exception e) {
            System.out.println(e);
        } finally {

            ps.close();
            conn.close();
        }
        return false;
    }

    public int getFoodTypeId(String name) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT * from foodtype where foodtype_name = ?";
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            rs = ps.executeQuery();
            if (rs.next()) {
                int id = rs.getInt(1);
                return id;
            }

        } catch (Exception e) {
            System.out.println(e);
        } finally {
            rs.close();
            ps.close();
            conn.close();
        }
        return -1;
    }

    public String getFoodTypeName(int id) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT * from foodtype where foodtype_id = ?";
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                String name = rs.getString(2);
                return name;
            }

        } catch (Exception e) {
            System.out.println(e);
        } finally {
            rs.close();
            ps.close();
            conn.close();
        }
        return null;
    }

    public boolean addFood(Food f) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        int rs = 0;
        try {
            String sql = "INSERT INTO food values(?,?,?,?,?)";
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            // ps.setInt(1, f.getFood_id());
            ps.setString(1, f.getName());
            ps.setFloat(2, f.getPrice());
            ps.setInt(3, f.getFoodtype_id());
            ps.setString(4, f.getFoodDescription());
            ps.setString(5, f.getFoodImage());
            rs = ps.executeUpdate();
            if (rs > 0) {
                return true;
            }
        } catch (Exception e) {
            System.out.println(e);
        } finally {

            ps.close();
            conn.close();
        }
        return false;
    }

    public boolean addTypeFood(String typename) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        int rs = 0;
        try {
            String sql = "INSERT INTO foodtype values(?)";
            conn = new DBContext().getConnection();

            ps.setString(1, typename);
            rs = ps.executeUpdate();
            if (rs > 0) {
                return true;
            }
        } catch (Exception e) {
            System.out.println(e);
        } finally {

            ps.close();
            conn.close();
        }
        return false;
    }

    public boolean deleteFood(int id) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        int rs = 0;
        try {
            String sql = "DELETE from food where food_id = ? ";
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeUpdate();
            if (rs > 0) {
                return true;
            }
        } catch (Exception e) {
            System.out.println(e);
        } finally {

            ps.close();
            conn.close();
        }
        return false;
    }

    public List<Food> getListAllFood() throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Food> list = new ArrayList<>();
        try {
            String sql = "SELECT * from food";
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                String name = rs.getString(2);
                float price = rs.getFloat(3);
                int foodtype_id = rs.getInt(4);
                String description = rs.getString(5);
                String image = rs.getString(6);
                Food fo = new Food(id, name, price, foodtype_id, description, image);
                list.add(fo);
            }

        } catch (Exception e) {
            System.out.println(e);
        } finally {
            rs.close();
            ps.close();
            conn.close();
        }
        return list;

    }

    public Food getFoodByID(int id) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        Food fo = new Food();
        try {
            String sql = "SELECT * from food where food_id=?";
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {

                String name = rs.getString(2);
                float price = rs.getFloat(3);
                int foodtype_id = rs.getInt(4);
                String description = rs.getString(5);
                String image = rs.getString(6);
                fo = new Food(id, name, price, foodtype_id, description, image);

            }

        } catch (Exception e) {
            System.out.println(e);
        } finally {
            rs.close();
            ps.close();
            conn.close();
        }
        return fo;

    }

    public FoodType getFoodTypeByID(int id) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        FoodType fo = new FoodType();
        try {
            String sql = "SELECT * from foodtype where foodtype_id=?";
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {

                String name = rs.getString(2);
                fo = new FoodType(id, name);

            }

        } catch (Exception e) {
            System.out.println(e);
        } finally {
            rs.close();
            ps.close();
            conn.close();
        }
        return fo;

    }

    public List<Food> getListFoodByType(int id) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Food> list = new ArrayList<>();
        try {
            String sql = "SELECT * from food where foodtype_id = ?";
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                int foodid = rs.getInt(1);
                String name = rs.getString(2);
                float price = rs.getFloat(3);
                int foodtype_id = rs.getInt(4);
                String description = rs.getString(5);
                String image = rs.getString(6);
                Food fo = new Food(foodid, name, price, foodtype_id, description, image);
                list.add(fo);
            }

        } catch (Exception e) {
            System.out.println(e);
        } finally {
            rs.close();
            ps.close();
            conn.close();
        }
        return list;

    }

    public List<Food> searchFoodByName(String name) throws SQLException {
        List<Food> list = new ArrayList<>();
        List<Food> all = getListAllFood();
        for (Food food : all) {
            if (food.getName().toLowerCase().contains(name.toLowerCase())) {
                list.add(food);
            }
        }
        return list;
    }

    public boolean updateFood(Food f) throws SQLException {

        Connection conn = null;
        PreparedStatement ps = null;
        int rs = 0;
        try {
            int id = f.getFood_id();
            String sql = "UPDATE food SET name = ?,price = ?,foodtype_id = ?,fooddescription = ?,foodimage = ? WHERE food_id = ?";
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, f.getName());
            ps.setFloat(2, f.getPrice());
            ps.setInt(3, f.getFoodtype_id());
            ps.setString(4, f.getFoodDescription());
            ps.setString(5, f.getFoodImage());
            ps.setInt(6, f.getFood_id());
            rs = ps.executeUpdate();
            while (rs > 0) {
                return true;
            }
        } catch (Exception e) {
        } finally {

            ps.close();
            conn.close();
        }
        return false;

    }

    public boolean updateFoodType(FoodType f) throws SQLException {

        Connection conn = null;
        PreparedStatement ps = null;
        int rs = 0;
        try {
            int id = f.getIdfoodtype();
            String sql = "UPDATE foodtype SET foodtype_name=? WHERE foodtype_id = ?";
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, f.getFoodtypename());
            ps.setInt(2, f.getIdfoodtype());
            rs = ps.executeUpdate();
            while (rs > 0) {
                return true;
            }
        } catch (Exception e) {
        } finally {

            ps.close();
            conn.close();
        }
        return false;

    }

    public List<Food> getProductFromTo(int page, int pageSize) throws Exception {
        int from = page * pageSize - (pageSize - 1);
        int to = page * pageSize;
        List<Food> foods = new ArrayList<>();
        String query = "select SP.food_id,SP.name,SP.price,SP.foodtype_id,SP.fooddescription,SP.foodimage\n"
                + "from ( select *, ROW_NUMBER() over (order by food_id) as rownumber \n"
                + "from food) as SP \n"
                + "where SP.rownumber >= ? and SP.rownumber <= ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, from);
            ps.setInt(2, to);
            rs = ps.executeQuery();
            while (rs.next()) {
                int foodid = rs.getInt(1);
                String name = rs.getString(2);
                float price = rs.getFloat(3);
                int foodtype_id = rs.getInt(4);
                String description = rs.getString(5);
                String image = rs.getString(6);
                Food fo = new Food(foodid, name, price, foodtype_id, description, image);
                foods.add(fo);
            }
        } catch (Exception ex) {
            throw ex;
        } finally {
            rs.close();
            ps.close();
            conn.close();
        }
        return foods;
    }

    public List<FoodType> getListAllTypeName() throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<FoodType> list = new ArrayList<>();
        try {
            String sql = "SELECT * from foodtype";
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                String typename = rs.getString(2);
                FoodType f = new FoodType(id, typename);
                list.add(f);
            }

        } catch (Exception e) {
            System.out.println(e);
        } finally {
            rs.close();
            ps.close();
            conn.close();
        }
        return list;

    }

    public int countDish(int id) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int result = 0;
        try {
            String sql = "SELECT COUNT(*) from food where foodtype_id = ?";
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                result = rs.getInt(1);
            }

        } catch (Exception e) {
            System.out.println(e);
        } finally {
            rs.close();
            ps.close();
            conn.close();
        }
        return result;

    }

}
