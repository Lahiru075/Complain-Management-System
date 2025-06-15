<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sign In</title>
    <style>
        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background-color: #f0f2f5;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            overflow: hidden;
        }
        .login-box {
            background-color: #ffffff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 420px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .login-box:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 32px rgba(0, 0, 0, 0.2);
        }
        .login-box h2 {
            margin-bottom: 30px;
            text-align: center;
            font-size: 28px;
            font-weight: 600;
            color: #1a1a1a;
        }
        .login-box input[type="text"],
        .login-box input[type="password"] {
            width: 100%;
            padding: 14px;
            margin: 12px 0;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            font-size: 16px;
            color: #333;
            background-color: #f9fafb;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }
        .login-box input[type="text"]:focus,
        .login-box input[type="password"]:focus {
            border-color: #6366f1;
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
            outline: none;
        }
        .login-box input[type="submit"] {
            width: 100%;
            padding: 14px;
            margin-top: 12px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }
        .login-box input[value="Login"] {
            background-color: #6366f1;
            color: #ffffff;
        }
        .login-box input[value="Login"]:hover {
            background-color: #4f46e5;
            transform: translateY(-2px);
        }
        .login-box input[value="SignUp"] {
            background-color: #10b981;
            color: #ffffff;
        }
        .login-box input[value="SignUp"]:hover {
            background-color: #059669;
            transform: translateY(-2px);
        }
        .message {
            text-align: center;
            margin: 15px 0;
            font-size: 14px;
            font-weight: 500;
        }
        .form-group {
            position: relative;
            margin-bottom: 20px;
        }
        .form-group label {
            position: absolute;
            top: -10px;
            left: 14px;
            background: #ffffff;
            padding: 0 6px;
            font-size: 12px;
            color: #666;
            font-weight: 500;
        }
        @media (max-width: 480px) {
            .login-box {
                padding: 20px;
                max-width: 90%;
            }
            .login-box h2 {
                font-size: 24px;
            }
        }
    </style>
</head>
<body>
<div class="login-box">
    <h2>Sign In</h2>
    <%
        String success = request.getParameter("success");
        if ("true".equals(success)) {
    %>
    <div class="message" style="color: green;">Successfully signed up! Please login.</div>
    <%
        }
        String error = request.getParameter("error");
        if ("true".equals(error)) {
    %>
    <div class="message" style="color: red;">Invalid username or password.</div>
    <%
        }
    %>
    <form action="${pageContext.request.contextPath}/signin" method="post">
        <input type="text" name="username" placeholder="Username" required />
        <input type="password" name="password" placeholder="Password" required />
        <input type="submit" value="Login" />
        <input type="submit" value="SignUp" onclick="window.location.href='View/signUp.jsp'"/>
    </form>
</div>

</body>
</html>
