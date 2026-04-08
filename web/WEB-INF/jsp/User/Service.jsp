<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Service"%>

<!DOCTYPE html>
<html>
<head>
    <title>Chọn dịch vụ | Pickleball Manager</title>

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
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 2rem 0;
        }

        .page-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .page-header h3 {
            font-weight: 700;
            color: white;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .page-header p {
            color: rgba(255, 255, 255, 0.9);
        }

        .service-card {
            background: white;
            border-radius: 24px;
            border: none;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            height: 100%;
            overflow: hidden;
        }

        .service-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 35px -10px rgba(0, 0, 0, 0.2);
        }

        .card-header-custom {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 1rem;
            text-align: center;
        }

        .card-header-custom h5 {
            margin: 0;
            font-weight: 700;
            color: white;
            font-size: 1.1rem;
        }

        .card-body-custom {
            padding: 1.2rem;
        }

        .price-badge {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
            padding: 8px 16px;
            border-radius: 40px;
            font-weight: 700;
            font-size: 1rem;
            display: inline-block;
            margin-bottom: 1rem;
            text-align: center;
            width: 100%;
        }

        .price-badge i {
            margin-right: 6px;
        }

        .form-control-custom {
            border-radius: 40px;
            border: 2px solid #e2e8f0;
            padding: 0.6rem 1rem;
            font-size: 0.9rem;
            transition: all 0.25s ease;
            text-align: center;
        }

        .form-control-custom:focus {
            border-color: #764ba2;
            box-shadow: 0 0 0 3px rgba(118, 75, 162, 0.2);
            outline: none;
        }

        .btn-add-custom {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            border: none;
            border-radius: 40px;
            padding: 0.6rem;
            font-weight: 600;
            color: white;
            transition: all 0.25s ease;
            width: 100%;
        }

        .btn-add-custom:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(17, 153, 142, 0.3);
            background: linear-gradient(135deg, #0e7a6e 0%, #2bc06d 100%);
        }

        .empty-state {
            text-align: center;
            padding: 3rem;
            background: white;
            border-radius: 24px;
            margin-top: 2rem;
        }

        .empty-state i {
            font-size: 4rem;
            color: #cbd5e1;
            margin-bottom: 1rem;
        }

        .empty-state p {
            color: #64748b;
            font-size: 1.1rem;
        }

        .booking-info {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 60px;
            padding: 0.6rem 1.5rem;
            display: inline-block;
            margin-bottom: 1.5rem;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .booking-info i {
            color: #764ba2;
            margin-right: 8px;
        }
    </style>
</head>

<body>

<div class="container mt-2 mb-5">
    
    <!-- Page Header -->
    <div class="page-header">
        <div class="booking-info">
            <i class="fas fa-ticket-alt"></i> 
            Mã đặt sân: <strong><%= request.getAttribute("booking_id") != null ? request.getAttribute("booking_id") : "Đang tải..." %></strong>
        </div>
        <h3><i class="fas fa-concierge-bell me-2"></i> Chọn dịch vụ bổ sung</h3>
        <p>Thêm đồ uống, cho thuê vợt hoặc các dịch vụ khác cho đơn đặt sân của bạn</p>
    </div>

    <div class="row">
    <%
        List<Service> list = (List<Service>) request.getAttribute("list");

        if (list != null && !list.isEmpty()) {
            for (Service s : list) {
                // Xử lý hiển thị giá
                String priceDisplay = "";
                Object priceObj = s.getPrice();
                if (priceObj instanceof Number) {
                    double price = ((Number) priceObj).doubleValue();
                    if (price == (long) price) {
                        priceDisplay = String.format("%,d", (long) price);
                    } else {
                        priceDisplay = String.format("%,.0f", price);
                    }
                } else {
                    priceDisplay = String.valueOf(priceObj);
                }
    %>

        <div class="col-md-4 mb-4">
            <div class="service-card">
                
                <div class="card-header-custom">
                    <h5>
                        <i class="fas fa-cube me-1"></i> <%= s.getService_name() %>
                    </h5>
                </div>
                
                <div class="card-body-custom">
                    <div class="price-badge">
                        <i class="fas fa-coins"></i> <%= priceDisplay %> VNĐ
                    </div>
                    
                    <!-- Form: GIỮ NGUYÊN action, method và các name -->
                    <form action="<%=request.getContextPath()%>/user/service-usage" method="post">

                        <input type="hidden" name="service_id" value="<%= s.getService_id() %>">
                        <input type="hidden" name="booking_id" value="<%= request.getAttribute("booking_id") %>">

                        <label class="form-label small text-muted mb-1">
                            <i class="fas fa-cubes"></i> Số lượng
                        </label>
                        <input type="number" name="quantity" value="1" min="1" 
                               class="form-control form-control-custom mb-3">

                        <button class="btn-add-custom">
                            <i class="fas fa-plus-circle me-2"></i> Thêm vào đơn
                        </button>

                    </form>
                </div>
                
            </div>
        </div>

    <%
            }
        } else {
    %>

        <div class="col-12">
            <div class="empty-state">
                <i class="fas fa-frown"></i>
                <p>😢 Hiện tại chưa có dịch vụ nào</p>
                <small class="text-muted">Vui lòng quay lại sau hoặc liên hệ quản trị viên</small>
            </div>
        </div>

    <%
        }
    %>

    </div>
    
    <!-- Nút quay lại (thêm tiện ích) -->
    <div class="text-center mt-4">
        <a href="<%=request.getContextPath()%>/user/booking" class="btn btn-light btn-lg rounded-pill px-4 shadow-sm">
            <i class="fas fa-arrow-left me-2"></i> Quay lại trang đặt sân
        </a>
    </div>
    
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>