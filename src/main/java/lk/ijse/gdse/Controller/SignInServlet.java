package lk.ijse.gdse.Controller;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.ijse.gdse.Dao.UserDao;

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


            ResultSet resultSet = new UserDao(this.dataSource).signIn(username, password);


            if (resultSet.next()) {

                String user_id = resultSet.getString("user_id");

                HttpSession session = req.getSession();
                session.setAttribute("user_id", user_id);

                String role = resultSet.getString("role");
                req.getSession().setAttribute("username", username);
                if ("ADMIN".equals(role)) {
//                    resp.sendRedirect(req.getContextPath() + "/View/adminDashboard.jsp?success=true");
//                    req.getRequestDispatcher("View/adminDashboard.jsp?success=true").forward(req,resp);
                    req.getRequestDispatcher("admin").forward(req, resp);

                } else {
//                    resp.sendRedirect(req.getContextPath() + "/View/userDashboard.jsp?success=true");
//                    req.getRequestDispatcher("View/userDashboard.jsp?success=true").forward(req,resp);
                    req.getRequestDispatcher("employee").forward(req, resp);
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