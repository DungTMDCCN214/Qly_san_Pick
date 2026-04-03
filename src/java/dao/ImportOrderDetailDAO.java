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

public class ImportOrderDetailDAO {
    Connection connection;
    public ImportOrderDetailDAO(){
        try {
            String url = "jdbc:sqlserver://localhost:1433;databaseName=QLy_san_Pick;encrypt=true;trustServerCertificate=true";
            String user = "sa";
            String pass = "123456";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, user, pass);
        } catch (Exception e){
            e.printStackTrace();
        }
        
    }
    public void insertDetail(int orderId, int equipmentId, int quantity, double price) throws SQLException{
        String sql = "INSERT INTO Import_Order_Details(order_id, equipment_id, quantity, price) VALUES(?, ?, ?, ?)";
        
        try(PreparedStatement ps = connection.prepareStatement(sql)){
            ps.setInt(1, orderId);
            ps.setInt(2, equipmentId);
            ps.setInt(3, quantity);
            ps.setDouble(4, price);
            ps.executeUpdate();
            
            updateEquipment(equipmentId, quantity);
        } catch(Exception e){
            e.printStackTrace();
        }
    }

    public void updateEquipment(int equipmentId, int quantity) {
        String sql = "UPDATE Equipments SET quantity = quantity + ? WHERE equipment_id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)){
            ps.setInt(1, quantity);
            ps.setInt(2, equipmentId);
            ps.executeUpdate();
        } catch (Exception e){
            e.printStackTrace();
        }
    }
}
