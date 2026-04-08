/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;



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
        try{
            String url = "jdbc:sqlserver://localhost;databaseName=QLy_san_Pick;encrypt=true;trustServerCertificate=true";
            String user = "sa";
            String pass = "123456";


            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = (Connection) DriverManager.getConnection(url, user, pass);
        } catch(Exception e){
            e.printStackTrace();
        }
    }
    // GET ALL
    public List<Court> getAllCourts() {
        List<Court> list = new ArrayList<>();
        String sql = "SELECT * FROM Courts";

        try (PreparedStatement ps = connection.prepareStatement(sql); 
                ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Court c = new Court(
                        rs.getInt("court_id"),
                        rs.getString("court_name"),
                        rs.getDouble("price_per_hour"),
                        rs.getString("status"),
                        rs.getString("description"),
                        rs.getString("imgUrl"));
                list.add(c);
            }
        } catch(Exception e){
            e.printStackTrace();
        }
        return list;
    }
    
    // INSERT (ĐÃ CẬP NHẬT THÊM img_URL)
    public void insertCourt(Court c){
        String sql = "INSERT INTO Courts(court_name, price_per_hour, status, description, imgUrl) VALUES(?, ?, ?, ?, ?)";

        try(PreparedStatement ps = connection.prepareStatement(sql)){
            ps.setString(1, c.getCourt_name());
            ps.setDouble(2, c.getPrice_per_hour());
            ps.setString(3, c.getStatus());
            ps.setString(4, c.getDescription());
            ps.setString(5, c.getImgUrl()); // THÊM DÒNG NÀY

            int rows = ps.executeUpdate();
            System.out.println("INSERT ROWS = " + rows);

        } catch(Exception e){
            e.printStackTrace();
        }
    }
    
    // DELETE
    public void deleteCourt(int id){
        String sql = "DELETE FROM Courts WHERE court_id = ?";
        
        try(PreparedStatement ps = connection.prepareStatement(sql)){
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch(Exception e){
            e.printStackTrace();
        }
    }
    
    // GET BY ID
    public Court getCourtById(int id){
        String sql = "SELECT * FROM Courts WHERE court_id = ?";
        try(PreparedStatement ps = connection.prepareStatement(sql)){
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            
            if(rs.next()){
                return new Court(
                        rs.getInt("court_id"),
                        rs.getString("court_name"),
                        rs.getDouble("price_per_hour"),
                        rs.getString("status"),
                        rs.getString("description"),
                        rs.getString("imgUrl")
                );
            }
        } catch(SQLException e){
            e.printStackTrace();
        }
        return null;
    }
    
    // UPDATE (ĐÃ CẬP NHẬT THÊM img_URL)
    public void updateCourt(Court c){
        String sql = "UPDATE Courts SET court_name=?, price_per_hour=?, status=?, description=?, imgUrl=? WHERE court_id=?";
        
        try(PreparedStatement ps = connection.prepareStatement(sql)){
            ps.setString(1, c.getCourt_name());
            ps.setDouble(2, c.getPrice_per_hour());
            ps.setString(3, c.getStatus());
            ps.setString(4, c.getDescription());
            ps.setString(5, c.getImgUrl()); // THÊM DÒNG NÀY
            ps.setInt(6, c.getCourt_id());
            
            ps.executeUpdate();
        } catch(Exception e){
            e.printStackTrace();
        }
    }
}