/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.User;
import org.mindrot.jbcrypt.BCrypt;
/**
 *
 * @author trithuan
 */

@WebServlet("/login") //annotation định tuyến: báo cho máy chủ web biết rằng
                      //mọi request gửi tới "/login" sẽ được giao cho class LoginServlet xử lý
public class LoginServlet extends HttpServlet {
    //dùng doPost để bắt các method POST
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //lấy dữ liệu từ form
        String username = request.getParameter("username"); //getParameter(): lấy dữ liệu nhập từ ô input
        String password = request.getParameter("password");
        
        UserDAO userDAO = new UserDAO();
        User user = userDAO.findByUsername(username);
        
        //nếu không tìm thấy username
        if (user == null){
            request.setAttribute("error", "Không tìm thấy tên đăng nhập");
            request.setAttribute("oldUsername", username);
            request.getRequestDispatcher("login.jsp").forward(request, response); //đẩy thông báo lỗi lên trang login.jsp
            return;
        }
        
        if (!BCrypt.checkpw(password, user.getPassword())){
            request.setAttribute("error", "Sai mật khẩu");
            request.setAttribute("oldUsername", username);
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
        
        if (!"ACTIVE".equalsIgnoreCase(user.getStatus())) { 
            request.setAttribute("error", "Tài khoản bị khóa");
            request.setAttribute("oldUsername", username);
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        //lưu session
        HttpSession session = request.getSession();
        session.setAttribute("user", user);
        
        response.sendRedirect("home.jsp");
    }
}
