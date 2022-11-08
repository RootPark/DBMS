package DB_struct.time;

import java.sql.*;
import java.util.ArrayList;

public class TimeDao {
    private Connection connection;
    private PreparedStatement preparedStatement;
    private ResultSet resultSet;

    public TimeDao(){
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

    public ArrayList<Time> timetable(String student_id) throws SQLException {
        //시간표 출력을 위한 시간 arraylist 생성
        String SQL_forEnrolledClass = "SELECT class_id A FROM enrolledClass WHERE student_id = ?";
        PreparedStatement preparedStatement_forEnrolledClass = connection.prepareStatement(SQL_forEnrolledClass);
        preparedStatement_forEnrolledClass.setString(1, student_id);
        ResultSet resultSet_forEnrolledClass = preparedStatement_forEnrolledClass.executeQuery();

        ArrayList<Time> arrayList = new ArrayList<>();

        String SQL = "SELECT class_id,begin,end FROM time WHERE class_id = ? ORDER BY begin";
        try{
            while(resultSet_forEnrolledClass.next()){
                preparedStatement = connection.prepareStatement(SQL);
                preparedStatement.setString(1,resultSet_forEnrolledClass.getString("A"));
                resultSet = preparedStatement.executeQuery();
                while(resultSet.next()){
                    Time time = new Time();
                    time.setClass_id(resultSet.getString(1));
                    time.setBegin(resultSet.getString(2));
                    time.setEnd(resultSet.getString(3));
                    arrayList.add(time);
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }

        return arrayList;

    }
}
