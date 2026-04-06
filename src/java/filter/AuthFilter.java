package filter;

import model.User;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Set;

@WebFilter("/*")
public class AuthFilter implements Filter {
    
    private static final Set<String> ALLOWED_PATHS = Set.of(
            "/login.jsp", "/login", "/register.jsp", "/register", "/403.jsp"
    );

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String path = req.getRequestURI().substring(req.getContextPath().length());

        //xử lý tài nguyên tĩnh
        if (path.startsWith("/css/") || path.startsWith("/js/") || path.startsWith("/images/") || path.contains("/assets")) {
            chain.doFilter(request, response);
            return;
        }
        
        // cho phép truy cập trang các trang public 
        if (ALLOWED_PATHS.contains(path)) {
            chain.doFilter(request, response);
            return;
        }

        // kiểm tra session
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user ==null){
            res.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }
        
        // Bảo mật: Ngăn trình duyệt lưu cache các trang cần login
        // Giúp nút "Back" không xem lại được dữ liệu cũ sau khi Logout
        res.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
        res.setHeader("Pragma", "no-cache"); 
        res.setDateHeader("Expires", 0);

        //Phân quyền ADMIN
        if (path.startsWith("/admin") && !user.isAdmin()) {
            res.sendRedirect(req.getContextPath() + "/403.jsp");
            return;
        }

        chain.doFilter(request, response);
    }
}