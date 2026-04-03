<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Supplier"%>

<!DOCTYPE html>
<html>
<head>
    <title>Quản lý nhà cung cấp</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body style="background:#f5f6fa">

<div class="container mt-5">

    <!-- CARD -->
    <div class="card shadow-lg p-4">

        <h3 class="mb-4">🏢 Quản lý nhà cung cấp</h3>

        <!-- FORM THÊM -->
        <form action="supplier" method="post" class="row g-3">

            <div class="col-md-4">
                <input type="text" name="name" class="form-control" placeholder="Tên nhà cung cấp" required>
            </div>

            <div class="col-md-3">
                <input type="text" name="phone" class="form-control" placeholder="Số điện thoại">
            </div>

            <div class="col-md-3">
                <input type="text" name="address" class="form-control" placeholder="Địa chỉ">
            </div>

            <div class="col-md-2">
                <button class="btn btn-primary w-100">➕ Thêm</button>
            </div>

        </form>

        <hr>

        <!-- TABLE -->
        <table class="table table-bordered table-hover text-center">

            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Tên</th>
                    <th>Phone</th>
                    <th>Địa chỉ</th>
                    <th>Hành động</th>
                </tr>
            </thead>

            <tbody>

<%
    List<Supplier> list = (List<Supplier>) request.getAttribute("list");

    if (list != null && !list.isEmpty()) {
        for (Supplier s : list) {
%>
                <tr>
                    <td><%= s.getSupplier_id() %></td>
                    <td><%= s.getSupplier_name() %></td>
                    <td><%= s.getPhone() %></td>
                    <td><%= s.getAddress() %></td>

                    <td>
                        <a href="supplier?action=delete&id=<%= s.getSupplier_id() %>"
                           class="btn btn-danger btn-sm"
                           onclick="return confirm('Xóa nhà cung cấp này?')">
                           🗑 Xóa
                        </a>
                    </td>
                </tr>
<%
        }
    } else {
%>
                <tr>
                    <td colspan="5">Không có dữ liệu</td>
                </tr>
<%
    }
%>

            </tbody>

        </table>

    </div>
</div>

</body>
</html>