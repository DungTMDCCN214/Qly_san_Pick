<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Supplier"%>

<!DOCTYPE html>
<html>
<head>
    <title>Quản lý nhà cung cấp | Pickleball Manager</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome 6 (icon đẹp hơn) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <!-- Google Fonts (hiện đại hơn) -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700&display=swap" rel="stylesheet">

    <style>
        * {
            font-family: 'Inter', sans-serif;
        }

        body {
            background: linear-gradient(135deg, #e0eafc 0%, #cfdef3 100%);
            min-height: 100vh;
            padding: 2rem 0;
        }

        .modern-card {
            border: none;
            border-radius: 28px;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(0px);
            box-shadow: 0 20px 35px -12px rgba(0, 0, 0, 0.2);
            transition: transform 0.2s ease;
        }

        .modern-card:hover {
            transform: translateY(-3px);
        }

        .table-custom {
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.03);
        }

        .table-custom thead th {
            background: #1e2a3e;
            color: white;
            font-weight: 600;
            font-size: 0.9rem;
            letter-spacing: 0.3px;
            border-bottom: none;
            padding: 14px 8px;
        }

        .table-custom tbody tr {
            transition: all 0.2s;
        }

        .table-custom tbody tr:hover {
            background-color: #f1f9ff;
            transform: scale(1.002);
        }

        .btn-smart {
            border-radius: 40px;
            padding: 6px 16px;
            font-weight: 500;
            transition: 0.2s;
        }

        .btn-primary {
            background: #1e466e;
            border: none;
            border-radius: 40px;
            padding: 10px 0;
            font-weight: 600;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
        }

        .btn-primary:hover {
            background: #0f2c46;
            transform: translateY(-2px);
            box-shadow: 0 8px 18px rgba(0, 0, 0, 0.1);
        }

        .btn-danger-smart {
            background: #fee2e2;
            color: #b91c1c;
            border: none;
            border-radius: 40px;
            font-weight: 600;
            padding: 5px 14px;
            transition: 0.2s;
        }

        .btn-danger-smart:hover {
            background: #fecaca;
            color: #7f1a1a;
            transform: translateY(-1px);
        }

        input.form-control {
            border-radius: 60px;
            padding: 10px 18px;
            border: 1px solid #dce4ec;
            background-color: #fefefe;
            transition: 0.2s;
        }

        input.form-control:focus {
            border-color: #1e466e;
            box-shadow: 0 0 0 4px rgba(30, 70, 110, 0.15);
        }

        hr {
            margin: 28px 0;
            border-top: 2px dotted #cbd5e1;
        }

        .badge-empty {
            background: #f1f5f9;
            color: #475569;
            padding: 12px;
            border-radius: 60px;
            font-weight: 500;
        }

        h3 i {
            color: #1e466e;
            margin-right: 8px;
        }
    </style>
</head>

<body>

<div class="container mt-2 mb-5">
    <div class="modern-card p-4 p-xl-5">

        <h3 class="mb-4 fw-semibold">
            <i class="fas fa-truck-fast"></i> Quản lý nhà cung cấp
        </h3>

        <!-- FORM THÊM (GIỮ NGUYÊN 100% ACTION, METHOD, NAME) -->
        <form action="supplier" method="post" class="row g-3 align-items-end">
            <div class="col-md-4">
                <label class="form-label small fw-semibold text-secondary ms-2">Tên nhà cung cấp</label>
                <input type="text" name="name" class="form-control" placeholder="Ví dụ: Công ty Vợt Việt" required>
            </div>

            <div class="col-md-3">
                <label class="form-label small fw-semibold text-secondary ms-2">Số điện thoại</label>
                <input type="text" name="phone" class="form-control" placeholder="0901.234.567">
            </div>

            <div class="col-md-3">
                <label class="form-label small fw-semibold text-secondary ms-2">Địa chỉ</label>
                <input type="text" name="address" class="form-control" placeholder="Quận 7, TP.HCM">
            </div>

            <div class="col-md-2">
                <button class="btn btn-primary w-100 btn-smart mt-md-0 mt-2">
                    <i class="fas fa-plus-circle me-1"></i> Thêm
                </button>
            </div>
        </form>

        <hr>

        <!-- TABLE (GIỮ NGUYÊN CẤU TRÚC, KHÔNG SỬA LOGIC) -->
        <div class="table-responsive">
            <table class="table table-bordered table-custom align-middle">

                <thead>
                    <tr>
                        <th width="10%"><i class="fas fa-hashtag me-1"></i> ID</th>
                        <th><i class="fas fa-building me-1"></i> Tên</th>
                        <th width="18%"><i class="fas fa-phone-alt me-1"></i> Phone</th>
                        <th><i class="fas fa-map-marker-alt me-1"></i> Địa chỉ</th>
                        <th width="15%"><i class="fas fa-cog me-1"></i> Hành động</th>
                    </tr>
                </thead>

                <tbody>
<%
    List<Supplier> list = (List<Supplier>) request.getAttribute("list");

    if (list != null && !list.isEmpty()) {
        for (Supplier s : list) {
%>
                    <tr>
                        <td class="fw-semibold">#<%= s.getSupplier_id() %></td>
                        <td class="fw-medium"><%= s.getSupplier_name() %></td>
                        <td><%= s.getPhone() != null ? s.getPhone() : "<span class='text-muted'>—</span>" %></td>
                        <td><%= s.getAddress() != null ? s.getAddress() : "<span class='text-muted'>—</span>" %></td>
                        <td>
                            <a href="supplier?action=delete&id=<%= s.getSupplier_id() %>"
                               class="btn btn-danger-smart btn-sm"
                               onclick="return confirm('Xóa nhà cung cấp này?')">
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
                            <i class="fas fa-inbox me-2"></i> Không có dữ liệu nhà cung cấp
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

<!-- Bootstrap JS (giữ nguyên nếu cần) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>