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
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 420px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .signup-box:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 32px rgba(0, 0, 0, 0.2);
        }

        .signup-box h2 {
            margin-bottom: 30px;
            text-align: center;
            font-size: 28px;
            font-weight: 600;
            color: #1a1a1a;
        }
        .signup-box input[type="text"],
        .signup-box input[type="password"],
        .signup-box select {
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
        .signup-box input[type="text"]:focus,
        .signup-box input[type="password"]:focus,
        .signup-box select:focus {
            border-color: #6366f1;
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
            outline: none;
        }
        .signup-box input[type="submit"] {
            width: 100%;
            padding: 12px;
            margin-top: 12px;
            background-color: #4a90e2;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 500;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }
        .signup-box input[type="submit"]:hover {
            background-color: #357abd;
            color: #ffffff;
        }

        .signup-box input[type="submit"]:hover {
            background-color: #756fe4;
            transform: translateY(-2px);
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
<%--    <form action="<%= request.getContextPath() %>/signup" method="post">--%>
    <form action="${pageContext.request.contextPath}/signup" method="post">
    <input type="text" name="username" placeholder="Username" required />
        <input type="password" name="password" placeholder="Password" required />
        <input type="text" name="full_name" placeholder="Name" required />
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