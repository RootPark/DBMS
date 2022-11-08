package DB_struct.course;

import java.sql.*;

public class CourseDao {
    private Connection connection;
    private PreparedStatement preparedStatement;
    private ResultSet resultSet;

    public CourseDao(){
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

    public String avgCourseGrade(String course_id) throws SQLException {
        //해당 과목의 평균 평점 구하기
        String SQL = "SELECT grade G FROM CREDITS WHERE course_id = ?";
        String SQL_findCredit = "SELECT credit A FROM COURSE WHERE course_id = ?";
        PreparedStatement preparedStatement_findCredit = connection.prepareStatement(SQL_findCredit);
        preparedStatement_findCredit.setString(1,course_id);
        ResultSet resultSet_findCredit = preparedStatement_findCredit.executeQuery();
        resultSet_findCredit.next();
        int credit = resultSet_findCredit.getInt("A");
        int countGrade = 0;
        double allGrade = 0;
        try{
            preparedStatement = connection.prepareStatement(SQL);
            preparedStatement.setString(1,course_id);
            resultSet = preparedStatement.executeQuery();

            while(resultSet.next()){
                double grade = 0;
                if(resultSet.getString("G").equals("A+")){
                    grade = 4.5;
                }
                else if(resultSet.getString("G").equals("A0")){
                    grade = 4.0;
                }
                else if(resultSet.getString("G").equals("B+")){
                    grade = 3.5;
                }
                else if(resultSet.getString("G").equals("B0")){
                    grade = 3.0;
                }
                else if(resultSet.getString("G").equals("C+")){
                    grade = 2.5;
                }
                else if(resultSet.getString("G").equals("C0")){
                    grade = 2.0;
                }
                else if(resultSet.getString("G").equals("D+")){
                    grade = 1.5;
                }
                else if(resultSet.getString("G").equals("D0")){
                    grade = 1.0;
                }
                else{
                    grade = 0.0;
                }
                countGrade++;
                allGrade+=grade*credit;
            }
            return String.format("%.2f",allGrade/(countGrade*credit));
        } catch (Exception e){
            e.printStackTrace();
        }
        return "ERROR";
    }
}
