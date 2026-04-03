<%-- 
    Document   : add-equipment
    Created on : Apr 1, 2026, 9:28:01 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<div class="container mt-5">
    <div class="card shadow p-4">
        
        <h3 class="mb-4">➕ Thêm thiết bị</h3>

        <form action="equipment" method="post">

            <div class="mb-3">
                <label class="form-label">Tên thiết bị</label>
                <input type="text" name="name" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Số lượng</label>
                <input type="number" name="quantity" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Trạng thái</label>
                <select name="status" class="form-control">
                    <option value="available">Có sẵn</option>
                    <option value="maintenance">Bảo trì</option>
                </select>
            </div>

            <button class="btn btn-primary">💾 Lưu</button>
            <a href="equipment" class="btn btn-secondary">⬅️ Quay lại</a>

        </form>
    </div>
</div>