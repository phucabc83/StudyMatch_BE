package microservice.service.model;

public class UserDTO {
    private Long id;
    private String fullName;
    private String styleLearn;

    public UserDTO(Long id, String username, String styleLearn) {
        this.id = id;
        this.fullName = username;
        this.styleLearn = styleLearn;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getStyleLearn() {
        return styleLearn;
    }

    public void setStyleLearn(String styleLearn) {
        this.styleLearn = styleLearn;
    }


// Getters and Setters
}
