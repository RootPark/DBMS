package DB_struct.credits;

import DB_struct.student.Student;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class CreditsDao {
    private Connection connection;
    private PreparedStatement preparedStatement;
    private ResultSet resultSet;

    public CreditsDao(){
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


    public ArrayList<Credits> showAll(String student_id)
    {
        //학생 성적 전체 출력 부분
        String SQL = "SELECT * FROM CREDITS,COURSE WHERE CREDITS.course_id = COURSE.course_id AND student_id = ?";
        ArrayList<Credits> credits = new ArrayList<>();
        try
        {
            preparedStatement = connection.prepareStatement(SQL);
            preparedStatement.setString(1,student_id);
            resultSet = preparedStatement.executeQuery();

            while(resultSet.next())
            {
                Credits credit = new Credits();
                credit.setCredits_id(resultSet.getString(7));
                credit.setStudent_id(resultSet.getString(8));
                credit.setCourse_id(resultSet.getString(3));
                credit.setYear(resultSet.getString(4));
                credit.setGrade(resultSet.getString(5));
                credits.add(credit);
            }

        } catch (Exception e)
        {
            e.printStackTrace();
        }
        return credits;
    }

}
