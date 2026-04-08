/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.CourtDAO;
import model.Court;

//import jakarta.servlet.ServletException;
//import jakarta.servlet.ServletResponse;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 *
 * @author Admin
 */
@WebServlet("/admin/court")
public class CourtServlet extends HttpServlet {

    CourtDAO dao = new CourtDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "delete" -> {
                int id = Integer.parseInt(request.getParameter("id"));
                dao.deleteCourt(id);
                response.sendRedirect(request.getContextPath() + "/admin/court");
            }
            case "edit" -> {
                int editId = Integer.parseInt(request.getParameter("id"));
                Court c = dao.getCourtById(editId);
                request.setAttribute("court", c);
                request.getRequestDispatcher("/WEB-INF/jsp/Admin/Court/edit-court.jsp").forward(request, (ServletResponse) response);
            }
            case "add" ->{
                request.getRequestDispatcher("/WEB-INF/jsp/Admin/Court/add-court.jsp")
                        .forward(request, response);
            }

            default -> {
                List<Court> list = dao.getAllCourts();
                request.setAttribute("list", list);
                request.getRequestDispatcher("/WEB-INF/jsp/Admin/Court/court-list.jsp").forward(request, (ServletResponse) response);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        String name = request.getParameter("name");
        double price = Double.parseDouble(request.getParameter("price"));
        String status = request.getParameter("status");
        String desc = request.getParameter("description");

        if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.updateCourt(new Court(id, name, price, status, desc));
        } else {
            dao.insertCourt(new Court(0, name, price, status, desc));
        }
        response.sendRedirect(request.getContextPath() + "/admin/court");
    }
}
