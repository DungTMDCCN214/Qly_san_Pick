<%-- 
    Document   : add-service
    Created on : Apr 3, 2026, 4:45:00 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<div class="container mt-5">

    <div class="card shadow p-4">
        <h3 class="mb-4">➕ Thêm dịch vụ</h3>

        <form action="<%=request.getContextPath()%>/admin/service" method="post">

            <div class="mb-3">
                <label class="form-label">Tên dịch vụ</label>
                <input type="text" name="name" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Giá</label>
                <input type="number" name="price" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Equipment ID</label>
                <input type="number" name="equipment_id" class="form-control" required>
            </div>

            <button class="btn btn-primary">Lưu</button>
            <a href="<%=request.getContextPath()%>/admin/service" class="btn btn-secondary">Quay lại</a>

        </form>
    </div>

</div>