package lk.ijse.gdse.Controller;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.gdse.Dao.AdminDao;
import lk.ijse.gdse.Dao.EmployeeDao;
import lk.ijse.gdse.Model.EmployeeAndAdminModel;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet{
    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        AdminDao adminDao = new AdminDao(this.dataSource);

        if ("update".equals(action)) {
            int complaintId = Integer.parseInt(req.getParameter("complaint_id"));
            String title = req.getParameter("title");
            String description = req.getParameter("description");
            String status = req.getParameter("status");
            String remark = req.getParameter("remark");
            int user_id = Integer.parseInt(req.getParameter("user_id"));
            String created_at = req.getParameter("created_at");

            EmployeeAndAdminModel employeeModel = new EmployeeAndAdminModel();
            employeeModel.setComplain_id(complaintId);
            employeeModel.setTitle(title);
            employeeModel.setDescription(description);
            employeeModel.setUser_id(user_id);
            employeeModel.setStatus(status);
            employeeModel.setRemark(remark);
            employeeModel.setCreated_at(created_at);


            int result = adminDao.updateComplaint(employeeModel);
            if (result > 0) {
                req.getSession().setAttribute("msg", "Complaint updated successfully");
            } else {
                req.getSession().setAttribute("msg", "Failed to update complaint");
            }
        } else if ("delete".equals(action)) {

            int complaintId = Integer.parseInt(req.getParameter("complaint_id"));
            int result = adminDao.deleteComplaint(complaintId);
            if (result > 0) {
                req.getSession().setAttribute("msg", "Complaint deleted successfully");
            } else {
                req.getSession().setAttribute("msg", "Failed to delete complaint");
            }
        }

        resp.sendRedirect("admin");

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("This is get method of Admin Servlet");


        try {
            List<EmployeeAndAdminModel> complaints = new AdminDao(this.dataSource).getAllComplainsForAdmin();

            System.out.println(complaints.size());

            req.setAttribute("complaints", complaints);
            req.getRequestDispatcher("View/adminDashboard.jsp").forward(req, resp);

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

}

