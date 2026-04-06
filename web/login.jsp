<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>

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

        .login-box {
            width: 360px;
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

        .register {
            text-align: center;
            margin-top: 15px;
            font-size: 14px;
        }

        .register a {
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

    <div class="login-box">

        <div class="title">Login</div>

        <form action="${pageContext.request.contextPath}/login" method="post">

            <div class="input-group">
                <i class="fa fa-user left-icon"></i>
                <input type="text" name="username" placeholder="Username" value="${oldUsername}"/>
            </div>

            <div class="input-group">
                <i class="fa fa-lock left-icon"></i>
                <input type="password" id="password" name="password" placeholder="Password" />
                <i class="fa fa-eye right-icon" onclick="togglePassword()"></i>
            </div>

            <button type="submit" class="btn">Login</button>

            <div class="register">
                Chưa có tài khoản?
                <a href="${pageContext.request.contextPath}/register.jsp">Đăng ký</a>
            </div>

            <div class="error">
                ${error}
            </div>

        </form>

    </div>

    <script>
        function togglePassword() {
            const pass = document.getElementById("password");
            pass.type = pass.type === "password" ? "text" : "password";
        }
    </script>

</body>
</html>