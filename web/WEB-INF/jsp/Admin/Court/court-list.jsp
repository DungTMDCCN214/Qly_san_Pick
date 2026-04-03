<%@page import="java.util.List"%>
<%@page import="model.Court"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    List<Court> list = (List<Court>) request.getAttribute("list");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Quản lý sân</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f5f6fa;
        }
        .card {
            border-radius: 12px;
        }
        .table th {
            background-color: #0d6efd;
            color: white;
        }
    </style>
</head>

<body>

<div class="container mt-5">

    <div class="card shadow p-4">

        <!-- Header -->
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h3>🏟️ Quản lý sân</h3>
            <a href="court?action=add" class="btn btn-success">
                ➕ Thêm sân
            </a>
        </div>

        <!-- Table -->
        <table class="table table-bordered table-hover text-center">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Tên sân</th>
                    <th>Giá / giờ</th>
                    <th>Trạng thái</th>
                    <th>Hành động</th>
                </tr>
            </thead>

            <tbody>
                <%
                    if (list != null) {
                        for (Court c : list) {
                %>
                <tr>
                    <td><%= c.getCourt_id() %></td>
                    <td><%= c.getCourt_name() %></td>
                    <td><%= c.getPrice_per_hour() %> VNĐ</td>

                    <td>
                        <% if ("active".equals(c.getStatus())) { %>
                            <span class="badge bg-success">Hoạt động</span>
                        <% } else { %>
                            <span class="badge bg-warning">Bảo trì</span>
                        <% } %>
                    </td>

                    <td>
                        <a href="court?action=edit&id=<%= c.getCourt_id() %>" 
                           class="btn btn-primary btn-sm">✏️ Sửa</a>

                        <a href="court?action=delete&id=<%= c.getCourt_id() %>" 
                           class="btn btn-danger btn-sm"
                           onclick="return confirm('Xóa sân này?')">
                           🗑️ Xóa
                        </a>
                    </td>
                </tr>
                <%
                        }
                    }
                %>
            </tbody>
        </table>

    </div>

</div>

</body>
</html>