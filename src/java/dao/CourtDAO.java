/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author ADMIN
 */
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */



/**
 *
 * @author Admin
 */
import java.sql.*;
import java.util.*;
import model.Court;

import java.sql.DriverManager;

import java.sql.PreparedStatement;



public class CourtDAO {

    Connection connection;
    
    public CourtDAO() {
        try {
            String jdbcURL = "jdbc:mysql://localhost:3306/quanly_sanpick?useUnicode=true&characterEncoding=UTF-8";
            String jdbcUsername = "root";
            String jdbcPassword = "admin";


            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);


        } catch (Exception e) {
            e.printStackTrace(); 
        }
    }
    // GET ALL
    public List<Court> getAllCourts() {
        List<Court> list = new ArrayList<>();
        String sql = "SELECT * FROM courts";

        try (PreparedStatement ps = connection.prepareStatement(sql); 
                ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Court c = new Court(
                        rs.getInt("court_id"),
                        rs.getString("court_name"),
                        rs.getInt("price_per_hour"),
                        rs.getString("status"),
                        rs.getString("description"),
                        rs.getString("img_URL"));
                list.add(c);
            }
        } catch(Exception e){
            e.printStackTrace();
        }
        return list;
    }
    
    // INSERT
    public void insertCourt(Court c){
    String sql = "INSERT INTO courts(court_name, price_per_hour, status, description) VALUES(?, ?, ?, ?)";

    try(PreparedStatement ps = connection.prepareStatement(sql)){
        ps.setString(1, c.getCourt_name());
        ps.setDouble(2, c.getPrice_per_hour());
        ps.setString(3, c.getStatus());
        ps.setString(4, c.getDescription());

        int rows = ps.executeUpdate();
        System.out.println("INSERT ROWS = " + rows);

    } catch(Exception e){
        e.printStackTrace();
    }
}
    
    // DELETE
    public void deleteCourt(int id){
        String sql = "DELETE FROM courts WHERE court_id = ?";
        
        try(PreparedStatement ps = connection.prepareStatement(sql)){
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch(Exception e){
            e.printStackTrace();
        }
    }
    
    // GET BY ID
    public Court getCourtById(int id){
        String sql = "SELECT * FROM courts WHERE court_id = ?";
        try(PreparedStatement ps = connection.prepareStatement(sql)){
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            
            if(rs.next()){
                return new Court(
                        rs.getInt("court_id"),
                        rs.getString("court_name"),
                        rs.getInt("price_per_hour"),
                        rs.getString("status"),
                        rs.getString("description"),
                        rs.getString("img_URL")
                );
            }
        } catch(SQLException e){
            e.printStackTrace();
        }
        return null;
    }
    
    // UPDATE
    public void updateCourt(Court c){
        String sql = "UPDATE courts SET court_name=?, price_per_hour=?, status=?, description=? WHERE court_id=?";
        
        try(PreparedStatement ps = connection.prepareStatement(sql)){
            ps.setString(1, c.getCourt_name());
            ps.setDouble(2, c.getPrice_per_hour());
            ps.setString(3,c.getStatus());
            ps.setString(4, c.getDescription());
            ps.setInt(5, c.getCourt_id());
            
            ps.executeUpdate();
        } catch(Exception e){
            e.printStackTrace();
        }
    }
}
