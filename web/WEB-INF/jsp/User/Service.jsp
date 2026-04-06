<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Service"%>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<div class="container mt-4">

    <h3>🛒 Chọn dịch vụ</h3>

    <div class="row">

    <%
        List<Service> list = (List<Service>) request.getAttribute("list");

        if (list != null) {
            for (Service s : list) {
    %>

        <div class="col-md-4 mb-3">
            <div class="card shadow p-3">

                <h5><%= s.getService_name() %></h5>
                <p>💰 <%= s.getPrice() %> VND</p>

                <form action="<%=request.getContextPath()%>/user/service-usage" method="post">

                    <input type="hidden" name="service_id" value="<%= s.getService_id() %>">
                    <input type="hidden" name="booking_id" value="<%= request.getAttribute("booking_id") %>">

                    <input type="number" name="quantity" value="1" min="1" class="form-control mb-2">

                    <button class="btn btn-primary w-100">➕ Thêm</button>

                </form>

            </div>
        </div>

    <%
            }
        } else {
    %>

        <p class="text-danger">Không có dịch vụ</p>

    <%
        }
    %>

    </div>
</div>