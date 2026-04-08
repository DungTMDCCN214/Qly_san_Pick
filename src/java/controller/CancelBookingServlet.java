/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.BookingDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "CancelBookingServlet", urlPatterns = {"/cancel-booking"})
public class CancelBookingServlet extends HttpServlet {

     @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            BookingDAO dao = new BookingDAO();

            if (dao.isBookingExpired(bookingId)) {
                request.setAttribute("error", "Không thể hủy! Đã quá giờ đặt sân.");
                request.getRequestDispatcher("WEB-INF/jsp/User/list-bookings").forward(request, response);
                return;
            }


//            HttpSession session = request.getSession();
//            int userId = (int) session.getAttribute("userId");
            int userId = 1;
            boolean success = dao.cancelBooking(bookingId, userId);

            if (success) {
                response.sendRedirect("list-bookings");
            } else {
                request.setAttribute("error", "Hủy thất bại!");
                request.getRequestDispatcher("WEB-INF/jsp/User/list-bookings").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("list-bookings");
        }
    }

}
