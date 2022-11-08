package DB_struct.building;

import java.sql.*;

public class BuildingDao {
    private Connection connection;
    private PreparedStatement preparedStatement;
    private ResultSet resultSet;

    public BuildingDao(){
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

    public String findBuildingName(String room_id) throws SQLException {
        //해당 강의실 번호에 맞는 건물 찾기
        String SQL = "SELECT name A FROM building,room WHERE building.building_id = room.building_id AND room.room_id = ?";
        try{
        preparedStatement = connection.prepareStatement(SQL);
        preparedStatement.setString(1,room_id);
        resultSet = preparedStatement.executeQuery();
        resultSet.next();
        } catch (Exception e){
            e.printStackTrace();
        }
        return resultSet.getString("A");
    }
}
