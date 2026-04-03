/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ImportOrderDetailDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Admin
 */
@WebServlet("/admin/import-order-detail")
public class ImportOrderDetailServlet extends HttpServlet {

    ImportOrderDetailDAO dao = new ImportOrderDetailDAO();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lay orerId de hien thi
        String orderId = request.getParameter("order-id");
        request.setAttribute("order_id", orderId);
        
        request.getRequestDispatcher("/WEB-INF/jsp/Admin/Order/import-order-detail.jsp").forward(request, response);
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int orderId = Integer.parseInt(request.getParameter("order_id"));
            int equipmentId = Integer.parseInt(request.getParameter("equipment_id"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            double price = Double.parseDouble(request.getParameter("price"));
            
            // insert detail + update kho
            dao.insertDetail(orderId, equipmentId, quantity, price);
            
            // reload lai trang
            response.sendRedirect(request.getContextPath() +"/admin/import-order-detail?order_id=" + orderId);
//            response.sendRedirect("/admin/import-order-detail?order_id=" + orderId);
        } catch(Exception e){
            e.printStackTrace();
            response.getWriter().println("Lỗi thêm chi tiết");
        }
    }
}
