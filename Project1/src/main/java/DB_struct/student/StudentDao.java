package DB_struct.student;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class StudentDao {
    private Connection connection;
    private PreparedStatement preparedStatement;
    private ResultSet resultSet;

    public StudentDao(){
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

    public int login(String student_id, String password){
        String SQL = "SELECT password FROM STUDENT WHERE student_id = ?";
        try{
            preparedStatement = connection.prepareStatement(SQL);
            preparedStatement.setString(1, student_id);
            resultSet = preparedStatement.executeQuery();
            if(resultSet.next()){
                if(resultSet.getString(1).equals(password)){
                    return 1; //로그인 성공
                }
                else{
                    return 0; //비밀번호 불일치
                }
            }
            return -1; //아이디 없음
        }catch (Exception e){
            e.printStackTrace();
        }
        return -2; //DB 오류
    }

    public Student show(String student_id)
    {
        //해당 아이디의 학생 출력
        String SQL = "SELECT * FROM STUDENT WHERE student_id = ?";
        Student student = new Student();
        try
        {
            preparedStatement = connection.prepareStatement(SQL);
            preparedStatement.setString(1,student_id);
            resultSet = preparedStatement.executeQuery();

            while(resultSet.next())
            {
                student.setStudent_id(resultSet.getString(1));
                student.setPassword(resultSet.getString(2));
                student.setName(resultSet.getString(3));
                student.setSex(resultSet.getString(4));
                student.setMajor_id(resultSet.getString(5));
                student.setLecturer_id(resultSet.getString(6));
                student.setYear(resultSet.getString(7));
            }

        } catch (Exception e)
        {
            e.printStackTrace();
        }
        return student;
    }

    public int deleteStudent(String student_id){
        //학생 정보 삭제
        String SQL = "DELETE FROM STUDENT WHERE student_id = ?";
        try{
            preparedStatement = connection.prepareStatement(SQL);
            preparedStatement.setString(1,student_id);
            return preparedStatement.executeUpdate();
        } catch (Exception e){
            e.printStackTrace();
        }
        return -1;
    }


    public ArrayList<Student> showAll()
    {
        //학생 전체 출력
        String SQL = "SELECT * FROM STUDENT";
        ArrayList<Student> students = new ArrayList<>();
        try
        {
            preparedStatement = connection.prepareStatement(SQL);
            resultSet = preparedStatement.executeQuery();

            while(resultSet.next())
            {
                Student student = new Student();
                student.setStudent_id(resultSet.getString(1));
                student.setPassword(resultSet.getString(2));
                student.setName(resultSet.getString(3));
                student.setSex(resultSet.getString(4));
                student.setMajor_id(resultSet.getString(5));
                student.setLecturer_id(resultSet.getString(6));
                student.setYear(resultSet.getString(7));
                students.add(student);
            }

        } catch (Exception e)
        {
            e.printStackTrace();
        }
        return students;
    }


}
