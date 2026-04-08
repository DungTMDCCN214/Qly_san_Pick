/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author ADMIN
 */
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Booking;

public class BookingDAO {
    
    Connection conn = null;
    
    public BookingDAO() {
        try {
            String url = "jdbc:sqlserver://localhost;databaseName=QLy_san_Pick;encrypt=true;trustServerCertificate=true";
            String user = "sa";
            String pass = "123456";

            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            // SỬA: gán vào biến toàn cục conn
            conn = DriverManager.getConnection(url, user, pass);
            System.out.println("BookingDAO: Kết nối database thành công!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("BookingDAO: Kết nối database thất bại!");
        }
    }
    
    public boolean createBookingWithSlots(Booking booking, List<Integer> slots) {
        PreparedStatement psBooking = null;
        PreparedStatement psSlot = null;
        ResultSet rs = null;
        
        // KIỂM TRA CONNECTION TRƯỚC KHI DÙNG
        if (conn == null) {
            System.err.println("Connection is null! Cannot create booking.");
            return false;
        }

        try {
            // BẮT ĐẦU TRANSACTION
            conn.setAutoCommit(false);
            
            if (!isSlotAvailable(conn, booking.getCourtId(), booking.getBookingDate(), slots)) {
                throw new SQLException("Slot đã bị đặt!");
            }  

            // 1. Insert booking
            String bookingSql = "INSERT INTO Bookings (user_id, court_id, booking_date, status, total_price) VALUES (?, ?, ?, ?, ?)";
            psBooking = conn.prepareStatement(bookingSql, Statement.RETURN_GENERATED_KEYS);

            psBooking.setInt(1, booking.getUserId());
            psBooking.setInt(2, booking.getCourtId());
            psBooking.setDate(3, new java.sql.Date(booking.getBookingDate().getTime()));
            psBooking.setString(4, booking.getStatus());
            psBooking.setDouble(5, booking.getTotalPrice());

            int affectedRows = psBooking.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Tạo booking thất bại, không có dòng nào bị ảnh hưởng.");
            }

            // 2. Lấy booking_id vừa insert
            rs = psBooking.getGeneratedKeys();
            int bookingId;
            if (rs.next()) {
                bookingId = rs.getInt(1);
            } else {
                throw new SQLException("Không lấy được booking_id.");
            }

            // 3. Insert booking_slots
            String slotSql = "INSERT INTO Booking_Details (booking_id,court_id, start_time, end_time) VALUES (?, ?, ?, ?)";
            psSlot = conn.prepareStatement(slotSql);

            for (Integer gioBatDau : slots) {
                psSlot.setInt(1, bookingId);
                psSlot.setInt(2, booking.getCourtId());
                psSlot.setInt(3, gioBatDau);
                psSlot.setInt(4, gioBatDau + 1);
                psSlot.addBatch();
            }

            psSlot.executeBatch();

            // COMMIT nếu tất cả OK
            conn.commit();
            return true;

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
            // ROLLBACK nếu lỗi
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            return false;

        } finally {
            // Khôi phục auto-commit
            try {
                if (conn != null) {
                    conn.setAutoCommit(true);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            
            // Đóng resources
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (psBooking != null) psBooking.close(); } catch (Exception e) {}
            try { if (psSlot != null) psSlot.close(); } catch (Exception e) {}
        }
    }
    
    public boolean isSlotAvailable(Connection conn, int courtId, java.util.Date date, List<Integer> slots) throws SQLException {
        if (conn == null) {
            throw new SQLException("Connection is null!");
        }
        
        StringBuilder sql = new StringBuilder(
            "SELECT bs.start_time FROM Booking_Details bs " +
            "JOIN Bookings b ON bs.booking_id = b.booking_id " +
            "WHERE b.court_id = ? AND CAST(b.booking_date AS DATE) = CAST(? AS DATE) AND bs.start_time IN ("
        );

        for (int i = 0; i < slots.size(); i++) {
            sql.append("?");
            if (i < slots.size() - 1) sql.append(",");
        }
        sql.append(") AND b.status = 'booked'");

        PreparedStatement ps = conn.prepareStatement(sql.toString());
        ps.setInt(1, courtId);
        ps.setDate(2, new java.sql.Date(date.getTime()));

        for (int i = 0; i < slots.size(); i++) {
            ps.setInt(i + 3, slots.get(i));
        }

        ResultSet rs = ps.executeQuery();
        return !rs.next(); // true = available
    }
    
    public List<Booking> getBookingsByUser(int userId) throws SQLException {
        List<Booking> list = new ArrayList<>();
        
        if (conn == null) {
            System.err.println("Connection is null! Cannot get bookings.");
            return list;
        }
        
//        updateCompletedBookings(userId);

        String sql = "SELECT b.*, c.court_name " +
                     "FROM Bookings b JOIN Courts c ON b.court_id = c.court_id " +
                     "WHERE b.user_id = ? AND b.status = 'booked' ORDER BY b.booking_date ASC";

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Booking b = new Booking();
            b.setBookingId(rs.getInt("booking_id"));
            b.setCourtName(rs.getString("court_name"));
            b.setBookingDate(rs.getDate("booking_date"));
            b.setTotalPrice(rs.getDouble("total_price"));
            b.setStatus(rs.getString("status"));
            b.setSlots(getSlotsByBookingId(b.getBookingId()));
            list.add(b);
        }
        
        System.out.println(list);
        
        rs.close();
        ps.close();
        return list;
    }
    
    public List<Integer> getSlotsByBookingId(int bookingId) throws SQLException {
        List<Integer> slots = new ArrayList<>();
        
        if (conn == null) {
            System.err.println("Connection is null! Cannot get slots.");
            return slots;
        }

        String sql = "SELECT start_time FROM Booking_Details WHERE booking_id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, bookingId);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            slots.add(rs.getInt("start_time"));
        }
        
        rs.close();
        ps.close();
        return slots;
    }
    
    public boolean cancelBooking(int bookingId, int userId) throws SQLException {
        if (conn == null) {
            System.err.println("Connection is null! Cannot cancel booking.");
            return false;
        }
        
        String sql = "UPDATE Bookings SET status = 'cancelled' WHERE booking_id = ? AND user_id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, bookingId);
        ps.setInt(2, userId);
        return ps.executeUpdate() > 0;
    }
    
    public boolean isBookingExpired(int bookingId) throws SQLException {
        if (conn == null) {
            System.err.println("Connection is null! Cannot check expiry.");
            return true;
        }

        String sql = "SELECT b.booking_date, bs.start_time " +
                     "FROM Bookings b " +
                     "JOIN Booking_Details bs ON b.booking_id = bs.booking_id " +
                     "WHERE b.booking_id = ?";
        
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, bookingId);
        ResultSet rs = ps.executeQuery();

        java.time.LocalDate today = java.time.LocalDate.now();
        java.time.LocalTime now = java.time.LocalTime.now();

        while (rs.next()) {
            java.sql.Date bookingDate = rs.getDate("booking_date");
            int gioBatDau = rs.getInt("start_time");

            java.time.LocalDate bDate = bookingDate.toLocalDate();

            if (bDate.isBefore(today)) {
                rs.close();
                ps.close();
                return true;
            }

            if (bDate.equals(today) && gioBatDau <= now.getHour()) {
                rs.close();
                ps.close();
                return true;
            }
        }
        
        rs.close();
        ps.close();
        return false;
    }
    
    public void updateCompletedBookings(int userId) throws SQLException {
        if (conn == null) {
            System.err.println("Connection is null! Cannot update bookings.");
            return;
        }

        String sql = 
            "UPDATE Bookings b " +
            "SET b.status = 'completed' " +
            "WHERE b.user_id = ? " +
            "  AND b.status = 'booked' " +
            "  AND ( " +
            "      b.booking_date < CAST(GETDATE() AS DATE) " +
            "      OR ( " +
            "          CAST(b.booking_date AS DATE) = CAST(GETDATE() AS DATE) " +
            "          AND EXISTS ( " +
            "              SELECT 1 FROM Booking_Details bs " +
            "              WHERE bs.booking_id = b.booking_id " +
            "                AND bs.start_time <= DATEPART(HOUR, GETDATE()) " +
            "          ) " +
            "      ) " +
            "  )";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            int rowsUpdated = ps.executeUpdate();
            System.out.println("Updated " + rowsUpdated + " completed bookings for user " + userId);
        }
    }
}