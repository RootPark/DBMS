package DB_struct.credits;

public class Credits {
    private String Credits_id;
    private String Student_id;
    private String Course_id;
    private String Year;
    private String Grade;

    public String getCredits_id() {
        return Credits_id;
    }
    public void setCredits_id(String credits_id) {
        Credits_id = credits_id;
    }

    public String getStudent_id() {
        return Student_id;
    }
    public void setStudent_id(String student_id) {
        Student_id = student_id;
    }

    public String getCourse_id() {
        return Course_id;
    }
    public void setCourse_id(String course_id) {
        Course_id = course_id;
    }

    public String getYear() {
        return Year;
    }
    public void setYear(String year) {
        Year = year;
    }

    public String getGrade() {
        return Grade;
    }
    public void setGrade(String grade) {
        Grade = grade;
    }
}

