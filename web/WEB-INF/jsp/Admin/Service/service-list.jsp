<%-- 
    Document   : service-list
    Created on : Apr 3, 2026, 4:37:48 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Service"%>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<div class="container mt-4">

    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3>🛠️ Quản lý dịch vụ</h3>
        <a href="<%=request.getContextPath()%>/admin/service?action=add" 
           class="btn btn-success">➕ Thêm dịch vụ</a>
    </div>

    <div class="card shadow">
        <div class="card-body">

            <table class="table table-hover text-center align-middle">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Tên dịch vụ</th>
                        <th>Giá</th>
                        <th>Equipment ID</th>
                        <th>Hành động</th>
                    </tr>
                </thead>

                <tbody>
                <%
                    List<Service> list = (List<Service>) request.getAttribute("list");

                    if (list != null && !list.isEmpty()) {
                        for (Service s : list) {
                %>
                    <tr>
                        <td><%= s.getService_id() %></td>
                        <td><%= s.getService_name() %></td>
                        <td>
                            <span class="badge bg-info text-dark">
                                <%= s.getPrice() %> VND
                            </span>
                        </td>
                        <td><%= s.getEquipment_id() %></td>

                        <td>
                            <a href="<%=request.getContextPath()%>/admin/service?action=edit&id=<%=s.getService_id()%>" 
                               class="btn btn-warning btn-sm">✏️ Sửa</a>

                            <a href="<%=request.getContextPath()%>/admin/service?action=delete&id=<%=s.getService_id()%>" 
                               class="btn btn-danger btn-sm"
                               onclick="return confirm('Xóa dịch vụ này?')">🗑️ Xóa</a>
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

</div>
