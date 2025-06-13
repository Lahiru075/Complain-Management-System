package lk.ijse.gdse.Dao;

import lk.ijse.gdse.Model.EmployeeModel;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class EmployeeDao {
    private DataSource dataSource;

    public EmployeeDao(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    public int saveComplain(EmployeeModel complainModel) throws SQLException {
        Connection connection = dataSource.getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO complaints (user_id, title, description) VALUES (?, ?, ?)");
        preparedStatement.setInt(1, complainModel.getUser_id());
        preparedStatement.setString(2, complainModel.getTitle());
        preparedStatement.setString(3, complainModel.getDescription());
        int result = preparedStatement.executeUpdate();

        if (result > 0) {
            return 1;
        }else {
            return 0;
        }
    }

    public List<EmployeeModel> getAllComplains() throws SQLException {
        List<EmployeeModel> complaints = new ArrayList<>();
        String sql = "SELECT * FROM complaints";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                EmployeeModel complain = new EmployeeModel();
                complain.setComplain_id(resultSet.getInt("complaint_id"));
                complain.setUser_id(resultSet.getInt("user_id"));
                complain.setTitle(resultSet.getString("title"));
                complain.setDescription(resultSet.getString("description"));
                complain.setStatus(resultSet.getString("status"));
                complain.setCreated_at(resultSet.getString("created_at"));
                complain.setUpdated_at(resultSet.getString("updated_at"));

                complaints.add(complain);
            }
        }
        return complaints;
    }
}
