/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.BookingDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
                request.getRequestDispatcher("list-bookings").forward(request, response);
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
                request.getRequestDispatcher("User/user-list-bookings.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("list-bookings");
        }
    }

}
