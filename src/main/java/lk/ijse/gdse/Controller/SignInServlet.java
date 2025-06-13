package lk.ijse.gdse.Controller;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/signin")
public class SignInServlet extends HttpServlet {

    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            String username = req.getParameter("username");
            String password = req.getParameter("password");

            Connection connection = dataSource.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM users WHERE username = ? AND password = ?");
            preparedStatement.setString(1, username);
            preparedStatement.setString(2, password);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                String role = resultSet.getString("role");
                req.getSession().setAttribute("username", username);
                if ("ADMIN".equals(role)) {
//                    resp.sendRedirect(req.getContextPath() + "/View/adminDashboard.jsp?success=true");
                    req.getRequestDispatcher("View/adminDashboard.jsp?success=true").forward(req,resp);
                } else {
//                    resp.sendRedirect(req.getContextPath() + "/View/userDashboard.jsp?success=true");
                    req.getRequestDispatcher("View/userDashboard.jsp?success=true").forward(req,resp);
                }
            } else {
//                resp.sendRedirect(req.getContextPath() + "/View/signIn.jsp?error=true");
                req.getRequestDispatcher("View/signIn.jsp?error=true").forward(req,resp);
            }
        } catch (SQLException e) {
            e.printStackTrace();
//            resp.sendRedirect(req.getContextPath() + "/View/signIn.jsp?error=true");
            req.getRequestDispatcher("View/signIn.jsp?error=true").forward(req,resp);
        }
    }
}