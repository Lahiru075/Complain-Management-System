<%--
  Created by IntelliJ IDEA.
  User: Lahiru Lakshan
  Date: 13/06/2025
  Time: 10:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="lk.ijse.gdse.Dao.EmployeeDao" %>
<%@ page import="lk.ijse.gdse.Model.EmployeeAndAdminModel" %>
<%@ page import="jakarta.annotation.Resource" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.xml.transform.Result" %>
<%@ page import="java.sql.ResultSet" %>


<html>
<head>
    <title>User Dashboard - Complaint Management System</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 0;
            margin: 0;
        }

        .container {
            width: 100%;
            margin: 0;
            background: rgba(231, 241, 250, 0.95);
            border-radius: 0;
            box-shadow: none;
            overflow: hidden;
            min-height: 100vh;
        }

        .header {
            background: linear-gradient(135deg, #2c3e50, #3498db);
            color: white;
            padding: 20px;
            position: relative;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            text-align: center;
            overflow: hidden;
        }

        .header h1 {
            font-size: 2.5em;
            margin-bottom: 10px;
        }

        .header p {
            opacity: 0.9;
            font-size: 1.1em;
        }

        .main-content {
            padding: 40px;
        }

        .form-section {
            background: linear-gradient(135deg, #ffffff, #f8f9fa);
            border-radius: 20px;
            padding: 40px;
            margin-bottom: 40px;
            border: 2px solid #e3f2fd;
            box-shadow: 0 15px 35px rgba(52, 152, 219, 0.1);
            position: relative;
            overflow: hidden;
        }

        .form-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #3498db, #2980b9, #1abc9c);
        }

        .form-section h2 {
            color: #2c3e50;
            margin-bottom: 25px;
            font-size: 1.8em;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #34495e;
            font-size: 1.1em;
        }

        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 15px;
            border: 2px solid #e1e8ed;
            border-radius: 10px;
            font-size: 1em;
            transition: all 0.3s ease;
        }

        .form-group input:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
        }

        .form-group textarea {
            min-height: 120px;
            resize: vertical;
        }

        .button-group {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
            margin-top: 25px;
        }

        .btn {
            padding: 12px 25px;
            border: none;
            border-radius: 8px;
            font-size: 1em;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #2980b9, #21618c);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.3);
        }

        .btn-warning {
            background: linear-gradient(135deg, #f39c12, #e67e22);
            color: white;
        }

        .btn-warning:hover {
            background: linear-gradient(135deg, #e67e22, #d35400);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(243, 156, 18, 0.3);
        }

        .btn-danger {
            background: linear-gradient(135deg, #e74c3c, #c0392b);
            color: white;
        }

        .btn-danger:hover {
            background: linear-gradient(135deg, #c0392b, #a93226);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(231, 76, 60, 0.3);
        }

        .btn-secondary {
            background: linear-gradient(135deg, #95a5a6, #7f8c8d);
            color: white;
        }

        .btn-secondary:hover {
            background: linear-gradient(135deg, #7f8c8d, #6c7b7d);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(149, 165, 166, 0.3);
        }

        .table-section {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.08);
        }

        .table-section h2 {
            background: linear-gradient(135deg, #34495e, #2c3e50);
            color: white;
            padding: 20px 30px;
            margin: 0;
            font-size: 1.8em;
        }

        .table-container {
            overflow-x: auto;
            padding: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #e1e8ed;
        }

        th {
            background: #f8f9fa;
            font-weight: 600;
            color: #2c3e50;
            font-size: 1.1em;
        }

        tr:hover {
            background-color: #f8f9fa;
        }

        .status {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.9em;
            font-weight: 600;
            text-transform: uppercase;
        }

        .status {
            padding: 8px 15px;
            border-radius: 25px;
            font-size: 0.85em;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-pending {
            background: #fff3cd;
            color: #856404;
            border: 1px solid #ffeaa7;
        }

        .status-resolved {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .status-in_progress {
            background: #cde3f8;
            color: #004085;
            border: 1px solid #99ccff;
        }

        .no-data {
            text-align: center;
            padding: 40px;
            color: #6c757d;
            font-style: italic;
            font-size: 1.1em;
        }

        .welcome-message {
            background: linear-gradient(135deg, #e8f5e8, #f0f8ff);
            border: 1px solid #28a745;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 30px;
            color: #155724;
        }

        .logout-btn {
            position: absolute;
            top: 50%;
            right: 20px;
            transform: translateY(-50%);
            background: rgba(255,255,255,0.15);
            backdrop-filter: blur(10px);
            border: 2px solid rgba(255,255,255,0.3);
            color: white;
            padding: 12px 25px;
            border-radius: 25px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .logout-btn:hover {
            background: rgba(255,255,255,0.25);
            border-color: rgba(255,255,255,0.5);
            transform: translateY(-50%) translateY(-2px);
            box-shadow: 0 6px 20px rgba(0,0,0,0.15);
        }

        .logout-btn:active {
            transform: translateY(-50%) translateY(0px);
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        @media (max-width: 768px) {
            .container {
                margin: 10px;
                border-radius: 15px;
            }

            .main-content {
                padding: 20px;
            }

            .button-group {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }

            .header h1 {
                font-size: 2em;
            }

            table {
                font-size: 0.9em;
            }

            th, td {
                padding: 10px 8px;
            }
        }
    </style>
</head>
<body>
<div class="container">

    <%
        String msg = (String) session.getAttribute("msg");
        if (msg != null) {
    %>
    <script>
        alert("<%= msg %>");
    </script>
    <%
            session.removeAttribute("msg");
        }
    %>
    <!-- Header Section -->
    <div class="header">
        <h1>🎯 User Dashboard</h1>
        <p>Complaint Management System</p>
        <form action="${pageContext.request.contextPath}/logout" method="post">
            <button class="logout-btn" type="submit">
                <span class="logout-icon">🚪</span>
                Logout
            </button>
        </form>
    </div>

    <div class="main-content">
        <!-- Welcome Message -->
        <div class="welcome-message">
            <div class="user-info">
                Welcome, <%= session.getAttribute("username") != null ? session.getAttribute("username") : "Employee" %>
            </div>
            <h3>👋 Welcome back!</h3>
            <p>You can submit new complaints and manage your existing ones from this dashboard.</p>
        </div>

        <!-- Complaint Form Section -->
        <div class="form-section">
            <h2>📝 Submit New Complaint</h2>
            <form action="${pageContext.request.contextPath}/employee" method="post">
                <div class="form-group">
                    <input type="hidden" name="complaint_id" id="complaint_id" value="">
                    <label for="title">📋 Complaint Title:</label>
                    <input type="text" id="title" name="title" placeholder="Enter complaint title..." required>
                </div>

                <div class="form-group">
                    <label for="description">📄 Complaint Description:</label>
                    <textarea id="description" name="description" placeholder="Describe your complaint in detail..." required></textarea>
                </div>

                <div class="button-group">
                    <button type="submit" name="action" value="add" id="addBtn" class="btn btn-primary">
                        ➕ Add Complaint
                    </button>
                    <button type="submit" name="action" value="update" id="updateBtn" class="btn btn-warning">
                        ✏️ Update Complaint
                    </button>
                    <button type="submit" name="action" value="delete" id="deleteBtn" class="btn btn-danger">
                        🗑️ Delete Complaint
                    </button>
                    <button type="button" onclick="clearForm()" class="btn btn-secondary">
                        🧹 Clear Form
                    </button>
                </div>

                <!-- Hidden field for complaint ID (used for update/delete) -->
                <input type="hidden" id="complaintId" name="complaintId" value="">
            </form>
        </div>

        <!-- Complaints Table Section -->
        <div class="table-section">
            <h2>📊 My Complaints</h2>
            <div class="table-container">
                <table>
                    <thead>
                    <tr>
                        <th>🆔 ID</th>
                        <th>👤 User ID</th>
                        <th>✏ Remark</th>
                        <th>📋 Title</th>
                        <th>📄 Description</th>
                        <th>📊 Status</th>
                        <th>📅 Created At</th>
                        <th>🔄 Updated At</th>
                    </tr>
                    </thead>
                    <tbody>

                    <%
                        List<EmployeeAndAdminModel> complaintList = (List<EmployeeAndAdminModel>) request.getAttribute("complains");
                        if (complaintList != null && !complaintList.isEmpty()) {
                            for (EmployeeAndAdminModel c : complaintList) {
                    %>
                    <tr onclick="selectComplaint('<%= c.getComplain_id() %>', '<%= c.getTitle() %>', '<%= c.getDescription() %>')">
                        <td><%= c.getComplain_id() %></td>
                        <td><%= c.getUser_id() %></td>
                        <td><%= c.getRemark() %></td>
                        <td><%= c.getTitle() %></td>
                        <td><%= c.getDescription() %></td>
                        <td>
                            <span class="status status-<%= c.getStatus().toLowerCase().replace(" ", "-") %>">
                                <%= c.getStatus() %>
                            </span>
                        </td>
                        <td><%= c.getCreated_at() %></td>
                        <td><%= c.getUpdated_at() %></td>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr><td colspan="7" class="no-data">No complaints found.</td></tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>

            </div>
        </div>

    </div>
</div>

<script>



    function clearForm() {
        document.getElementById('title').value = '';
        document.getElementById('description').value = '';
        document.getElementById('complaintId').value = '';
    }

    function selectComplaint(id, title, description) {
        document.getElementById('complaint_id').value = id;
        document.getElementById('title').value = title;
        document.getElementById('description').value = description;
        document.getElementById('updateBtn').disabled = false;
        document.getElementById('deleteBtn').disabled = false;

        document.querySelector('.form-section').scrollIntoView({ behavior: 'smooth' });

    }

</script>
</body>
</html>