<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Equipment"%>

<!DOCTYPE html>
<html>
<head>
    <title>Quản lý thiết bị | Pickleball Manager</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700;14..32,800&display=swap" rel="stylesheet">

    <style>
        * {
            font-family: 'Inter', sans-serif;
        }

        body {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            min-height: 100vh;
            padding: 2rem 0;
        }

        .glass-card {
            background: rgba(255, 255, 255, 0.97);
            border-radius: 28px;
            border: none;
            box-shadow: 0 20px 40px -15px rgba(0, 0, 0, 0.2);
            transition: all 0.3s ease;
            overflow: hidden;
        }

        .glass-card:hover {
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
        }

        .header-gradient {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            padding: 1.2rem 1.5rem;
            margin: -1rem -1rem 1.5rem -1rem;
            border-radius: 28px 28px 20px 20px;
        }

        h3 {
            margin: 0;
            font-weight: 700;
            letter-spacing: -0.3px;
        }

        .btn-add-custom {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            border: none;
            border-radius: 60px;
            padding: 0.6rem 1.6rem;
            font-weight: 600;
            color: white;
            transition: all 0.25s ease;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .btn-add-custom:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
            background: linear-gradient(135deg, #0e7a6e 0%, #2bc06d 100%);
            color: white;
        }

        .table-custom {
            border-radius: 20px;
            overflow: hidden;
            margin-bottom: 0;
        }

        .table-custom thead th {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            color: white;
            font-weight: 600;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            padding: 14px 8px;
            border-bottom: none;
        }

        .table-custom tbody tr {
            transition: all 0.2s ease;
            border-bottom: 1px solid #e9ecef;
        }

        .table-custom tbody tr:hover {
            background-color: #fff0f3;
            transform: scale(1.002);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        .badge-quantity {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 6px 14px;
            border-radius: 40px;
            font-weight: 600;
            font-size: 0.8rem;
        }

        .badge-status {
            padding: 6px 14px;
            border-radius: 40px;
            font-weight: 600;
            font-size: 0.75rem;
            letter-spacing: 0.3px;
        }

        .badge-available {
            background: linear-gradient(135deg, #00b09b, #96c93d);
            color: white;
        }

        .badge-maintenance {
            background: linear-gradient(135deg, #f09819, #ff6a00);
            color: white;
        }

        .btn-edit {
            background: linear-gradient(135deg, #f6d365 0%, #fda085 100%);
            border: none;
            border-radius: 40px;
            padding: 5px 14px;
            font-size: 0.8rem;
            font-weight: 500;
            transition: 0.2s;
            margin-right: 6px;
            color: white;
        }

        .btn-edit:hover {
            transform: translateY(-1px);
            box-shadow: 0 2px 8px rgba(253, 160, 133, 0.3);
            background: linear-gradient(135deg, #f5c542 0%, #fc8a5e 100%);
            color: white;
        }

        .btn-delete {
            background: #dc3545;
            border: none;
            border-radius: 40px;
            padding: 5px 14px;
            font-size: 0.8rem;
            font-weight: 500;
            transition: 0.2s;
        }

        .btn-delete:hover {
            background: #bb2d3b;
            transform: translateY(-1px);
            box-shadow: 0 2px 8px rgba(220, 53, 69, 0.3);
        }

        .table-responsive {
            border-radius: 20px;
        }

        .id-badge {
            font-weight: 700;
            color: #2c3e66;
        }
    </style>
</head>

<body>

<div class="container mt-2 mb-5">
    <div class="glass-card p-4 p-xl-5">

        <!-- Header with gradient background (giữ nguyên cấu trúc d-flex) -->
        <div class="header-gradient d-flex justify-content-between align-items-center mb-4">
            <h3 class="text-white">
                <i class="fas fa-microchip me-2"></i> Quản lý thiết bị
            </h3>
            <a href="equipment?action=add" class="btn btn-add-custom">
                <i class="fas fa-plus-circle me-2"></i> Thêm thiết bị
            </a>
        </div>

        <!-- Table (giữ nguyên cấu trúc bảng, các cột, logic) -->
        <div class="table-responsive">
            <table class="table table-hover table-custom align-middle text-center">
                <thead>
                    <tr>
                        <th width="10%"><i class="fas fa-hashtag me-1"></i> ID</th>
                        <th><i class="fas fa-microchip me-1"></i> Tên thiết bị</th>
                        <th width="15%"><i class="fas fa-cubes me-1"></i> Số lượng</th>
                        <th width="15%"><i class="fas fa-circle-info me-1"></i> Trạng thái</th>
                        <th width="22%"><i class="fas fa-tools me-1"></i> Hành động</th>
                    </tr>
                </thead>

                <tbody>
            <%
                List<Equipment> list = (List<Equipment>) request.getAttribute("list");

                if (list != null && !list.isEmpty()) {
                    for (Equipment e : list) {
            %>
                    <tr>
                        <td class="id-badge fw-bold">#<%= e.getEquipment_id() %></td>
                        <td class="fw-semibold"><%= e.getEquipment_name() %></td>

                        <td>
                            <span class="badge-quantity">
                                <i class="fas fa-box me-1"></i> <%= e.getQuantity() %>
                            </span>
                        </td>

                        <td>
                            <% if ("available".equals(e.getStatus())) { %>
                                <span class="badge-status badge-available">
                                    <i class="fas fa-check-circle me-1"></i> Có sẵn
                                </span>
                            <% } else { %>
                                <span class="badge-status badge-maintenance">
                                    <i class="fas fa-wrench me-1"></i> Bảo trì
                                </span>
                            <% } %>
                        </td>

                        <td>
                            <a href="equipment?action=edit&id=<%= e.getEquipment_id() %>" 
                               class="btn btn-edit btn-sm">
                               <i class="fas fa-edit me-1"></i> Sửa
                            </a>

                            <a href="equipment?action=delete&id=<%= e.getEquipment_id() %>" 
                               class="btn btn-delete btn-sm"
                               onclick="return confirm('⚠️ Bạn có chắc chắn muốn xóa thiết bị <%= e.getEquipment_name() %>?')">
                               <i class="fas fa-trash-alt me-1"></i> Xóa
                            </a>
                        </td>
                    </tr>
            <%
                    }
                } else {
            %>
                    <tr>
                        <td colspan="5" class="py-4 text-muted">
                            <i class="fas fa-frown me-2"></i> Chưa có thiết bị nào. Hãy nhấn "Thêm thiết bị" để tạo mới!
                        </td>
                    </tr>
            <%
                }
            %>
                </tbody>

            </table>
        </div>

    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>