package DB_struct.major;

import java.sql.*;

public class MajorDao {
    private Connection connection;
    private PreparedStatement preparedStatement;
    private ResultSet resultSet;
    public MajorDao(){
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

    public String findMajorName(String major_id) throws SQLException {
        //해당 아이디에 맞는 전공이름 찾기
        String SQL = "SELECT name A FROM major WHERE major_id = ?";

        try{
            preparedStatement = connection.prepareStatement(SQL);
            preparedStatement.setString(1,major_id);
            resultSet = preparedStatement.executeQuery();
            resultSet.next();
        } catch (Exception e){
            e.printStackTrace();
        }
        return resultSet.getString("A");
    }
}
