/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CourtDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Court;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "UserCourtList", urlPatterns = {"/court"})
public class UserCourtListServlet extends HttpServlet {

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        CourtDAO dao = new CourtDAO();
        List<Court> courts = dao.getAllCourts();
        System.out.println(courts);

        request.setAttribute("courts", courts);
        request.getRequestDispatcher("/WEB-INF/jsp/User/user-court-list.jsp").forward(request, response);
    }


}
