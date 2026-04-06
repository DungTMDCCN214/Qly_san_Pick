<%-- 
    Document   : edit-service
    Created on : Apr 3, 2026, 4:42:36 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Service"%>

<%
    Service s = (Service) request.getAttribute("service");
%>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<div class="container mt-5">

    <div class="card shadow p-4">
        <h3 class="mb-4">✏️ Sửa dịch vụ</h3>

        <form action="<%=request.getContextPath()%>/admin/service" method="post">

            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" value="<%=s.getService_id()%>">

            <div class="mb-3">
                <label class="form-label">Tên dịch vụ</label>
                <input type="text" name="name" 
                       value="<%=s.getService_name()%>" 
                       class="form-control">
            </div>

            <div class="mb-3">
                <label class="form-label">Giá</label>
                <input type="number" name="price" 
                       value="<%=s.getPrice()%>" 
                       class="form-control">
            </div>

            <div class="mb-3">
                <label class="form-label">Equipment ID</label>
                <input type="number" name="equipment_id" 
                       value="<%=s.getEquipment_id()%>" 
                       class="form-control">
            </div>

            <button class="btn btn-primary">Cập nhật</button>
            <a href="<%=request.getContextPath()%>/admin/service" class="btn btn-secondary">Quay lại</a>

        </form>
    </div>

</div>