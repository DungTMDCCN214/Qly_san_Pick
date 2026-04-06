/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ServiceDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import model.Service;

@WebServlet("/admin/service")
public class AdminServiceServlet extends HttpServlet {

    ServiceDAO dao = new ServiceDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {

            case "delete":
                int id = Integer.parseInt(request.getParameter("id"));
                dao.delete(id);
                response.sendRedirect(request.getContextPath() + "/admin/service");
                break;

            case "add":
                request.getRequestDispatcher("/WEB-INF/jsp/Admin/Service/add-service.jsp")
                        .forward(request, response);
                break;

            case "edit":
                int editId = Integer.parseInt(request.getParameter("id"));
                Service s = dao.getById(editId);
                request.setAttribute("service", s);
                request.getRequestDispatcher("/WEB-INF/jsp/Admin/Service/edit-service.jsp")
                        .forward(request, response);
                break;

            default:
                List<Service> list = dao.getAll();
                request.setAttribute("list", list);
                request.getRequestDispatcher("/WEB-INF/jsp/Admin/Service/service-list.jsp")
                        .forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        String name = request.getParameter("name");
        double price = Double.parseDouble(request.getParameter("price"));
        int equipment_id = Integer.parseInt(request.getParameter("equipment_id"));

        if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.update(new Service(id, name, price, equipment_id));
        } else {
            dao.insert(new Service(0, name, price, equipment_id));
        }

        response.sendRedirect(request.getContextPath() + "/admin/service");
    }
}