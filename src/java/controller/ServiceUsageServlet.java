package controller;

import dao.ServiceDAO;
import dao.ServiceUsageDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import model.Service;
import model.ServiceUsage;

@WebServlet("/user/service-usage")
public class ServiceUsageServlet extends HttpServlet {

    ServiceDAO serviceDAO = new ServiceDAO();
    ServiceUsageDAO usageDAO = new ServiceUsageDAO();

    // 👉 HIỂN THỊ TRANG
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String bookingParam = request.getParameter("booking_id");

        if (bookingParam == null) {
            response.getWriter().println("Thiếu booking_id!");
            return;
        }

        int booking_id = Integer.parseInt(bookingParam);

        List<Service> list = serviceDAO.getAll();

        request.setAttribute("list", list);
        request.setAttribute("booking_id", booking_id);

        request.getRequestDispatcher("/WEB-INF/jsp/User/Service.jsp")
                .forward(request, response);
    }

    // 👉 THÊM DỊCH VỤ
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int booking_id = Integer.parseInt(request.getParameter("booking_id"));
        int service_id = Integer.parseInt(request.getParameter("service_id"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        Service s = serviceDAO.getById(service_id);

        double price = s.getPrice();

        ServiceUsage su = new ServiceUsage();
        su.setBooking_id(booking_id);
        su.setService_id(service_id);
        su.setQuantity(quantity);
        su.setUnit_price(price);
        su.setTotal_price(price * quantity);

        usageDAO.insert(su);

        response.sendRedirect(request.getContextPath() 
                + "/user/service-usage?booking_id=" + booking_id);
    }
}