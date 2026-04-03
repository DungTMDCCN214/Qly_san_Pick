<%-- 
    Document   : edit-equipment
    Created on : Apr 1, 2026, 9:35:47 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Equipment"%>

<%
    Equipment e = (Equipment) request.getAttribute("equipment");
%>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<div class="container mt-5">
    <div class="card shadow p-4">

        <h3 class="mb-4">✏️ Cập nhật thiết bị</h3>

        <form action="equipment" method="post">

            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" value="<%=e.getEquipment_id()%>">

            <div class="mb-3">
                <label class="form-label">Tên thiết bị</label>
                <input type="text" name="name" value="<%=e.getEquipment_name()%>" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Số lượng</label>
                <input type="number" name="quantity" value="<%=e.getQuantity()%>" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Trạng thái</label>
                <select name="status" class="form-control">
                    <option value="available" <%= "available".equals(e.getStatus()) ? "selected" : "" %>>Có sẵn</option>
                    <option value="maintenance" <%= "maintenance".equals(e.getStatus()) ? "selected" : "" %>>Bảo trì</option>
                </select>
            </div>

            <button class="btn btn-warning">💾 Cập nhật</button>
            <a href="equipment" class="btn btn-secondary">⬅️ Quay lại</a>

        </form>

    </div>
</div>