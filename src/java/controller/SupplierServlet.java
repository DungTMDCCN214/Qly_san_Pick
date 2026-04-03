/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.SupplierDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;
import model.Supplier;

/**
 *
 * @author Admin
 */
@WebServlet("/admin/supplier")
public class SupplierServlet extends HttpServlet {

    SupplierDAO dao = new SupplierDAO();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if("delete".equals(action)){
            int id = Integer.parseInt(request.getParameter("id"));
            dao.deleteSupplier(id);
            response.sendRedirect(request.getContextPath() + "/admin/supplier");
        } else {
            List<Supplier> list = dao.getAll();
            request.setAttribute("list", list);
            request.getRequestDispatcher("/WEB-INF/jsp/Admin/Supplier/supplier-list.jsp").forward(request, response);
        }
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        
        Supplier s = new Supplier(0, name, phone, address);
        try {      
            dao.insertSupplier(s);
        } catch (SQLException ex) {
            System.getLogger(SupplierServlet.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
        }
        response.sendRedirect(request.getContextPath() + "/admin/supplier");
    }
}
