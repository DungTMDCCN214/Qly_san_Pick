package controller;

import dao.EquipmentDAO;
import model.Equipment;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/equipment")
public class EquipmentServlet extends HttpServlet {

    EquipmentDAO dao = new EquipmentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) action = "list";

        switch (action) {

            case "delete" -> {
                int id = Integer.parseInt(request.getParameter("id"));
                dao.deleteEquipment(id);
                response.sendRedirect(request.getContextPath() + "/admin/equipment");
            }

            case "edit" -> {
                int id = Integer.parseInt(request.getParameter("id"));
                Equipment e = dao.getById(id);
                request.setAttribute("equipment", e);
                request.getRequestDispatcher("/WEB-INF/jsp/Admin/Equipment/edit-equipment.jsp")
                        .forward(request, response);
            }

            case "add" -> {
                request.getRequestDispatcher("/WEB-INF/jsp/Admin/Equipment/add-equipment.jsp")
                        .forward(request, response);
            }

            default -> {
                List<Equipment> list = dao.getAll();
                request.setAttribute("list", list);
                request.getRequestDispatcher("/WEB-INF/jsp/Admin/Equipment/equipment-list.jsp")
                        .forward(request, response);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        String name = request.getParameter("name");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String status = request.getParameter("status");

        if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.updateEquipment(new Equipment(id, name, quantity, status));
        } else {
            dao.insertEquipment(new Equipment(0, name, quantity, status));
        }
        response.sendRedirect(request.getContextPath() + "/admin/equipment");
    }
}