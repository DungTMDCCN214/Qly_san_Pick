/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;
import java.sql.*;
import java.sql.Statement;
import java.sql.Connection;
import java.sql.DriverManager;
import model.ImportOrder;
/**
 *
 * @author Admin
 */
public class ImportOrderDAO {
    Connection connection;
    
    public ImportOrderDAO() {
        try {
            String url = "jdbc:sqlserver://localhost;databaseName=QLy_san_Pick;encrypt=true;trustServerCertificate=true";
            String user = "sa";
            String pass = "123456";


            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, user, pass);


        } catch (Exception e) {
            e.printStackTrace(); 
        }
    }
    
    public int insertOrder(ImportOrder order){
        String sql = "INSERT INTO Import_Orders(supplier_id, order_date, status) VALUES (?, GETDATE(), ?)";
        try(PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)){
            ps.setInt(1, order.getSupplier_id());
            ps.setString(2, order.getStatus());
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if(rs.next()){
                return rs.getInt(1);
            }
        } catch(Exception e){
            e.printStackTrace();
        }
        return -1;
    }
}
