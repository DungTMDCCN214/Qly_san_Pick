/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;


import java.sql.DriverManager;
import model.Equipment;
import java.util.*;
import java.sql.*;
/**
 *
 * @author Admin
 */
public class EquipmentDAO {
    Connection connection;
    
    public  EquipmentDAO(){
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
    public List<Equipment> getAll(){
        List<Equipment> list = new ArrayList<>();
        String sql = "SELECT * FROM Equipments";
        
        try(PreparedStatement ps = connection.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()){
            while(rs.next()){
                list.add(new Equipment(
                        rs.getInt("equipment_id"),
                        rs.getString("equipment_name"),
                        rs.getInt("quantity"),
                        rs.getString("status")
                ));
            }
        } catch(Exception e){
            e.printStackTrace();
        }
        return list;
    }
    
    //INSERT
    public void insertEquipment(Equipment e){
        String sql = "INSERT INTO Equipments(equipment_name, quantity, status) VALUES (?, ?, ?)";
        
        try(PreparedStatement ps = connection.prepareStatement(sql)){
            ps.setString(1, e.getEquipment_name());
            ps.setInt(2, e.getQuantity());
            ps.setString(3, e.getStatus());
            ps.executeUpdate();
        } catch(Exception m){
            m.printStackTrace();
        }
    }
    
    //DELETE
    public void deleteEquipment(int id) {
        String sql = "DELETE FROM Equipments WHERE equipment_id=?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    // ===== GET BY ID =====
    public Equipment getById(int id) {
        String sql = "SELECT * FROM Equipments WHERE equipment_id=?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new Equipment(
                        rs.getInt("equipment_id"),
                        rs.getString("equipment_name"),
                        rs.getInt("quantity"),
                        rs.getString("status")
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
    //UPDATE
    
    public  void updateEquipment(Equipment e){
        String sql = "UPDATE Equipments SET equipment_name=?, quantity=?, status=? WHERE equipment_id=?";
        
        try(PreparedStatement ps = connection.prepareStatement(sql)){
            ps.setString(1, e.getEquipment_name());
            ps.setInt(2, e.getQuantity());
            ps.setString(3, e.getStatus());
            ps.setInt(4, e.getEquipment_id());
            ps.executeUpdate();
        } catch(Exception exx){
            exx.printStackTrace();
        }
    }
}
