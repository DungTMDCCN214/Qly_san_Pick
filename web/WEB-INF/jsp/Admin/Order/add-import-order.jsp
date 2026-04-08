<%-- 
    Document   : add-import-order
    Created on : Mar 27, 2026, 2:37:16 PM
    Author     : Admin
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>Tạo đơn nhập | Pickleball Manager</title>

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
            border-color: #3498db;
            box-shadow: 0 0 0 4px rgba(52, 152, 219, 0.15);
            outline: none;
        }

        select.form-control {
            cursor: pointer;
        }

        .btn-custom-primary {
            background: linear-gradient(135deg, #2c3e50 0%, #3498db 100%);
            border: none;
            border-radius: 40px;
            padding: 0.7rem 1.8rem;
            font-weight: 600;
            color: white;
            transition: all 0.25s ease;
            box-shadow: 0 4px 12px rgba(52, 152, 219, 0.3);
            width: 100%;
        }

        .btn-custom-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(52, 152, 219, 0.4);
            background: linear-gradient(135deg, #1e2f3e 0%, #2980b9 100%);
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
    </style>
</head>

<body>

<div class="container mt-2 mb-5">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">

            <div class="glass-card p-4 p-md-5">

                <!-- Title với icon -->
                <h3 class="text-center mb-4">
                    <i class="fas fa-boxes me-2" style="color: #3498db;"></i>
                    Tạo đơn nhập hàng
                </h3>

                <!-- Thông tin hướng dẫn nhỏ -->
                <div class="info-note">
                    <i class="fas fa-info-circle me-2" style="color: #3498db;"></i>
                    Nhập thông tin đơn nhập từ nhà cung cấp
                </div>

                <!-- Form: GIỮ NGUYÊN action="import-order" method="post" và tất cả name -->
                <form action="import-order" method="post">

                    <!-- Supplier ID -->
                    <div class="mb-4">
                        <label class="form-label">
                            <i class="fas fa-building me-1"></i> Mã nhà cung cấp (Supplier ID)
                        </label>
                        <input type="number" name="supplier_id" class="form-control" 
                               placeholder="Ví dụ: 1" required>
                        <div class="form-text text-muted">
                            * Nhập ID của nhà cung cấp đã có trong hệ thống
                        </div>
                    </div>

                    <!-- Order Date -->
                    <div class="mb-4">
                        <label class="form-label">
                            <i class="fas fa-calendar-alt me-1"></i> Ngày nhập
                        </label>
                        <input type="datetime-local" name="order_date" class="form-control">
                        <div class="form-text text-muted">
                            * Để trống sẽ lấy thời gian hiện tại
                        </div>
                    </div>

                    <!-- Total Amount -->
                    <div class="mb-4">
                        <label class="form-label">
                            <i class="fas fa-dollar-sign me-1"></i> Tổng tiền
                        </label>
                        <input type="number" step="0.1" name="total_amount" class="form-control" 
                               placeholder="Ví dụ: 5000000">
                        <div class="form-text text-muted">
                            * Có thể nhập tay hoặc để trống nếu chưa có
                        </div>
                    </div>

                    <!-- Status (GIỮ NGUYÊN select với class="form-control") -->
                    <div class="mb-4">
                        <label class="form-label">
                            <i class="fas fa-circle-info me-1"></i> Trạng thái
                        </label>
                        <select name="status" class="form-control">
                            <option value="pending">⏳ Chờ xử lý</option>
                            <option value="completed">✅ Hoàn thành</option>
                        </select>
                    </div>

                    <hr>

                    <!-- Button: GIỮ NGUYÊN button Tạo đơn -->
                    <button type="submit" class="btn-custom-primary">
                        <i class="fas fa-plus-circle me-2"></i> Tạo đơn nhập
                    </button>

                </form>

            </div>

        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>