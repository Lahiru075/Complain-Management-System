<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sign Up</title>
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
        .signup-box {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            width: 400px;
            text-align: center;
        }
        .signup-box h2 {
            margin-bottom: 25px;
            color: #333;
            font-size: 24px;
        }
        .signup-box input[type="text"],
        .signup-box input[type="password"],
        .signup-box select {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 6px;
            box-sizing: border-box;
            font-size: 14px;
            transition: border-color 0.3s ease;
        }
        .signup-box input[type="text"]:focus,
        .signup-box input[type="password"]:focus,
        .signup-box select:focus {
            border-color: #4a90e2;
            outline: none;
        }
        .signup-box input[type="submit"] {
            width: 100%;
            padding: 12px;
            background-color: #4a90e2;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }
        .signup-box input[type="submit"]:hover {
            background-color: #357abd;
        }
        .message {
            text-align: center;
            margin-top: 10px;
        }
    </style>
</head>
<body>
<div class="signup-box">
    <h2>Sign Up</h2>
    <%
        String error = request.getParameter("error");
        if ("true".equals(error)) {
    %>
    <div class="message" style="color: red;">Error registering user.</div>
    <%
        }
    %>
    <form action="signup" method="post">
        <input type="text" name="username" placeholder="Username" required />
        <input type="password" name="password" placeholder="Password" required />
        <select name="role" required>
            <option value="" disabled selected>Select Role</option>
            <option value="Employee">Employee</option>
            <option value="Admin">Admin</option>
        </select>
        <input type="submit" value="Sign Up" />
    </form>
</div>
</body>
</html>