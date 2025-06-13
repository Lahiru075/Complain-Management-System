package lk.ijse.gdse.Controller;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.gdse.Dao.UserDao;
import lk.ijse.gdse.Model.UserModel;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/signup")
public class SignUpServlet extends HttpServlet {

    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {

            String username = req.getParameter("username");
            String password = req.getParameter("password");
            String role = req.getParameter("role");
            String full_name = req.getParameter("full_name");

            UserModel userModel = new UserModel();
            userModel.setUsername(username);
            userModel.setPassword(password);
            userModel.setRole(role);
            userModel.setFull_name(full_name);

            int result = new UserDao(this.dataSource).saveUser(userModel);

            if (result > 0) {
                req.getRequestDispatcher("View/signIn.jsp?success=true").forward(req,resp);
            } else {
                req.getRequestDispatcher("View/signUp.jsp?error=true").forward(req,resp);
            }



        } catch (SQLException e) {
            e.printStackTrace();
//            resp.sendRedirect(req.getContextPath() + "/View/signUp.jsp?success=true");
            req.getRequestDispatcher("View/signUp.jsp?error=true").forward(req,resp);

        }
    }
}
