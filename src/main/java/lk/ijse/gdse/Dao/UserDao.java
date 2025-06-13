package lk.ijse.gdse.Dao;

import jakarta.annotation.Resource;
import lk.ijse.gdse.Model.UserModel;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class UserDao {
    private DataSource dataSource;

    public UserDao(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    public int saveUser(UserModel user) throws SQLException {
        Connection connection = dataSource.getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO users (username, password, role, full_name) VALUES (?, ?, ?, ?)");
        preparedStatement.setString(1, user.getUsername());
        preparedStatement.setString(2, user.getPassword());
        preparedStatement.setString(3, user.getRole());
        preparedStatement.setString(4, user.getFull_name());
        int result = preparedStatement.executeUpdate();

        if (result > 0) {
            return 1;
        }else {
            return 0;
        }

    }

}
