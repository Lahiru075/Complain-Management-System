package lk.ijse.gdse.Controller;

import jakarta.annotation.Resource;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import lk.ijse.gdse.Dao.EmployeeDao;
import lk.ijse.gdse.Model.EmployeeAndAdminModel;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.SQLException;
import java.util.*;

@WebServlet("/employee")
public class EmployeeServlet extends HttpServlet {

    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String action = req.getParameter("action");

        try {
            EmployeeDao employeeDao = new EmployeeDao(dataSource);
            String userIdStr = (String) req.getSession().getAttribute("user_id");
            int userId = Integer.parseInt(userIdStr);

            if ("add".equals(action)) {
                String title = req.getParameter("title");
                String description = req.getParameter("description");

                EmployeeAndAdminModel employeeModel = new EmployeeAndAdminModel();
                employeeModel.setTitle(title);
                employeeModel.setDescription(description);
                employeeModel.setUser_id(userId);

                int result = employeeDao.saveComplaint(employeeModel);
                if (result > 0) {
                    req.getSession().setAttribute("msg", "Complaint added successfully");
                } else {
                    req.getSession().setAttribute("msg", "Failed to add complaint");
                }
            } else if ("update".equals(action)) {
                int complaintId = Integer.parseInt(req.getParameter("complaint_id"));
                String title = req.getParameter("title");
                String description = req.getParameter("description");

                EmployeeAndAdminModel employeeModel = new EmployeeAndAdminModel();
                employeeModel.setComplain_id(complaintId);
                employeeModel.setTitle(title);
                employeeModel.setDescription(description);
                employeeModel.setUser_id(userId);

                boolean isPending = employeeDao.checkComplaintStates(complaintId);

                if (isPending) {
                    req.getSession().setAttribute("msg", "This complaint already in resolved state.. you can't update");
                } else {
                    int result = employeeDao.updateComplaint(employeeModel);

                    if (result > 0) {
                        req.getSession().setAttribute("msg", "Complaint updated successfully");
                    } else {
                        req.getSession().setAttribute("msg", "Failed to update complaint");
                    }
                }

            } else if ("delete".equals(action)) {
                int complaintId = Integer.parseInt(req.getParameter("complaint_id"));

                boolean isPending = employeeDao.checkComplaintStates(complaintId);

                if (isPending) {
                    req.getSession().setAttribute("msg", "This complaint already in resolved state.. you can't delete");
                } else {
                    int result = employeeDao.deleteComplaint(complaintId);
                    if (result > 0) {
                        req.getSession().setAttribute("msg", "Complaint deleted successfully");
                    } else {
                        req.getSession().setAttribute("msg", "Failed to delete complaint");
                    }
                }
            }

            resp.sendRedirect("employee");

        } catch (SQLException e) {
            throw new ServletException("Database error: " + e.getMessage(), e);
        }


    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String userIdStr = (String) req.getSession().getAttribute("user_id");
        int userId = Integer.parseInt(userIdStr);


        try {
            List<EmployeeAndAdminModel> complaints = new EmployeeDao(this.dataSource).getAllComplains(userId);

            req.setAttribute("complains", complaints);
            req.getRequestDispatcher("View/userDashboard.jsp").forward(req, resp);

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
