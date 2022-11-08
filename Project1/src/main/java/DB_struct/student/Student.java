package DB_struct.student;

public class Student {
    private String Student_id;
    private String Password;
    private String Name;
    private String Sex;
    private String Major_id;
    private String Lecturer_id;
    private String Year;

    public String getStudent_id(){
        return Student_id;
    }
    public void setStudent_id(String student_id){
        Student_id = student_id;
    }


    public String getPassword(){
        return Password;
    }
    public void setPassword(String password){
        Password = password;
    }

    public String getName(){
        return Name;
    }
    public void setName(String name){
        Name = name;
    }

    public String getSex(){
        return Sex;
    }
    public void setSex(String sex){
        Sex = sex;
    }

    public String getMajor_id(){
        return Major_id;
    }
    public void setMajor_id(String major_id){
        Major_id = major_id;
    }

    public String getLecturer_id(){
        return Lecturer_id;
    }
    public void setLecturer_id(String lecturer_id){
        Lecturer_id = lecturer_id;
    }

    public String getYear(){
        return Year;
    }
    public void setYear(String year){
        Year = year;
    }

}
