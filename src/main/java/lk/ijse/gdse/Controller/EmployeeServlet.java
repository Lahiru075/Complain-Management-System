package lk.ijse.gdse.Controller;

import jakarta.annotation.Resource;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import lk.ijse.gdse.Dao.EmployeeDao;
import lk.ijse.gdse.Model.EmployeeModel;

import javax.sql.DataSource;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.Principal;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

@WebServlet("/employee")
public class EmployeeServlet extends HttpServlet {

    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

//        System.out.println("This is post method");
//
//        try {
//
//            String title = req.getParameter("title");
//            String description = req.getParameter("description");
//
//            EmployeeModel complainModel = new EmployeeModel();
//            complainModel.setTitle(title);
//            complainModel.setDescription(description);
//            String userIdStr = (String) req.getSession().getAttribute("user_id");
//            int userId = Integer.parseInt(userIdStr);
//            complainModel.setUser_id(userId);
//
//            int result = new EmployeeDao(this.dataSource).saveComplain(complainModel);
//
//            if (result > 0) {
//                req.setAttribute("msg", "Complain saved successfully!");
//            } else {
//                req.setAttribute("msg", "Failed to save complain!");
//            }
//
////            req.getRequestDispatcher("View/userDashboard.jsp?success=true").forward(req,resp);
//            resp.sendRedirect("employee");
//
//        } catch (SQLException e) {
//            throw new RuntimeException(e);
//        }

        String action = req.getParameter("action");

        try {
            EmployeeDao employeeDao = new EmployeeDao(dataSource);
            String userIdStr = (String) req.getSession().getAttribute("user_id");
            int userId = Integer.parseInt(userIdStr);

            if ("add".equals(action)) {
                String title = req.getParameter("title");
                String description = req.getParameter("description");

                EmployeeModel employeeModel = new EmployeeModel();
                employeeModel.setTitle(title);
                employeeModel.setDescription(description);
                employeeModel.setUser_id(userId);

                int result = employeeDao.saveComplaint(employeeModel);
                if (result > 0) {
                    req.setAttribute("message", "Complain added successfully");
                } else {
                    req.setAttribute("message", "Failed to add complaint");
                }
            } else if ("update".equals(action)) {
                int complaintId = Integer.parseInt(req.getParameter("complaint_id"));
                String title = req.getParameter("title");
                String description = req.getParameter("description");

                EmployeeModel employeeModel = new EmployeeModel();
                employeeModel.setComplain_id(complaintId);
                employeeModel.setTitle(title);
                employeeModel.setDescription(description);
                employeeModel.setUser_id(userId);

                int result = employeeDao.updateComplaint(employeeModel);
                if (result > 0) {
                    req.setAttribute("message", "Complaint updated successfully");
                } else {
                    req.setAttribute("message", "Failed to update complaint");
                }
            } else if ("delete".equals(action)) {
                int complaintId = Integer.parseInt(req.getParameter("complaint_id"));
                int result = employeeDao.deleteComplaint(complaintId);
                if (result > 0) {
                    req.setAttribute("message", "Complaint deleted successfully");
                } else {
                    req.setAttribute("message", "Failed to delete complaint");
                }
            }

            resp.sendRedirect("employee");

        } catch (SQLException e) {
            throw new ServletException("Database error: " + e.getMessage(), e);
        }


    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("This is get method");

        String userIdStr = (String) req.getSession().getAttribute("user_id");
        int userId = Integer.parseInt(userIdStr);


        try {
            List<EmployeeModel> complaints = new EmployeeDao(this.dataSource).getAllComplains(userId);

            req.setAttribute("complains", complaints);
            req.getRequestDispatcher("View/userDashboard.jsp").forward(req, resp);

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
