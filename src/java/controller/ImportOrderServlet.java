/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ImportOrderDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ImportOrder;

/**
 *
 * @author Admin
 */
@WebServlet("/admin/import-order")
public class ImportOrderServlet extends HttpServlet {
    
    
    ImportOrderDAO dao = new ImportOrderDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException{
        request.getRequestDispatcher("/WEB-INF/jsp/Admin/Order/add-import-order.jsp").forward(request, response);
       
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        try{
            int supplierId = Integer.parseInt(request.getParameter("supplier_id"));
            
            ImportOrder order = new ImportOrder();
            order.setSupplier_id(supplierId);
            
            int orderId = dao.insertOrder(order);
            response.sendRedirect(request.getContextPath() +"/admin/import-order-detail?order_id=" + orderId);
            
//            response.sendRedirect("import-order-detail?order_id="+orderId);
        } catch(Exception e){
            e.printStackTrace();
            response.getWriter().println("Lỗi tạo đơn!");
        }
    }
}