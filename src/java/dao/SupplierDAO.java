/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.*;
import java.util.*;
import model.Supplier;
/**
 *
 * @author Admin
 */
public class SupplierDAO {
    Connection connection;
    
    public SupplierDAO(){
        try{
            String url = "jdbc:sqlserver://localhost;databaseName=QLy_san_Pick;encrypt=true;trustServerCertificate=true";
            String user = "sa";
            String pass = "123456";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, user, pass);
        } catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public List<Supplier> getAll(){
        List<Supplier> list = new ArrayList<>();
        String sql = "SELECT * FROM Suppliers";
        
        try(PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()){
            while(rs.next()){          
                Supplier s = new Supplier(
                    rs.getInt("supplier_id"),
                    rs.getString("supplier_name"),
                    rs.getString("phone"),
                    rs.getString("address")
                );
                list.add(s);
            }
        } catch(Exception e){
            e.printStackTrace();
        }
        return list;
    }
    
    // INSERT
    
    public void insertSupplier(Supplier s) throws SQLException{
        String sql = "INSERT INTO Suppliers(supplier_name, phone, address) VALUES(?,?,?)";
        
        try(PreparedStatement ps = connection.prepareStatement(sql)){
            ps.setString(1, s.getSupplier_name());
            ps.setString(2, s.getPhone());
            ps.setString(3, s.getAddress());
            
            ps.executeUpdate();

        } catch(Exception e){
            e.printStackTrace();
        }
    }
    
    // DELETE
    public void deleteSupplier(int id){
        String sql = "DELETE FROM Suppliers WHERE supplier_id = ?";
        
        try(PreparedStatement ps = connection.prepareStatement(sql)){
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch(Exception e){
            e.printStackTrace();
        }
    }
}
