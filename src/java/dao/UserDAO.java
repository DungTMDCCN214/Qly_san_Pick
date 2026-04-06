/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.Role;
import model.User;
import util.DBConnection;

/**
 *
 * @author trithuan
 */
public class UserDAO {
    //login: tìm user theo username
    public User findByUsername(String username){
        User user = null;
        String sql = "SELECT u.*, r.role_name FROM users u " +
             "JOIN roles r ON u.role_id = r.role_id " +
             "WHERE u.username = ?";
        
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)){
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()){
                user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setFullName(rs.getString("full_name"));
                user.setPhone(rs.getString("phone"));
                user.setEmail(rs.getString("email"));
                
                user.setRoleId(rs.getInt("role_id"));
                String roleName = rs.getString("role_name");
                user.setRole(Role.valueOf(roleName)); //chuyển từ String sang ENUM
                
                user.setStatus(rs.getString("status"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
            }
        } catch(Exception e){
            e.printStackTrace();
        }
        
        return user;
    }
    
    // Thêm user (register)
    public boolean insertUser(User user) {
        String sql = "INSERT INTO users (username, password, full_name, phone, email, role_id, status) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getFullName());
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getEmail());
            ps.setInt(6, user.getRoleId());
            ps.setString(7, user.getStatus());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}
