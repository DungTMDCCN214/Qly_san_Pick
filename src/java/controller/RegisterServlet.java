/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.User;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author trithuan
 */

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException{
        
        request.setCharacterEncoding("UTF-8");
               
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String fullName = request.getParameter("full_name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        
        if(username == null || username.trim().isEmpty()){
            request.setAttribute("error", "Tên đăng nhập không được để trống");
            request.setAttribute("oldFullName", fullName);
            request.setAttribute("oldEmail", email);
            request.setAttribute("oldPhone", phone);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        String usernameRegex = "^[a-zA-Z0-9.\\-_]{3,20}$";
        if (!username.matches(usernameRegex)) {
            request.setAttribute("error", "Tên đăng nhập từ 3-20 ký tự, không dùng kí tự lạ");
            request.setAttribute("oldFullName", fullName);
            request.setAttribute("oldEmail", email);
            request.setAttribute("oldPhone", phone);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        if(fullName == null || fullName.trim().isEmpty()){
            request.setAttribute("error", "Tên người dùng không được để trống");
            request.setAttribute("oldUsername", username);
            request.setAttribute("oldEmail", email);
            request.setAttribute("oldPhone", phone);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        if(email == null || email.trim().isEmpty()){
            request.setAttribute("error", "Email không được để trống");
            request.setAttribute("oldUsername", username);
            request.setAttribute("oldFullName", fullName);
            request.setAttribute("oldPhone", phone);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        String emailRegex = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}$";
        if (!email.matches(emailRegex)) {
            request.setAttribute("error", "Định dạng Email không hợp lệ (Ví dụ: abc@gmail.com)");
            request.setAttribute("oldUsername", username);
            request.setAttribute("oldPhone", phone);
            request.setAttribute("oldFullName", fullName);            
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        if(phone == null || phone.trim().isEmpty()){
            request.setAttribute("error", "Số điện thoại không được để trống");
            request.setAttribute("oldUsername", username);
            request.setAttribute("oldEmail", email);
            request.setAttribute("oldFullName", fullName);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        String phoneRegex = "^0\\d{9,10}$";
        if (!phone.matches(phoneRegex)) {
            request.setAttribute("error", "Số điện thoại không hợp lệ (phải bắt đầu bằng 0 và có 10-11 chữ số)");
            request.setAttribute("oldUsername", username);
            request.setAttribute("oldEmail", email);
            request.setAttribute("oldFullName", fullName);            
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        if (password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Mật khẩu không được để trống");
            request.setAttribute("oldUsername", username);
            request.setAttribute("oldEmail", email);
            request.setAttribute("oldFullName", fullName);
            request.setAttribute("oldPhone", phone);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        String passwordRegex = "^[a-zA-Z0-9!@#$%^&*._\\-]{6,20}$";

        if (!password.matches(passwordRegex)) {
            request.setAttribute("error", "Mật khẩu từ 6-20 ký tự, không dùng kí tự lạ");
            request.setAttribute("oldUsername", username);
            request.setAttribute("oldEmail", email);
            request.setAttribute("oldFullName", fullName);
            request.setAttribute("oldPhone", phone);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (confirmPassword == null || !password.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu nhập lại không khớp");
            request.setAttribute("oldUsername", username);
            request.setAttribute("oldEmail", email);
            request.setAttribute("oldFullName", fullName);
            request.setAttribute("oldPhone", phone);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        //hash password
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
        
        User user = new User();
        user.setUsername(username);
        user.setPassword(hashedPassword); 
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPhone(phone);
        user.setRoleId(2);
        user.setStatus("ACTIVE");
        
        UserDAO userDAO = new UserDAO();
        
        if(userDAO.findByUsername(username) != null){
            request.setAttribute("error", "Tên đăng nhập đã tồn tại");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        boolean success = userDAO.insertUser(user);
        if(success){
            response.sendRedirect("login.jsp");
        }
        else{
            request.setAttribute("error", "Đăng ký thất bại");
            request.setAttribute("oldUsername", username);
            request.setAttribute("oldEmail", email);
            request.setAttribute("oldFullName", fullName);
            request.setAttribute("oldPhone", phone);
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
