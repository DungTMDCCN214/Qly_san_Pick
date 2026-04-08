<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Danh sách sân</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/court">
            🏟️ Quản lý sân
        </a>

        <div class="collapse navbar-collapse">
            <ul class="navbar-nav ms-auto">

                <!-- Trang chủ -->
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/court">
                        Trang chủ
                    </a>
                </li>

                <!-- Lịch của tôi -->
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/list-bookings">
                        Lịch hẹn của tôi
                    </a>
                </li>
                <!--Log out - Chưa sửa-->
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/court"> 
                        Đăng xuất
                    </a>
                </li>

            </ul>
        </div>
    </div>
</nav>

<!-- CONTENT -->
<div class="container mt-4">
    <h2 class="text-center mb-4">Danh sách sân</h2>

    <div class="row">
        <c:forEach var="c" items="${courts}">
            <div class="col-md-4 mb-4">
                <div class="card shadow-sm">

                    <!-- ẢNH -->
                    <img src="https://images.unsplash.com/photo-1599058917212-d750089bc07e"
                         class="card-img-top"
                         style="height:200px; object-fit:cover;">

                    <div class="card-body">
                        <h5 class="card-title">${c.court_name}</h5>

                        <p class="text-muted">
                            Giá: <b>${c.price_per_hour}</b> VND / giờ
                        </p>

                        <a href="${pageContext.request.contextPath}/booking?courtId=${c.court_id}"
                           class="btn btn-primary w-100">
                            Đặt sân
                        </a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

</body>
</html>