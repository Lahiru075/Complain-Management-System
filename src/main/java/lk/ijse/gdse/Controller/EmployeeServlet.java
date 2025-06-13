package lk.ijse.gdse.Controller;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.gdse.Dao.EmployeeDao;
import lk.ijse.gdse.Model.EmployeeModel;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/employee")
public class EmployeeServlet extends HttpServlet {

    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {

            String title = req.getParameter("title");
            String description = req.getParameter("description");

            EmployeeModel complainModel = new EmployeeModel();
            complainModel.setTitle(title);
            complainModel.setDescription(description);
            String userIdStr = (String) req.getSession().getAttribute("user_id");
            int userId = Integer.parseInt(userIdStr);
            complainModel.setUser_id(userId);

            int result = new EmployeeDao(this.dataSource).saveComplain(complainModel);

            if (result > 0) {
                req.setAttribute("msg", "Complain saved successfully!");
            } else {
                req.setAttribute("msg", "Failed to save complain!");
            }

            req.getRequestDispatcher("View/userDashboard.jsp?success=true").forward(req,resp);

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<EmployeeModel> complaints = new ArrayList<>();
    }
}
