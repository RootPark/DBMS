package DB_struct.lecturer;

public class Lecturer {
    private String Lecturer_id;
    private String Name;
    private String Major_id;

    public String getLecturer_id(){
        return Lecturer_id;
    }
    public void setLecturer_id(String lecturer_id){
        Lecturer_id = lecturer_id;
    }

    public String getName(){
        return Name;
    }
    public void setName(String name){
        Name = name;
    }

    public String getMajor_id(){
        return Major_id;
    }
    public void setMajor_id(String major_id){
        Major_id = major_id;
    }

}
