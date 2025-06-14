package lk.ijse.gdse.Dao;

import lk.ijse.gdse.Model.EmployeeAndAdminModel;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AdminDao {
    private DataSource dataSource;

    public AdminDao(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    public List<EmployeeAndAdminModel> getAllComplainsForAdmin() throws SQLException {
        List<EmployeeAndAdminModel> complaints = new ArrayList<>();

        try (Connection connection = dataSource.getConnection()) {

            PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM complaints");
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
        try (Connection connection = dataSource.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement("UPDATE complaints SET user_id = ?, title = ?, description = ?, status = ?, created_at = ?, remark = ? WHERE complaint_id = ?");

            System.out.println(employeeModel.getCreated_at());

            preparedStatement.setInt(1, employeeModel.getUser_id());
            preparedStatement.setString(2, employeeModel.getTitle());
            preparedStatement.setString(3, employeeModel.getDescription());
            preparedStatement.setString(4, employeeModel.getStatus());
            preparedStatement.setString(5, employeeModel.getCreated_at());
            preparedStatement.setString(6, employeeModel.getRemark());
            preparedStatement.setInt(7, employeeModel.getComplain_id());

            return preparedStatement.executeUpdate();


        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public int deleteComplaint(int complaintId) {
        try (Connection connection = dataSource.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement("DELETE FROM complaints WHERE complaint_id = ?");
            preparedStatement.setInt(1, complaintId);
            return preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
