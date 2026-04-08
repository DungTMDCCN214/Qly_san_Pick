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

<!DOCTYPE html>
<html>
<head>
    <title>Sửa thiết bị | Pickleball Manager</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700&display=swap" rel="stylesheet">

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
            background: rgba(255, 255, 255, 0.98);
            border-radius: 32px;
            border: none;
            box-shadow: 0 25px 45px -12px rgba(0, 0, 0, 0.3);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .glass-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 30px 55px -12px rgba(0, 0, 0, 0.35);
        }

        h3 {
            font-weight: 700;
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            margin-bottom: 1.8rem;
        }

        .form-label {
            font-weight: 600;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: #4a5568;
            margin-bottom: 0.5rem;
        }

        .form-control, .form-select {
            border-radius: 16px;
            border: 2px solid #e2e8f0;
            padding: 0.7rem 1rem;
            font-size: 0.95rem;
            transition: all 0.25s ease;
            background-color: #fefefe;
        }

        .form-control:focus, .form-select:focus {
            border-color: #f5576c;
            box-shadow: 0 0 0 4px rgba(245, 87, 108, 0.15);
            outline: none;
        }

        select.form-control {
            cursor: pointer;
        }

        .info-badge {
            background: #f1f5f9;
            border-radius: 40px;
            padding: 8px 16px;
            font-size: 0.85rem;
            color: #475569;
            margin-bottom: 1.5rem;
            display: inline-block;
        }

        .btn-custom-warning {
            background: linear-gradient(135deg, #f6d365 0%, #fda085 100%);
            border: none;
            border-radius: 40px;
            padding: 0.7rem 1.8rem;
            font-weight: 600;
            color: white;
            transition: all 0.25s ease;
            box-shadow: 0 4px 12px rgba(253, 160, 133, 0.3);
        }

        .btn-custom-warning:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(253, 160, 133, 0.4);
            background: linear-gradient(135deg, #f5c542 0%, #fc8a5e 100%);
        }

        .btn-custom-secondary {
            background: #f1f5f9;
            border: none;
            border-radius: 40px;
            padding: 0.7rem 1.8rem;
            font-weight: 600;
            color: #475569;
            transition: all 0.2s ease;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }

        .btn-custom-secondary:hover {
            background: #e2e8f0;
            transform: translateX(-3px);
            color: #1e293b;
        }

        .button-group {
            display: flex;
            justify-content: space-between;
            gap: 1rem;
            margin-top: 2rem;
        }

        hr {
            margin: 1.5rem 0;
            border-top: 2px dotted #cbd5e1;
        }

        .form-text {
            font-size: 0.75rem;
            margin-top: 0.25rem;
        }
    </style>
</head>

<body>

<div class="container mt-2 mb-5">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">

            <div class="glass-card p-4 p-md-5">

                <!-- Title với icon -->
                <h3 class="text-center mb-4">
                    <i class="fas fa-edit me-2" style="color: #f5576c;"></i>
                    Cập nhật thiết bị
                </h3>

                <!-- Hiển thị ID đang sửa (thông tin phụ, không ảnh hưởng logic) -->
                <div class="text-center mb-3">
                    <span class="info-badge">
                        <i class="fas fa-microchip me-1"></i> Đang sửa thiết bị ID: <strong><%= e.getEquipment_id() %></strong>
                    </span>
                </div>

                <!-- Form: GIỮ NGUYÊN action="equipment" method="post" và tất cả hidden fields -->
                <form action="equipment" method="post">

                    <!-- Hidden fields (GIỮ NGUYÊN) -->
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="id" value="<%= e.getEquipment_id() %>">

                    <!-- Tên thiết bị -->
                    <div class="mb-4">
                        <label class="form-label">
                            <i class="fas fa-microchip me-1"></i> Tên thiết bị
                        </label>
                        <input type="text" name="name" value="<%= e.getEquipment_name() %>" 
                               class="form-control" required>
                    </div>

                    <!-- Số lượng -->
                    <div class="mb-4">
                        <label class="form-label">
                            <i class="fas fa-cubes me-1"></i> Số lượng
                        </label>
                        <input type="number" name="quantity" value="<%= e.getQuantity() %>" 
                               class="form-control" min="0" required>
                        <div class="form-text text-muted">
                            * Nhập số nguyên dương
                        </div>
                    </div>

                    <!-- Trạng thái (GIỮ NGUYÊN logic selected) -->
                    <div class="mb-4">
                        <label class="form-label">
                            <i class="fas fa-circle-info me-1"></i> Trạng thái
                        </label>
                        <select name="status" class="form-control">
                            <option value="available" <%= "available".equals(e.getStatus()) ? "selected" : "" %>>
                                ✅ Có sẵn
                            </option>
                            <option value="maintenance" <%= "maintenance".equals(e.getStatus()) ? "selected" : "" %>>
                                🔧 Bảo trì
                            </option>
                        </select>
                    </div>

                    <hr>

                    <!-- Buttons: GIỮ NGUYÊN thứ tự và href -->
                    <div class="button-group">
                        <a href="equipment" class="btn-custom-secondary">
                            <i class="fas fa-arrow-left me-2"></i> Quay lại
                        </a>
                        <button type="submit" class="btn-custom-warning">
                            <i class="fas fa-save me-2"></i> Cập nhật
                        </button>
                    </div>

                </form>

            </div>

        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>