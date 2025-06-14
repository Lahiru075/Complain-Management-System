<%--
  Created by IntelliJ IDEA.
  User: Lahiru Lakshan
  Date: 13/06/2025
  Time: 11:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="lk.ijse.gdse.Dao.AdminDao" %>
<%@ page import="lk.ijse.gdse.Model.EmployeeAndAdminModel" %>
<%@ page import="jakarta.annotation.Resource" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.xml.transform.Result" %>
<%@ page import="java.sql.ResultSet" %>

<html>
<head>
    <title>Admin Dashboard - Complaint Management System</title>
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
            background: rgba(245, 247, 250, 0.95);
            border-radius: 0;
            box-shadow: none;
            overflow: hidden;
            min-height: 100vh;
        }

        .header {
            background: linear-gradient(135deg, #8e44ad, #e74c3c);
            color: white;
            padding: 30px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .header::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            animation: shimmer 3s infinite;
        }

        @keyframes shimmer {
            0% { left: -100%; }
            100% { left: 100%; }
        }

        .header h1 {
            font-size: 2.8em;
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }

        .header p {
            opacity: 0.9;
            font-size: 1.2em;
        }

        .admin-badge {
            position: absolute;
            top: 20px;
            right: 30px;
            background: rgba(255,255,255,0.2);
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 0.9em;
            backdrop-filter: blur(10px);
        }

        .main-content {
            padding: 40px;
        }

        .stats-section {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }

        .stat-card {
            background: linear-gradient(135deg, #ffffff, #f8f9fa);
            border-radius: 20px;
            padding: 30px;
            text-align: center;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
            transition: transform 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #e74c3c, #f39c12, #27ae60);
        }

        .stat-number {
            font-size: 3em;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .stat-label {
            color: #7f8c8d;
            font-size: 1.1em;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .pending { color: #f39c12; }
        .resolved { color: #27ae60; }
        .in-progress { color: #3498db; }
        .total { color: #8e44ad; }

        .form-section {
            background: linear-gradient(135deg, #ffffff, #f8f9fa);
            border-radius: 20px;
            padding: 40px;
            margin-bottom: 40px;
            border: 2px solid #e8ecf3;
            box-shadow: 0 15px 35px rgba(142, 68, 173, 0.1);
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
            background: linear-gradient(90deg, #8e44ad, #e74c3c, #f39c12);
        }

        .form-section h2 {
            color: #2c3e50;
            margin-bottom: 25px;
            font-size: 1.8em;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 20px;
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
        .form-group textarea,
        .form-group select {
            width: 100%;
            padding: 15px;
            border: 2px solid #e1e8ed;
            border-radius: 10px;
            font-size: 1em;
            transition: all 0.3s ease;
        }

        .form-group input:focus,
        .form-group textarea:focus,
        .form-group select:focus {
            outline: none;
            border-color: #8e44ad;
            box-shadow: 0 0 0 3px rgba(142, 68, 173, 0.1);
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
            background: linear-gradient(135deg, #8e44ad, #9b59b6);
            color: white;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #9b59b6, #8e44ad);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(142, 68, 173, 0.3);
        }

        .btn-success {
            background: linear-gradient(135deg, #27ae60, #2ecc71);
            color: white;
        }

        .btn-success:hover {
            background: linear-gradient(135deg, #2ecc71, #27ae60);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(39, 174, 96, 0.3);
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
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
        }

        .table-section h2 {
            background: linear-gradient(135deg, #34495e, #2c3e50);
            color: white;
            padding: 25px 30px;
            margin: 0;
            font-size: 1.8em;
        }

        .table-container {
            overflow-x: auto;
            padding: 25px;
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
            cursor: pointer;
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
            padding: 60px;
            color: #6c757d;
            font-style: italic;
            font-size: 1.2em;
        }

        .welcome-message {
            background: linear-gradient(135deg, #fff5f5, #f0f8ff);
            border: 2px solid #8e44ad;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 30px;
            color: #2c3e50;
        }

        .user-info {
            font-size: 1.1em;
            font-weight: 600;
            color: #8e44ad;
            margin-bottom: 10px;
        }

        .filter-section {
            background: linear-gradient(135deg, #ecf0f1, #bdc3c7);
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 25px;
            display: flex;
            gap: 15px;
            align-items: center;
            flex-wrap: wrap;
        }

        .filter-group {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .filter-group label {
            font-weight: 600;
            color: #2c3e50;
        }

        .filter-group select {
            padding: 8px 12px;
            border: 1px solid #bdc3c7;
            border-radius: 5px;
            background: white;
        }

        @media (max-width: 768px) {
            .stats-section {
                grid-template-columns: 1fr;
            }

            .form-row {
                grid-template-columns: 1fr;
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

            .admin-badge {
                position: static;
                margin-top: 10px;
                display: inline-block;
            }

            table {
                font-size: 0.9em;
            }

            th, td {
                padding: 10px 8px;
            }

            .filter-section {
                flex-direction: column;
                align-items: stretch;
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
        <div class="admin-badge">👑 ADMIN PANEL</div>
        <h1>🛡️ Admin Dashboard</h1>
        <p>Complaint Management System - Administrative Control</p>
    </div>

    <div class="main-content">
        <!-- Welcome Message -->
        <div class="welcome-message">
            <div class="user-info">
                Welcome, <%= session.getAttribute("username") != null ? session.getAttribute("username") : "Administrator" %>
            </div>
            <h3>👋 Welcome to Admin Dashboard!</h3>
            <p>Manage all complaints, update statuses, and oversee the complaint resolution process.</p>
        </div>

        <!-- Statistics Section -->
        <div class="stats-section">
            <div class="stat-card">
                <div class="stat-number total">24</div>
                <div class="stat-label">Total Complaints</div>
            </div>
            <div class="stat-card">
                <div class="stat-number pending">8</div>
                <div class="stat-label">Pending</div>
            </div>
            <div class="stat-card">
                <div class="stat-number in-progress">6</div>
                <div class="stat-label">In Progress</div>
            </div>
            <div class="stat-card">
                <div class="stat-number resolved">10</div>
                <div class="stat-label">Resolved</div>
            </div>
        </div>

        <!-- Complaint Management Form Section -->
        <div class="form-section">
            <h2>🔧 Manage Complaint</h2>
            <form action="${pageContext.request.contextPath}/admin" method="post">
                <input type="hidden" name="complaint_id" id="complaint_id" value="">
                <input type="hidden" name="created_at" id="created_at" value="">

                <div class="form-row">
                    <div class="form-group">
                        <label for="user_id">👤 User ID:</label>
                        <input type="text" id="user_id" name="user_id" placeholder="User ID..." readonly>
                    </div>
                    <div class="form-group">
                        <label for="status">📊 Status:</label>
                        <select id="status" name="status" required>
                            <option value="PENDING">Pending</option>
                            <option value="IN_PROGRESS">In Progress</option>
                            <option value="RESOLVED">Resolved</option>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label for="title">📋 Complaint Title:</label>
                    <input type="text" id="title" name="title" placeholder="Complaint title..." readonly>
                </div>

                <div class="form-group">
                    <label for="description">📄 Complaint Description:</label>
                    <textarea id="description" name="description" placeholder="Complaint description..." readonly></textarea>
                </div>

                <div class="form-group">
                    <label for="remark">💬 Admin Remark:</label>
                    <textarea id="remark" name="remark" placeholder="Add your remarks here..." required></textarea>
                </div>

                <div class="button-group">
                    <button type="submit" name="action" value="update" id="updateBtn" class="btn btn-success">
                        ✅ Update Status
                    </button>
                    <button type="submit" name="action" value="delete" id="deleteBtn" class="btn btn-danger">
                        🗑️ Delete Complaint
                    </button>
                    <button type="button" onclick="clearForm()" class="btn btn-secondary">
                        🧹 Clear Form
                    </button>
                </div>
            </form>
        </div>

        <!-- Filter Section -->
        <div class="filter-section">
            <div class="filter-group">
                <label for="statusFilter">🔍 Filter by Status:</label>
                <select id="statusFilter">
                    <option value="PENDING">Pending</option>
                    <option value="IN_PROGRESS">In Progress</option>
                    <option value="RESOLVED">Resolved</option>
                </select>
            </div>
            <div class="filter-group">
                <label for="userFilter">👤 Filter by User:</label>
                <input type="text" id="userFilter" placeholder="Enter User ID..." onkeyup="filterTable()">
            </div>
        </div>

        <!-- All Complaints Table Section -->
        <div class="table-section">
            <h2>📊 All System Complaints</h2>
            <div class="table-container">
                <table id="complaintsTable">
                    <thead>
                    <tr>
                        <th>🆔 ID</th>
                        <th>👤 User ID</th>
                        <th>📋 Title</th>
                        <th>📄 Description</th>
                        <th>💬 Remark</th>
                        <th>📊 Status</th>
                        <th>📅 Created At</th>
                        <th>🔄 Updated At</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        List<EmployeeAndAdminModel> complaintList = (List<EmployeeAndAdminModel>) request.getAttribute("complaints");
                        if (complaintList != null && !complaintList.isEmpty()) {
                            for (EmployeeAndAdminModel c : complaintList) {
                    %>
                    <tr onclick="selectComplaint('<%= c.getComplain_id() %>', '<%= c.getUser_id() %>', '<%= c.getTitle() %>', '<%= c.getDescription() %>', '<%= c.getRemark() %>', '<%= c.getStatus() %>', '<%= c.getCreated_at() %>')">
                        <td><%= c.getComplain_id() %></td>
                        <td><%= c.getUser_id() %></td>
                        <td><%= c.getTitle() %></td>
                        <td><%= c.getDescription() %></td>
                        <td><%= c.getRemark() != null ? c.getRemark() : "No remark" %></td>
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
                    <tr><td colspan="8" class="no-data">📭 No complaints found in the system.</td></tr>
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
        document.getElementById('complaint_id').value = '';
        document.getElementById('user_id').value = '';
        document.getElementById('title').value = '';
        document.getElementById('description').value = '';
        document.getElementById('remark').value = '';
        document.getElementById('status').value = '';
        document.getElementById('updateBtn').disabled = false;
        document.getElementById('deleteBtn').disabled = false;
    }

    function selectComplaint(id, userId, title, description, remark, status, created_at) {
        document.getElementById('complaint_id').value = id;
        document.getElementById('user_id').value = userId;
        document.getElementById('title').value = title;
        document.getElementById('description').value = description;
        document.getElementById('remark').value = remark || '';
        document.getElementById('status').value = status;
        document.getElementById('created_at').value = created_at;
        document.getElementById('updateBtn').disabled = false;
        document.getElementById('deleteBtn').disabled = false;

        // Scroll to form
        document.querySelector('.form-section').scrollIntoView({ behavior: 'smooth' });
    }


</script>
</body>
</html>