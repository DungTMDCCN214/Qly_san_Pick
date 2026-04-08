<%-- 
    Document   : edit-court
    Created on : Mar 23, 2026, 10:58:44 AM
    Author     : Admin
--%>

<%@page import="model.Court"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Court c = (Court) request.getAttribute("court");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Sửa sân | Pickleball Manager</title>

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
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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
            border-color: #764ba2;
            box-shadow: 0 0 0 4px rgba(118, 75, 162, 0.15);
            outline: none;
        }

        textarea.form-control {
            border-radius: 20px;
            resize: vertical;
        }

        .btn-custom-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 40px;
            padding: 0.7rem 1.8rem;
            font-weight: 600;
            color: white;
            transition: all 0.25s ease;
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
        }

        .btn-custom-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.4);
            background: linear-gradient(135deg, #5a67d8 0%, #6b46a0 100%);
        }

        .btn-custom-secondary {
            background: #f1f5f9;
            border: none;
            border-radius: 40px;
            padding: 0.7rem 1.8rem;
            font-weight: 600;
            color: #475569;
            transition: all 0.2s ease;
        }

        .btn-custom-secondary:hover {
            background: #e2e8f0;
            transform: translateX(-3px);
            color: #1e293b;
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

        hr {
            margin: 1.5rem 0;
            border-top: 2px dotted #cbd5e1;
        }
        
        .current-image {
            margin-top: 0.5rem;
            padding: 0.5rem;
            background: #f8fafc;
            border-radius: 16px;
            text-align: center;
        }
        
        .current-image img {
            max-width: 100%;
            max-height: 150px;
            border-radius: 12px;
            border: 2px solid #e2e8f0;
            padding: 4px;
        }
        
        .image-preview {
            margin-top: 0.5rem;
            display: none;
        }
        
        .image-preview img {
            max-width: 100%;
            max-height: 150px;
            border-radius: 12px;
            border: 2px solid #e2e8f0;
            padding: 4px;
        }
        
        .image-note {
            font-size: 0.75rem;
            color: #64748b;
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
                    <i class="fas fa-pen-alt me-2" style="color: #764ba2;"></i>
                    Sửa thông tin sân
                </h3>

                <!-- Hiển thị ID đang sửa (thông tin phụ, không ảnh hưởng logic) -->
                <div class="text-center mb-3">
                    <span class="info-badge">
                        <i class="fas fa-hashtag me-1"></i> Đang sửa sân ID: <strong><%= c.getCourt_id() %></strong>
                    </span>
                </div>

                <!-- Form: GIỮ NGUYÊN action="court" method="post" và tất cả hidden fields -->
                <form action="court" method="post">

                    <!-- Hidden fields (GIỮ NGUYÊN) -->
                    <input type="hidden" name="id" value="<%= c.getCourt_id() %>">
                    <input type="hidden" name="action" value="update">

                    <!-- Tên sân -->
                    <div class="mb-4">
                        <label class="form-label">
                            <i class="fas fa-table-tennis me-1"></i> Tên sân
                        </label>
                        <input type="text" name="name" class="form-control"
                               value="<%= c.getCourt_name() %>" required>
                    </div>

                    <!-- Giá / giờ -->
                    <div class="mb-4">
                        <label class="form-label">
                            <i class="fas fa-dollar-sign me-1"></i> Giá / giờ (VNĐ)
                        </label>
                        <input type="number" name="price" class="form-control"
                               value="<%= c.getPrice_per_hour() %>" required>
                        <div class="form-text text-muted small mt-1">
                            * Nhập số, không dấu cách hoặc chữ
                        </div>
                    </div>

                    <!-- Trạng thái (GIỮ NGUYÊN logic selected) -->
                    <div class="mb-4">
                        <label class="form-label">
                            <i class="fas fa-circle-info me-1"></i> Trạng thái
                        </label>
                        <select name="status" class="form-select">
                            <option value="active" <%= "active".equals(c.getStatus()) ? "selected" : "" %>>
                                ✅ Hoạt động
                            </option>
                            <option value="maintenance" <%= "maintenance".equals(c.getStatus()) ? "selected" : "" %>>
                                🔧 Bảo trì
                            </option>
                        </select>
                    </div>

                    <!-- URL Ảnh (THÊM MỚI) -->
                    <div class="mb-4">
                        <label class="form-label">
                            <i class="fas fa-image me-1"></i> URL ảnh sân
                        </label>
                        <input type="url" name="imgUrl" class="form-control" 
                               value="<%= c.getImgUrl() != null ? c.getImgUrl() : "" %>"
                               placeholder="https://example.com/images/court.jpg"
                               onkeyup="previewImage(this.value)">
                        <div class="image-note">
                            <i class="fas fa-info-circle me-1"></i> Nhập đường dẫn URL ảnh của sân (có thể để trống)
                        </div>
                        
                        <!-- Hiển thị ảnh hiện tại nếu có -->
                        <% if (c.getImgUrl() != null && !c.getImgUrl().trim().isEmpty()) { %>
                            <div class="current-image" id="currentImage">
                                <img src="<%= c.getImgUrl() %>" alt="Ảnh hiện tại" 
                                     onerror="this.onerror=null; this.parentElement.style.display='none';">
                                <div class="image-note mt-1">📷 Ảnh hiện tại</div>
                            </div>
                        <% } %>
                        
                        <!-- Khung xem trước ảnh mới -->
                        <div class="image-preview" id="imagePreview">
                            <img id="previewImg" src="" alt="Xem trước ảnh mới">
                            <div class="image-note mt-1">🔍 Xem trước ảnh mới</div>
                        </div>
                    </div>

                    <!-- Mô tả -->
                    <div class="mb-4">
                        <label class="form-label">
                            <i class="fas fa-file-alt me-1"></i> Mô tả
                        </label>
                        <textarea name="description" class="form-control" rows="3"><%= c.getDescription() != null ? c.getDescription() : "" %></textarea>
                    </div>

                    <hr>

                    <!-- Buttons: GIỮ NGUYÊN thứ tự, href, type -->
                    <div class="d-flex justify-content-between gap-3">
                        <a href="court" class="btn btn-custom-secondary">
                            <i class="fas fa-arrow-left me-2"></i> Quay lại
                        </a>
                        <button type="submit" class="btn btn-custom-primary">
                            <i class="fas fa-save me-2"></i> Cập nhật
                        </button>
                    </div>

                </form>

            </div>

        </div>
    </div>
</div>

<script>
    // Hàm xem trước ảnh mới
    function previewImage(url) {
        const previewDiv = document.getElementById('imagePreview');
        const previewImg = document.getElementById('previewImg');
        const currentImageDiv = document.getElementById('currentImage');
        
        if (url && url.trim() !== '' && url !== '<%= c.getImgUrl() != null ? c.getImgUrl() : "" %>') {
            previewImg.src = url;
            previewDiv.style.display = 'block';
            // Nếu ảnh lỗi thì ẩn đi
            previewImg.onerror = function() {
                previewDiv.style.display = 'none';
            };
        } else {
            previewDiv.style.display = 'none';
            previewImg.src = '';
        }
    }
</script>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>