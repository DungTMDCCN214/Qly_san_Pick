<%-- 
    Document   : import-order-detail
    Created on : Mar 27, 2026, 2:42:38 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>Chi tiết đơn nhập</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-5">

    <div class="card shadow p-4 mb-4">
        <h3>🧾 Thêm chi tiết đơn</h3>
        <p>Order ID: <b>${order_id}</b></p>

        <form action="<%=request.getContextPath()%>/import-order-detail" method="post">
            <input type="hidden" name="order_id" value="${order_id}">

            <div class="mb-3">
                <label>Equipment ID</label>
                <input type="number" name="equipment_id" class="form-control" required>
            </div>

            <div class="mb-3">
                <label>Số lượng</label>
                <input type="number" name="quantity" class="form-control" required>
            </div>

            <div class="mb-3">
                <label>Giá</label>
                <input type="number" step="0.1" name="price" class="form-control" required>
            </div>

            <button class="btn btn-success">➕ Thêm</button>
        </form>
    </div>

</div>

</body>
</html>
