/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.BookingDAO;
import dao.CourtDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Booking;
import model.Court;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "BookingServlet", urlPatterns = {"/booking"})
public class BookingServlet extends HttpServlet {
    
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        int courtId;
//        String param = request.getParameter("courtId");
//
//        // Kiểm tra kỹ parameter
//        if (param != null && !param.trim().isEmpty()) {
//            courtId = Integer.parseInt(param);
//        } else {
//            // Nếu không có parameter, thử lấy từ attribute (đã set trong doGet)
//            Object attr = request.getAttribute("courtId");
//            if (attr instanceof Integer) {
//                courtId = (Integer) attr;
//            } else {
//                // Vẫn không có thì báo lỗi
//                request.setAttribute("error", "Không tìm thấy ID sân!");
//                request.getRequestDispatcher("User/booking.jsp").forward(request, response);
//                return;
//            }
//        }
        try {
            // 1. Lấy dữ liệu từ form
            
            int courtId = Integer.parseInt(request.getParameter("courtId"));
            request.setAttribute("courtId", courtId);
            
            String dateStr = request.getParameter("bookingDate");

            String[] slotParams = request.getParameterValues("slots");



            //1. Validate date
            java.sql.Date bookingDate = validateDate(dateStr, request, response);
            if (bookingDate == null) return;

            // 2. Validate Slots
            List<Integer> slots = validateSlots(slotParams, request, response);
            if (slots == null) return;
            //3. Validate giờ hôm nay
             if (!validateTimeToday(bookingDate, slots, request, response)) return;

            // convert date
            java.util.Date utilDate = java.sql.Date.valueOf(dateStr);

           
//                user (giả sử đã login)
//            HttpSession session = request.getSession();
//            int userId = (int) session.getAttribute("userId");

            // 3. Tính tổng tiền (ví dụ)
            CourtDAO courtDAO = new CourtDAO();
            Court court = courtDAO.getCourtById(courtId);
            if (court == null) {
                throw new Exception("Không tìm thấy sân!");
            }
            int pricePerHour = court.getPrice_per_hour(); // lấy từ DB
            int totalPrice = pricePerHour * slots.size();

            // 4. Tạo Booking object
            Booking booking = new Booking();
            booking.setUserId(1); // chưa có chức năng login
            booking.setCourtId(courtId);
            booking.setBookingDate(utilDate);
            booking.setStatus("booked");
            booking.setTotalPrice(totalPrice);

            // 5. Gọi DAO
            BookingDAO dao = new BookingDAO();
            boolean success = dao.createBookingWithSlots(booking, slots);

            if (success) {
                //test
                //chuyen den trang thanh toan
                response.sendRedirect("list-bookings");
                
//                request.setAttribute("success", "Đặt sân thành công");
//                request.getRequestDispatcher("User/booking.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Đặt sân thất bại! Có thể bị trùng giờ.");
                request.getRequestDispatcher("User/booking.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống!");
            request.getRequestDispatcher("User/booking.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String param = request.getParameter("courtId");
        
        if (param == null || param.trim().isEmpty()) {
            response.sendRedirect("court"); // Về trang danh sách sân
            return;
        }
        
        int courtId = Integer.parseInt(param);
        

        CourtDAO dao = new CourtDAO();
        Court court = dao.getCourtById(courtId);
        request.setAttribute("courtId", courtId);
        request.setAttribute("court", court);
        request.getRequestDispatcher("User/booking.jsp").forward(request, response);
    }

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    
    private java.sql.Date validateDate(String dateStr,
        HttpServletRequest request,
        HttpServletResponse response) throws ServletException, IOException {

        if (dateStr == null || dateStr.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng chọn ngày!");
            request.getRequestDispatcher("User/booking.jsp").forward(request, response);
            return null;
        }

        try {
            java.sql.Date date = java.sql.Date.valueOf(dateStr);

            java.time.LocalDate today = java.time.LocalDate.now();
            java.time.LocalDate bookingDate = date.toLocalDate();

            if (bookingDate.isBefore(today)) {
                request.setAttribute("error", "Không thể đặt ngày trong quá khứ!");
                request.getRequestDispatcher("User/booking.jsp").forward(request, response);
                return null;
            }

            return date;

        } catch (Exception e) {
            request.setAttribute("error", "Ngày không hợp lệ!");
            request.getRequestDispatcher("User/booking.jsp").forward(request, response);
            return null;
        }
    }
    
    
    
    private List<Integer> validateSlots(String[] slotParams,
        HttpServletRequest request,
        HttpServletResponse response) throws ServletException, IOException {

        if (slotParams == null || slotParams.length == 0) {
            request.setAttribute("error", "Vui lòng chọn ít nhất 1 khung giờ!");
            request.getRequestDispatcher("User/booking.jsp").forward(request, response);
            return null;
        }

        List<Integer> slots = new ArrayList<>();

        try {
            for (String s : slotParams) {
                slots.add(Integer.parseInt(s));
            }
        } catch (Exception e) {
            request.setAttribute("error", "Slot không hợp lệ!");
            request.getRequestDispatcher("User/booking.jsp").forward(request, response);
            return null;
        }

        return slots;
    }   
    
    
    private boolean validateTimeToday(java.sql.Date bookingDate,
        List<Integer> slots,
        HttpServletRequest request,
        HttpServletResponse response) throws ServletException, IOException {

        java.time.LocalDate today = java.time.LocalDate.now();
        java.time.LocalDate bDate = bookingDate.toLocalDate();

        if (bDate.equals(today)) {
            int currentHour = java.time.LocalTime.now().getHour();

            for (int slot : slots) {
                if (slot <= currentHour) {
                    request.setAttribute("error", "Không thể đặt giờ đã qua!");
                    request.getRequestDispatcher("User/booking.jsp").forward(request, response);
                    return false;
                }
            }
        }

        return true;
    }
    
}
