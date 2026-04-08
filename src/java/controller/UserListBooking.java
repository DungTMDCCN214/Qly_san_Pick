/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.BookingDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Booking;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "UserListBooking", urlPatterns = {"/list-bookings"})
public class UserListBooking extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        
        // lấy userId từ session
//        HttpSession session = request.getSession();
//        int usedId = (int) session.getAttribute("userId");
        int userId = 1; // tạm fix cứng (chưa login)

        BookingDAO dao = new BookingDAO();
        List<Booking> list = new ArrayList();
        try {
            list = dao.getBookingsByUser(userId);
        } catch (SQLException ex) {
            Logger.getLogger(UserListBooking.class.getName()).log(Level.SEVERE, null, ex);
        }

        request.setAttribute("bookings", list);
        request.getRequestDispatcher("User/user-list-bookings.jsp").forward(request, response);
    }

}
