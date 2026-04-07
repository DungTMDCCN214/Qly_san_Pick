<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Lịch của tôi</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<nav class="navbar navbar-dark bg-dark">
    <div class="container">
        <a href="${pageContext.request.contextPath}/court" class="navbar-brand">
            ← Trang chủ
        </a>
    </div>
</nav>

<div class="container mt-4">
    <h2 class="mb-4">Lịch đặt sân của tôi</h2>

    <c:if test="${empty bookings}">
        <div class="alert alert-info">Bạn chưa đặt sân nào.</div>
    </c:if>

    <c:forEach var="b" items="${bookings}">
        <div class="card mb-3 shadow-sm">
            <div class="card-body">

                <h5>${b.courtName}</h5>

                <p>📅 ${b.bookingDate}</p>

                <p>
                    ⏰ 
                    <c:forEach var="s" items="${b.slots}">
                        <span class="badge bg-primary">${s}:00-${s+1}:00</span>
                    </c:forEach>
                </p>

                <p>💰 ${b.totalPrice} VND</p>

                <p>
                    📌 
                    <span class="badge ${b.status == 'cancelled' ? 'bg-danger' : 'bg-success'}">
                        ${b.status}
                    </span>
                </p>

                <!-- NÚT HỦY -->
                <c:if test="${b.status != 'cancelled'}">
                    <form action="cancel-booking" method="post"
                          onsubmit="return confirm('Bạn chắc chắn muốn hủy?');">

                        <input type="hidden" name="bookingId" value="${b.bookingId}">

                        <button class="btn btn-danger btn-sm">
                            Hủy lịch
                        </button>
                    </form>
                </c:if>

            </div>
        </div>
    </c:forEach>
</div>

</body>
</html>