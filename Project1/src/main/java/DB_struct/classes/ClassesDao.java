package DB_struct.classes;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class ClassesDao {
    private Connection connection;
    private PreparedStatement preparedStatement;
    private ResultSet resultSet;

    public ClassesDao(){
        try{
            String dbURL = "jdbc:mysql://localhost:3306/project1DB?serverTimezone=Asia/Seoul";
            String dbID = "root";
            String dbPassword = "rmsdnjs518";
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(dbURL,dbID,dbPassword);
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    public ArrayList<Classes> searchClass(String class_id, String course_id, String name){
        String SQL = "SELECT * FROM CLASS ";
        ArrayList<Classes> classesArrayList = new ArrayList<>();
        try{
            if(class_id == "" && course_id == "") {
                SQL += "WHERE name =?";
                preparedStatement = connection.prepareStatement(SQL);
                preparedStatement.setString(1, name);
                resultSet = preparedStatement.executeQuery();
            }
            else if(course_id == "" && name == ""){
                SQL += "WHERE class_id =?";
                preparedStatement = connection.prepareStatement(SQL);
                preparedStatement.setString(1, class_id);
                resultSet = preparedStatement.executeQuery();
            }
            else if(class_id == "" && name == ""){
                SQL += "WHERE course_id =?";
                preparedStatement = connection.prepareStatement(SQL);
                preparedStatement.setString(1, course_id);
                resultSet = preparedStatement.executeQuery();
            }

            while(resultSet.next()) {
                Classes classes = new Classes();
                classes.setClass_id(resultSet.getString(1));
                classes.setClass_no(resultSet.getString(2));
                classes.setCourse_id(resultSet.getString(3));
                classes.setName(resultSet.getString(4));
                classes.setMajor_id(resultSet.getString(5));
                classes.setYear(resultSet.getString(6));
                classes.setCredit(resultSet.getString(7));
                classes.setLecturer_id(resultSet.getString(8));
                classes.setPerson_max(resultSet.getString(9));
                classes.setOpened(resultSet.getString(10));
                classes.setRoom_id(resultSet.getString(11));
                classesArrayList.add(classes);
            }


        } catch (Exception e){
            e.printStackTrace();
        }
        return classesArrayList;
    }

    public int deleteClass(String class_id){
        String SQL = "DELETE FROM CLASS WHERE class_id = ?";
        try{
            preparedStatement = connection.prepareStatement(SQL);
            preparedStatement.setString(1,class_id);
            return preparedStatement.executeUpdate();
        } catch (Exception e){
            e.printStackTrace();
        }
        return -1;
    }

    public int addClass(Classes classes){
        String SQL = "INSERT INTO CLASS VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try{

            preparedStatement = connection.prepareStatement(SQL);
            preparedStatement.setString(1, classes.getClass_id());
            preparedStatement.setString(2,classes.getClass_no());
            preparedStatement.setString(3, classes.getCourse_id());
            preparedStatement.setString(4,classes.getName());
            preparedStatement.setString(5, classes.getMajor_id());
            preparedStatement.setString(6, classes.getYear());
            preparedStatement.setString(7, classes.getCredit());
            preparedStatement.setString(8,classes.getLecturer_id());
            preparedStatement.setString(9,classes.getPerson_max());
            preparedStatement.setString(10,classes.getOpened());
            preparedStatement.setString(11,classes.getRoom_id());
            return preparedStatement.executeUpdate();
        } catch (Exception e){
            e.printStackTrace();
        }
        return -1;
    }

    public ArrayList<Classes> showAll()
    {
        String SQL = "SELECT DISTINCT * FROM CLASS";
        ArrayList<Classes> classesArrayList = new ArrayList<>();
        try
        {
            preparedStatement = connection.prepareStatement(SQL);
            resultSet = preparedStatement.executeQuery();

            while(resultSet.next())
            {
                Classes classes = new Classes();
                classes.setClass_id(resultSet.getString(1));
                classes.setClass_no(resultSet.getString(2));
                classes.setCourse_id(resultSet.getString(3));
                classes.setName(resultSet.getString(4));
                classes.setMajor_id(resultSet.getString(5));
                classes.setYear(resultSet.getString(6));
                classes.setCredit(resultSet.getString(7));
                classes.setLecturer_id(resultSet.getString(8));
                classes.setPerson_max(resultSet.getString(9));
                classes.setOpened(resultSet.getString(10));
                classes.setRoom_id(resultSet.getString(11));
                classesArrayList.add(classes);
            }

        } catch (Exception e)
        {
            e.printStackTrace();
        }
        return classesArrayList;
    }

    public Classes show(String class_id)
    {
        String SQL = "SELECT DISTINCT * FROM CLASS WHERE class_id ? ";
        Classes classes = new Classes();
        try
        {
            preparedStatement = connection.prepareStatement(SQL);
            preparedStatement.setString(1,class_id);
            resultSet = preparedStatement.executeQuery();

            while(resultSet.next())
            {
                classes.setClass_id(resultSet.getString(1));
                classes.setClass_no(resultSet.getString(2));
                classes.setCourse_id(resultSet.getString(3));
                classes.setName(resultSet.getString(4));
                classes.setMajor_id(resultSet.getString(5));
                classes.setYear(resultSet.getString(6));
                classes.setCredit(resultSet.getString(7));
                classes.setLecturer_id(resultSet.getString(8));
                classes.setPerson_max(resultSet.getString(9));
                classes.setOpened(resultSet.getString(10));
                classes.setRoom_id(resultSet.getString(11));
            }

        } catch (Exception e)
        {
            e.printStackTrace();
        }
        return classes;
    }



}
