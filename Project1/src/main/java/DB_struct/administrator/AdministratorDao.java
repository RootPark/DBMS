package DB_struct.administrator;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class AdministratorDao {
    private Connection connection;
    private PreparedStatement preparedStatement;
    private ResultSet resultSet;

    public AdministratorDao(){
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

    public int login(String administrator_id, String password){
        String SQL = "SELECT password FROM ADMINISTRATOR WHERE administrator_id = ?";
        try{
            preparedStatement = connection.prepareStatement(SQL);
            preparedStatement.setString(1, administrator_id);
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
    public Administrator showAll(String administrator_id)
    {
        //전체 관리자 보여주기
        String SQL = "SELECT * FROM ADMINISTRATOR WHERE administrator_id = ?";
        Administrator administrator = new Administrator();
        try
        {
            preparedStatement = connection.prepareStatement(SQL);
            preparedStatement.setString(1,administrator_id);
            resultSet = preparedStatement.executeQuery();

            while(resultSet.next())
            {
                administrator.setAdministrator_id(resultSet.getString(1));
                administrator.setPassword(resultSet.getString(2));
            }

        } catch (Exception e)
        {
            e.printStackTrace();
        }
        return administrator;
    }
}
