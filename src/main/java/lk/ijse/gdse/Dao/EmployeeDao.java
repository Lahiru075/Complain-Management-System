package lk.ijse.gdse.Dao;

import lk.ijse.gdse.Model.EmployeeAndAdminModel;

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

    public int saveComplaint(EmployeeAndAdminModel complainModel) throws SQLException {
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

    public List<EmployeeAndAdminModel> getAllComplains(int userId) throws SQLException {
        List<EmployeeAndAdminModel> complaints = new ArrayList<>();


        try (Connection connection = dataSource.getConnection()) {

            PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM complaints WHERE user_id = ?");
            preparedStatement.setInt(1, userId);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                EmployeeAndAdminModel complain = new EmployeeAndAdminModel();
                complain.setComplain_id(resultSet.getInt("complaint_id"));
                complain.setUser_id(resultSet.getInt("user_id"));
                complain.setTitle(resultSet.getString("title"));
                complain.setDescription(resultSet.getString("description"));
                complain.setStatus(resultSet.getString("status"));
                complain.setCreated_at(resultSet.getString("created_at"));
                complain.setUpdated_at(resultSet.getString("updated_at"));
                complain.setRemark(resultSet.getString("remark"));

                complaints.add(complain);
            }
        }
        return complaints;
    }

    public int updateComplaint(EmployeeAndAdminModel employeeModel) {
        try (Connection connection = dataSource.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement("UPDATE complaints SET title = ?, description = ? WHERE complaint_id = ?")) {
            preparedStatement.setString(1, employeeModel.getTitle());
            preparedStatement.setString(2, employeeModel.getDescription());
            preparedStatement.setInt(3, employeeModel.getComplain_id());
            return preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public int deleteComplaint(int complaintId) {
        try (Connection connection = dataSource.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement("DELETE FROM complaints WHERE complaint_id = ?")) {
            preparedStatement.setInt(1, complaintId);
            return preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean checkComplaintStates(int complaintId) {
        try (Connection connection = dataSource.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement("SELECT status FROM complaints WHERE complaint_id = ?")) {
            preparedStatement.setInt(1, complaintId);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                String status = resultSet.getString("status");
                return status.equals("RESOLVED");
            }

            return false;

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
