<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sign In</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f2f5;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .login-box {
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            width: 400px;
        }
        .login-box h2 {
            margin-bottom: 20px;
            text-align: center;
        }
        .login-box input[type="text"],
        .login-box input[type="password"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .login-box input[type="submit"] {
            width: 100%;
            padding: 10px;
            margin-top: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .login-box input[value="Login"] {
            background-color: #4285f4;
            color: white;
        }
        .login-box input[value="Login"]:hover {
            background-color: #357ae8;
        }
        .login-box input[value="SignUp"] {
            background-color: #34a853;
            color: white;
        }
        .login-box input[value="SignUp"]:hover {
            background-color: #2e8b3d;
        }
        .message {
            text-align: center;
            margin-top: 10px;
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
    <form action="signin" method="post">
        <input type="text" name="username" placeholder="Username" required />
        <input type="password" name="password" placeholder="Password" required />
        <input type="submit" value="Login" />
        <input type="submit" value="SignUp" onclick="window.location.href='signUp.jsp'"/>
    </form>
</div>
</body>
</html>
