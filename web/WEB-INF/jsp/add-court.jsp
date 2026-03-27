<%-- 
    Document   : add-court
    Created on : Mar 23, 2026, 10:58:29 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>Thêm sân</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f5f6fa;
        }
        .card {
            border-radius: 12px;
        }
    </style>
</head>

<body>

<div class="container mt-5">

    <div class="row justify-content-center">
        <div class="col-md-6">

            <div class="card shadow p-4">

                <!-- Title -->
                <h3 class="text-center mb-4">➕ Thêm sân</h3>

                <!-- Form -->
                <form action="court" method="post">

                    <!-- Name -->
                    <div class="mb-3">
                        <label class="form-label">Tên sân</label>
                        <input type="text" name="name" class="form-control" placeholder="Nhập tên sân" required>
                    </div>

                    <!-- Price -->
                    <div class="mb-3">
                        <label class="form-label">Giá / giờ (VNĐ)</label>
                        <input type="number" name="price" class="form-control" placeholder="Ví dụ: 200000" required>
                    </div>

                    <!-- Status -->
                    <div class="mb-3">
                        <label class="form-label">Trạng thái</label>
                        <select name="status" class="form-select">
                            <option value="active">Hoạt động</option>
                            <option value="maintenance">Bảo trì</option>
                        </select>
                    </div>

                    <!-- Description -->
                    <div class="mb-3">
                        <label class="form-label">Mô tả</label>
                        <textarea name="description" class="form-control" rows="3" placeholder="Mô tả sân..."></textarea>
                    </div>

                    <!-- Buttons -->
                    <div class="d-flex justify-content-between">
                        <a href="court" class="btn btn-secondary">⬅ Quay lại</a>
                        <button type="submit" class="btn btn-success">💾 Lưu</button>
                    </div>

                </form>

            </div>

        </div>
    </div>

</div>

</body>
</html>