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

        System.out.println("This is post method");

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

//            req.getRequestDispatcher("View/userDashboard.jsp?success=true").forward(req,resp);
            resp.sendRedirect("employee");

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

//    @Override
//    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        List<EmployeeModel> complaints = new ArrayList<>();
//
//        System.out.println("This is get method");
//
//        try {
//            ResultSet resultSet = new EmployeeDao(this.dataSource).getAllComplains();
//
//            while (resultSet.next()) {
//                EmployeeModel complain = new EmployeeModel();
//                complain.setComplain_id(resultSet.getInt("complaint_id"));
//                complain.setUser_id(resultSet.getInt("user_id"));
//                complain.setTitle(resultSet.getString("title"));
//                complain.setDescription(resultSet.getString("description"));
//                complain.setStatus(resultSet.getString("status"));
//                complain.setCreated_at(resultSet.getString("created_at"));
//                complain.setUpdated_at(resultSet.getString("updated_at"));
//
//                complaints.add(complain);
//            }
//
//            req.setAttribute("complains", complaints);
//            req.getRequestDispatcher("View/userDashboard.jsp").forward(req,resp);
//
//        } catch (SQLException e) {
//            throw new RuntimeException(e);
//        }
//
//    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("This is get method");

        try {
            List<EmployeeModel> complaints = new EmployeeDao(this.dataSource).getAllComplains();

            req.setAttribute("complains", complaints);
            req.getRequestDispatcher("View/userDashboard.jsp").forward(req, resp);

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
