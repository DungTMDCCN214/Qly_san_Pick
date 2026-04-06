/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.*;
import model.ServiceUsage;

public class ServiceUsageDAO {

    Connection connection;

    public ServiceUsageDAO() {
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

    public void insert(ServiceUsage su) {

        String sql = "INSERT INTO Service_Usage (booking_id, service_id, quantity, unit_price, total_price) VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, su.getBooking_id());
            ps.setInt(2, su.getService_id());
            ps.setInt(3, su.getQuantity());
            ps.setDouble(4, su.getUnit_price());
            ps.setDouble(5, su.getTotal_price());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
