package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=QLy_san_Pick;encrypt=true;trustServerCertificate=true";
    private static final String USER = "sa";
    private static final String PASSWORD = "123456Aa@";

    public static Connection getConnection() {
        Connection connection = null;
        try {
            // Load driver SQL Server
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

            // Kết nối DB
            connection = DriverManager.getConnection(URL, USER, PASSWORD);

            System.out.println("Kết nối SQL Server thành công!");
        } catch (Exception e) {
            System.out.println("Lỗi kết nối DB!");
            e.printStackTrace();
        }
        return connection;
    }
}