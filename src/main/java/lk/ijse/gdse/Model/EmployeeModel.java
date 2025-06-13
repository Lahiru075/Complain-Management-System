package lk.ijse.gdse.Model;

public class EmployeeModel {
    private String title;
    private String description;
    private int user_id;

    public EmployeeModel(String title, String description, int user_id) {
        this.title = title;
        this.description = description;
        this.user_id = user_id;
    }

    public EmployeeModel() {
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
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
}
