<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Equipment"%>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<div class="container mt-4">

    <div class="d-flex justify-content-between mb-3">
        <h3>⚙️ Quản lý thiết bị</h3>
        <a href="equipment?action=add" class="btn btn-success">➕ Thêm thiết bị</a>
    </div>

    <div class="card shadow p-3">
        <table class="table table-hover text-center align-middle">
            
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Tên thiết bị</th>
                    <th>Số lượng</th>
                    <th>Trạng thái</th>
                    <th>Hành động</th>
                </tr>
            </thead>

            <tbody>
            <%
                List<Equipment> list = (List<Equipment>) request.getAttribute("list");

                if (list != null && !list.isEmpty()) {
                    for (Equipment e : list) {
            %>
                <tr>
                    <td><%= e.getEquipment_id() %></td>
                    <td><%= e.getEquipment_name() %></td>

                    <td>
                        <span class="badge bg-info text-dark">
                            <%= e.getQuantity() %>
                        </span>
                    </td>

                    <td>
                        <% if ("available".equals(e.getStatus())) { %>
                            <span class="badge bg-success">Có sẵn</span>
                        <% } else { %>
                            <span class="badge bg-warning text-dark">Bảo trì</span>
                        <% } %>
                    </td>

                    <td>
                        <a href="equipment?action=edit&id=<%=e.getEquipment_id()%>" 
                           class="btn btn-warning btn-sm">
                           ✏️ Sửa
                        </a>

                        <a href="equipment?action=delete&id=<%=e.getEquipment_id()%>" 
                           class="btn btn-danger btn-sm"
                           onclick="return confirm('Bạn có chắc muốn xóa?')">
                           🗑️ Xóa
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