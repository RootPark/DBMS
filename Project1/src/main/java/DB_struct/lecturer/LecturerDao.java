package DB_struct.lecturer;

import java.sql.*;

public class LecturerDao {

    private Connection connection;
    private PreparedStatement preparedStatement;
    private ResultSet resultSet;

    public LecturerDao(){
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

    public String findLecturerName(String lecturer_id) throws SQLException {
        //해당 아이디에 맞는 강사 찾기
        String SQL = "SELECT name A FROM lecturer WHERE lecturer_id = ?";

        try{
            preparedStatement = connection.prepareStatement(SQL);
            preparedStatement.setString(1,lecturer_id);
            resultSet = preparedStatement.executeQuery();
            resultSet.next();
        } catch (Exception e){
            e.printStackTrace();
        }
        return resultSet.getString("A");
    }
}
