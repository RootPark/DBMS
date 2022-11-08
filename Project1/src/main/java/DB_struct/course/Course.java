package DB_struct.course;

public class Course {
    private String Course_id;
    private String Name;
    private String Credit;

    public String getCourse_id(){
        return Course_id;
    }
    public void setCourse_id(String course_id){
        Course_id = course_id;
    }

    public String getName(){
        return Name;
    }
    public void setName(String name){
        Name = name;
    }

    public String getCredit(){
        return Credit;
    }
    public void setCredit(String credit){
        Credit = credit;
    }
}
