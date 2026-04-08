<%-- 
    Document   : import-order-detail
    Created on : Mar 27, 2026, 2:42:38 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>Chi tiết đơn nhập | Pickleball Manager</title>

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
            background: linear-gradient(135deg, #2c3e50 0%, #3498db 100%);
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
            background: linear-gradient(135deg, #2c3e50 0%, #3498db 100%);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            margin-bottom: 0.5rem;
        }

        .order-id-badge {
            background: linear-gradient(135deg, #2c3e50 0%, #3498db 100%);
            color: white;
            padding: 8px 20px;
            border-radius: 40px;
            display: inline-block;
            font-weight: 600;
            font-size: 1rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
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
            border-color: #3498db;
            box-shadow: 0 0 0 4px rgba(52, 152, 219, 0.15);
            outline: none;
        }

        .btn-custom-success {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            border: none;
            border-radius: 40px;
            padding: 0.7rem 1.8rem;
            font-weight: 600;
            color: white;
            transition: all 0.25s ease;
            box-shadow: 0 4px 12px rgba(17, 153, 142, 0.3);
            width: 100%;
        }

        .btn-custom-success:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(17, 153, 142, 0.4);
            background: linear-gradient(135deg, #0e7a6e 0%, #2bc06d 100%);
        }

        .form-text {
            font-size: 0.75rem;
            margin-top: 0.25rem;
        }

        hr {
            margin: 1.5rem 0;
            border-top: 2px dotted #cbd5e1;
        }

        .info-note {
            background: #f0f9ff;
            border-left: 4px solid #3498db;
            padding: 0.8rem 1rem;
            border-radius: 12px;
            font-size: 0.85rem;
            color: #2c3e50;
            margin-bottom: 1.5rem;
        }

        .action-buttons {
            display: flex;
            gap: 1rem;
            margin-top: 1rem;
        }
    </style>
</head>

<body>

<div class="container mt-2 mb-5">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">

            <div class="glass-card p-4 p-md-5">

                <!-- Title với icon -->
                <h3 class="text-center mb-2">
                    <i class="fas fa-clipboard-list me-2" style="color: #3498db;"></i>
                    Thêm chi tiết đơn nhập
                </h3>

                <!-- Hiển thị Order ID (GIỮ NGUYÊN giá trị) -->
                <div class="text-center mb-3">
                    <span class="order-id-badge">
                        <i class="fas fa-ticket-alt me-2"></i> Đơn hàng: <strong>${order_id}</strong>
                    </span>
                </div>

                <!-- Thông tin hướng dẫn nhỏ -->
                <div class="info-note">
                    <i class="fas fa-info-circle me-2" style="color: #3498db;"></i>
                    Nhập thông tin thiết bị cho đơn nhập này
                </div>

                <!-- Form: GIỮ NGUYÊN action và method -->
                <form action="<%=request.getContextPath()%>/import-order-detail" method="post">
                    
                    <!-- Hidden field: GIỮ NGUYÊN name="order_id" value="${order_id}" -->
                    <input type="hidden" name="order_id" value="${order_id}">

                    <!-- Equipment ID -->
                    <div class="mb-4">
                        <label class="form-label">
                            <i class="fas fa-microchip me-1"></i> Mã thiết bị (Equipment ID)
                        </label>
                        <input type="number" name="equipment_id" class="form-control" 
                               placeholder="Ví dụ: 1" required>
                        <div class="form-text text-muted">
                            * Nhập ID của thiết bị đã có trong hệ thống
                        </div>
                    </div>

                    <!-- Quantity -->
                    <div class="mb-4">
                        <label class="form-label">
                            <i class="fas fa-cubes me-1"></i> Số lượng
                        </label>
                        <input type="number" name="quantity" class="form-control" 
                               placeholder="Ví dụ: 10" min="1" required>
                        <div class="form-text text-muted">
                            * Số lượng nhập (phải lớn hơn 0)
                        </div>
                    </div>

                    <!-- Price -->
                    <div class="mb-4">
                        <label class="form-label">
                            <i class="fas fa-dollar-sign me-1"></i> Đơn giá
                        </label>
                        <input type="number" step="0.1" name="price" class="form-control" 
                               placeholder="Ví dụ: 250000" required>
                        <div class="form-text text-muted">
                            * Giá nhập cho mỗi thiết bị (VNĐ)
                        </div>
                    </div>

                    <hr>

                    <!-- Button: GIỮ NGUYÊN button Thêm -->
                    <button type="submit" class="btn-custom-success">
                        <i class="fas fa-plus-circle me-2"></i> Thêm chi tiết
                    </button>

                </form>

                <!-- Nút quay lại (thêm tiện ích, không ảnh hưởng cấu trúc chính) -->
                <div class="action-buttons mt-3">
                    <a href="<%=request.getContextPath()%>/import-order" class="btn btn-secondary w-100" style="border-radius: 40px;">
                        <i class="fas fa-arrow-left me-2"></i> Quay lại danh sách đơn
                    </a>
                </div>

            </div>

        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>