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
import java.sql.SQLException;

@WebServlet("/signup")
public class SignUpServlet extends HttpServlet {

    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {

            System.out.println("lksjdf;ajdf;lkajsd;flkjas;ldkfjas;ldkfj;d");

            String username = req.getParameter("username");
            String password = req.getParameter("password");
            String role = req.getParameter("role");
            String full_name = req.getParameter("full_name");

            Connection connection = dataSource.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO users (username, password, role, full_name) VALUES (?, ?, ?, ?)");
            preparedStatement.setString(1, username);
            preparedStatement.setString(2, password);
            preparedStatement.setString(3, role);
            preparedStatement.setString(4, full_name);
            preparedStatement.executeUpdate();
            resp.sendRedirect(req.getContextPath() + "/View/signIn.jsp?success=true");

            System.out.println(req.getContextPath());


        } catch (SQLException e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/View/signUp.jsp?success=true");

            System.out.println(req.getContextPath());

        }
    }
}
