<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register</title>

    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

    <style>
        * {
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, sans-serif;
        }

        body {
            margin: 0;
            height: 100vh;
            background: #F6F7F9;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .register-box {
            width: 380px;
            background: #fff;
            padding: 35px;
            border-radius: 12px;
            border: 1px solid #E5E7EB;
            box-shadow: 0 10px 25px rgba(0,0,0,0.08);
            animation: fadeIn 0.4s ease;
        }

        @keyframes fadeIn {
            from {opacity:0; transform: translateY(15px);}
            to {opacity:1; transform: translateY(0);}
        }

        .title {
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            color: #2D3A2F;
            margin-bottom: 25px;
        }

        .input-group {
            position: relative;
            margin-bottom: 18px;
        }

        .input-group input {
            width: 100%;
            padding: 12px 40px;
            border-radius: 8px;
            border: 1px solid #E5E7EB;
            outline: none;
            background: #fafafa;
        }

        .input-group input:focus {
            border-color: #F4B400;
            background: #fff;
            box-shadow: 0 0 0 2px rgba(244,180,0,0.2);
        }

        .input-group i {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            color: #999;
        }

        .left-icon {
            left: 12px;
        }

        .right-icon {
            right: 12px;
            cursor: pointer;
        }

        .btn {
            width: 100%;
            padding: 12px;
            background: #F4B400;
            border: none;
            border-radius: 8px;
            color: white;
            font-weight: bold;
            cursor: pointer;
            transition: 0.2s;
        }

        .btn:hover {
            background: #d89c00;
        }

        .login-link {
            text-align: center;
            margin-top: 15px;
            font-size: 14px;
        }

        .login-link a {
            color: #F4B400;
            font-weight: bold;
            text-decoration: none;
        }

        .error {
            color: red;
            text-align: center;
            margin-top: 10px;
        }
    </style>
</head>

<body>

    <div class="register-box">

        <div class="title">Đăng ký</div>

        <form action="${pageContext.request.contextPath}/register" method="post" novalidate>

            <!-- Username -->
            <div class="input-group">
                <i class="fa fa-user left-icon"></i>
                <input type="text" id="username" name="username" placeholder="Username" value="${oldUsername}" oninput="checkUsername()"/>
            </div>
            
            <div id="usernameError" style="color:red; font-size:13px; margin-top:-10px; margin-bottom:10px;"></div>

            <!-- Full name -->
            <div class="input-group">
                <i class="fa fa-id-card left-icon"></i>
                <input type="text" id="full_name" name="full_name" placeholder="Full name" value="${oldFullName}" oninput="checkFullName()" />
            </div>
            
            <div id="fullNameError" style="color:red; font-size:13px; margin-top:-10px; margin-bottom:10px;"></div>

            <!-- Email -->
            <div class="input-group">
                <i class="fa fa-envelope left-icon"></i>
                <input type="email" id="email" name="email" placeholder="Email" value="${oldEmail}" oninput="checkEmail()" />
            </div>
            
            <div id="emailError" style="color:red; font-size:13px; margin-top:-10px; margin-bottom:10px;"></div>

            <!-- Phone -->
            <div class="input-group">
                <i class="fa fa-phone left-icon"></i>
                <input type="text" id="phone" name="phone" placeholder="Phone number" value="${oldPhone}" oninput="checkPhone()" />
            </div>
            
            <div id="phoneError" style="color:red; font-size:13px; margin-top:-10px; margin-bottom:10px;"></div>

            <!-- Password -->
            <div class="input-group">
                <i class="fa fa-lock left-icon"></i>
                <input type="password" id="password" name="password" placeholder="Password" oninput="checkPassword()" />
                <i class="fa fa-eye right-icon" onclick="togglePassword('password')"></i>
            </div>
            
            <!-- Confirm Password -->
            <div class="input-group">
                <i class="fa fa-lock left-icon"></i>
                <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm Password" oninput="checkPassword()" />
                <i class="fa fa-eye right-icon" onclick="togglePassword('confirmPassword')"></i>
            </div>
            
            <div id="passError" style="color:red; font-size:13px; margin-top:-10px; margin-bottom:10px;"></div>

            <button type="submit" class="btn">Register</button>

            <div class="login-link">
                Đã có tài khoản?
                <a href="${pageContext.request.contextPath}/login.jsp">Đăng nhập</a>
            </div>

            <div class="error">
                ${error}
            </div>

        </form>

    </div>

    <script>
        function togglePassword(id) {
            const input = document.getElementById(id);
            input.type = input.type === "password" ? "text" : "password";
        }

        function checkUsername() {
            const val = document.getElementById("username").value.trim();
            const error = document.getElementById("usernameError");
            const regex = /^[a-zA-Z0-9.\-_]{3,20}$/;

            if (val === "") {
                error.innerText = "Tên đăng nhập không được để trống";
                return false;
            } else if (!regex.test(val)) {
                error.innerText = "3-20 ký tự, không dùng kí tự lạ";
                return false;
            } else {
                error.innerText = "";
                return true;
            }
        }

        function checkEmail() {
            const val = document.getElementById("email").value.trim();
            const error = document.getElementById("emailError");
            const regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;

            if (val === "") {
                error.innerText = "Email không được để trống";
                return false;
            } else if (!regex.test(val)) {
                error.innerText = "Email không đúng định dạng";
                return false;
            } else {
                error.innerText = "";
                return true;
            }
        }

        function checkFullName() {
            const val = document.getElementById("full_name").value.trim();
            const error = document.getElementById("fullNameError");
            const regex = /^[a-zA-ZÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀỀỂưăạảấầẩẫậắằẳẵặẹẻẽềềểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹý\s]+$/;

            if (val === "") {
                error.innerText = "Họ và tên không được để trống";
                return false;
            } else if (!regex.test(val)) {
                error.innerText = "Họ tên không hợp lệ";
                return false;
            } else if (val.split(" ").length < 2) {
                error.innerText = "Vui lòng nhập đầy đủ cả Họ và Tên";
                return false;
            } else {
                error.innerText = "";
                return true;
            }
        }

        function checkPhone() {
            const val = document.getElementById("phone").value.trim();
            const error = document.getElementById("phoneError");
            const regex = /^0\d{9,10}$/;

            if (val === "") {
                error.innerText = "Số điện thoại không được để trống";
                return false;
            } else if (!regex.test(val)) {
                error.innerText = "Số điện thoại không hợp lệ";
                return false;
            } else {
                error.innerText = "";
                return true;
            }
        }

        function checkPassword() {
            const p1 = document.getElementById("password").value;
            const p2 = document.getElementById("confirmPassword").value;
            const error = document.getElementById("passError");
            const regex = /^[a-zA-Z0-9.\-_!@#$%^&*]{6,20}$/;

            if (p1 === "") {
                error.innerText = "Mật khẩu không được để trống";
                return false;
            } 
            if (!regex.test(p1)) {
                error.innerText = "6-20 ký tự, bao gồm cả ký tự đặc biệt";
                return false;
            }

            if (p2 !== "" && p1 !== p2) {
                error.innerText = "Mật khẩu không khớp";
                error.style.color = "red";
                return false;
            } else {
                error.innerText = "";
                return true;
            }
        }

        //chặn submit
        document.addEventListener("DOMContentLoaded", function() {
        const form = document.querySelector("form");

        form.addEventListener("submit", function(e) {
            // Chạy tất cả các hàm kiểm tra
            const isUserValid = checkUsername();
            const isFullNameValid = checkFullName();
            const isEmailValid = checkEmail();
            const isPhoneValid = checkPhone();
            const isPassValid = checkPassword();

            // Nếu có bất kỳ trường nào không hợp lệ, chặn submit
            if (!isUserValid || !isFullNameValid || !isEmailValid || !isPhoneValid || !isPassValid) {
                e.preventDefault();
                // Có thể thêm một thông báo chung nếu muốn
                console.log("Form không hợp lệ, đã chặn submit.");
            }
        });
    });
    </script>
</body>
</html>