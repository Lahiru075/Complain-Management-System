package lk.ijse.gdse.Model;

public class EmployeeAndAdminModel {
    private int complain_id;
    private String status;
    private String title;
    private String description;
    private int user_id;
    private String created_at;
    private String updated_at;
    private String remark;

    public EmployeeAndAdminModel(int complain_id, String status, String title, String description, int user_id, String created_at, String updated_at, String remark) {
        this.complain_id = complain_id;
        this.status = status;
        this.title = title;
        this.description = description;
        this.user_id = user_id;
        this.created_at = created_at;
        this.updated_at = updated_at;
        this.remark = remark;
    }

    public EmployeeAndAdminModel() {
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public int getComplain_id() {
        return complain_id;
    }

    public void setComplain_id(int complain_id) {
        this.complain_id = complain_id;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getCreated_at() {
        return created_at;
    }

    public void setCreated_at(String created_at) {
        this.created_at = created_at;
    }

    public String getUpdated_at() {
        return updated_at;
    }

    public void setUpdated_at(String updated_at) {
        this.updated_at = updated_at;
    }
}
