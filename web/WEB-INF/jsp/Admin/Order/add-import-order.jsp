<%-- 
    Document   : add-import-order
    Created on : Mar 27, 2026, 2:37:16 PM
    Author     : Admin
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>Tạo đơn nhập</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-5">
    <div class="card shadow p-4">
        <h3 class="mb-4">📦 Tạo đơn nhập</h3>

        <form action="import-order" method="post">

            <!-- Supplier -->
            <div class="mb-3">
                <label class="form-label">Supplier ID</label>
                <input type="number" name="supplier_id" class="form-control" required>
            </div>

            <!-- Order Date -->
            <div class="mb-3">
                <label class="form-label">Ngày nhập</label>
                <input type="datetime-local" name="order_date" class="form-control">
            </div>

            <!-- Total (cho nhập tay - optional) -->
            <div class="mb-3">
                <label class="form-label">Tổng tiền</label>
                <input type="number" step="0.1" name="total_amount" class="form-control">
            </div>

            <!-- Status -->
            <div class="mb-3">
                <label class="form-label">Trạng thái</label>
                <select name="status" class="form-control">
                    <option value="pending">Chờ xử lý</option>
                    <option value="completed">Hoàn thành</option>
                </select>
            </div>

            <button class="btn btn-primary">Tạo đơn</button>

        </form>
    </div>
</div>

</body>
</html>