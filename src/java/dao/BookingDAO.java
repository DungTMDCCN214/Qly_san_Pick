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
            String jdbcURL = "jdbc:mysql://localhost:3306/quanly_sanpick?useUnicode=true&characterEncoding=UTF-8";
            String jdbcUsername = "root";
            String jdbcPassword = "admin";
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch(Exception e) {
            e.printStackTrace();
        }
        

    }
    
    
    
    public boolean createBookingWithSlots(Booking booking, List<Integer> slots) {
        PreparedStatement psBooking = null;
        PreparedStatement psSlot = null;
        ResultSet rs = null;
        
        

        try {
            
                     

            // 🚨 BẮT ĐẦU TRANSACTION
            conn.setAutoCommit(false);
            
            if (!isSlotAvailable(conn, booking.getCourtId(), (Date) booking.getBookingDate(), slots)) {
                throw new SQLException("Slot đã bị đặt!");
            }  

            // 1. Insert booking
            String bookingSql = "INSERT INTO booking (user_id, court_id, booking_date, status, total_price) VALUES (?, ?, ?, ?, ?)";
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
            String slotSql = "INSERT INTO booking_details (booking_id, start_time, end_time) VALUES (?, ?, ?)";
            psSlot = conn.prepareStatement(slotSql);

            for (Integer gioBatDau : slots) {
                psSlot.setInt(1, bookingId);
                psSlot.setInt(2, gioBatDau);
                psSlot.setInt(3, gioBatDau+1);
                psSlot.addBatch();
            }

            psSlot.executeBatch();

            // ✅ COMMIT nếu tất cả OK
            conn.commit();
            return true;

        } catch (Exception e) {
            e.printStackTrace();

            // ❌ ROLLBACK nếu lỗi
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }

            return false;

        } finally {
//            // 🔒 đóng resource
//            try { if (rs != null) rs.close(); } catch (Exception e) {}
//            try { if (psBooking != null) psBooking.close(); } catch (Exception e) {}
//            try { if (psSlot != null) psSlot.close(); } catch (Exception e) {}
//            try { if (conn != null) conn.setAutoCommit(true); } catch (Exception e) {}
//            try { if (conn != null) conn.close(); } catch (Exception e) {}
        } 
    }
    
    public boolean isSlotAvailable(Connection conn, int courtId, Date date, List<Integer> slots) throws SQLException {
        StringBuilder sql = new StringBuilder(
            "SELECT bs.start_time FROM booking_details bs " +
            "JOIN booking b ON bs.booking_id = b.booking_id " +
            "WHERE b.court_id = ? AND b.booking_date = ? AND bs.start_time IN ("
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
        
        updateCompletedBookings(userId);

        String sql = "SELECT b.*, c.court_name " +
                     "FROM booking b JOIN courts c ON b.court_id = c.court_id " +
                     "WHERE b.user_id = ? AND b.status = ? ORDER BY b.booking_date ASC";


            PreparedStatement ps = conn.prepareStatement(sql); 

            ps.setInt(1, userId);
            ps.setString(2, "booked");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Booking b = new Booking();
                b.setBookingId(rs.getInt("booking_id"));
                b.setCourtName(rs.getString("court_name")); // thêm field này
                b.setBookingDate(rs.getDate("booking_date"));
                b.setTotalPrice(rs.getDouble("total_price"));
                b.setStatus(rs.getString("status"));

                // 👉 load slot
                b.setSlots(getSlotsByBookingId(b.getBookingId()));

                list.add(b);
            }



        return list;
    }
    
    public List<Integer> getSlotsByBookingId(int bookingId) throws SQLException {
        List<Integer> slots = new ArrayList<>();

        String sql = "SELECT start_time FROM booking_details WHERE booking_id = ?";

       
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                slots.add(rs.getInt("start_time"));
            }

        

        return slots;
    }
    
    public boolean cancelBooking(int bookingId, int userId) throws SQLException {
        String sql = "UPDATE booking SET status = 'cancelled' WHERE booking_id = ? AND user_id = ?";

        
        PreparedStatement ps = conn.prepareStatement(sql);

        ps.setInt(1, bookingId);
        ps.setInt(2, userId);
        return ps.executeUpdate() > 0;

        
    }
    
    
    public boolean isBookingExpired(int bookingId) throws SQLException {

    String sql = "SELECT b.booking_date, bs.start_time " +
                 "FROM bookings b " +
                 "JOIN booking_slots bs ON b.booking_id = bs.booking_id " +
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

            // ❌ Ngày đã qua
            if (bDate.isBefore(today)) {
                return true;
            }

            // ❌ Hôm nay nhưng giờ đã qua
            if (bDate.equals(today)) {
                if (gioBatDau <= now.getHour()) {
                    return true;
                }
            }
        }

    

        return false; // chưa qua → OK
    }
    
    
    public void updateCompletedBookings(int userId) throws SQLException {

        String sql = "UPDATE booking b " +
                     "SET b.status = 'completed' " +
                     "WHERE b.user_id = ? " +
                     "AND b.status = 'booked' " +
                     "AND ( " +
                     "    b.booking_date < CURDATE() " +
                     "    OR (b.booking_date = CURDATE() AND EXISTS ( " +
                     "        SELECT 1 FROM booking_details bs " +
                     "        WHERE bs.booking_id = b.booking_id " +
                     "        AND bs.start_time <= HOUR(NOW()) " +
                     "    )) " +
                     ")";

        
        PreparedStatement ps = conn.prepareStatement(sql); 

        ps.setInt(1, userId);
        ps.executeUpdate();

        
    }
    
}