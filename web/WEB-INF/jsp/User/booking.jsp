<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đặt sân</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<!-- NAVBAR -->
<nav class="navbar navbar-dark bg-dark">
    <div class="container">
        <a href="${pageContext.request.contextPath}/court" class="navbar-brand">
            ← Trang chủ
        </a>
    </div>
</nav>

<div class="container mt-4">

    <div class="card shadow p-4">

        <!-- ẢNH -->
        
        <img src="https://images.unsplash.com/photo-1599058917212-d750089bc07e"
             class="img-fluid rounded mb-3"
             style="max-height:300px; object-fit:cover; width:100%;">

        <!-- TÊN + GIÁ -->
        <h3>${court.court_name}</h3>
        <p class="text-muted">
            Giá: <b>${court.price_per_hour}</b> VND / giờ
        </p>

        <!-- DESCRIPTION -->
        <p>
            <b>Mô tả:</b> ${court.description}
        </p>

        <!-- THÔNG BÁO -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>

        <!-- FORM -->
        <form action="booking" method="post">
            <input type="hidden" name="courtId" value="${court.court_id != null ? court.court_id : courtId}">

            <div class="mb-3">
                <label class="form-label">Chọn ngày:</label>
                <input type="date" name="bookingDate" class="form-control" required>
            </div>

            <h5>Chọn giờ:</h5>

            <div class="row">
                <c:forEach var="i" begin="5" end="23">
                    <div class="col-md-3 mb-2">
                        <div class="form-check border p-2 rounded">
                            <input class="form-check-input" type="checkbox" name="slots" value="${i}">
                            <label class="form-check-label">
                                ${i}:00 - ${i+1}:00
                            </label>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <button type="submit" class="btn btn-success mt-3 w-100">
                Xác nhận đặt sân
            </button>
        </form>

    </div>
</div>

</body>
</html>