package DB_struct.enrolledClass;

import DB_struct.classes.Classes;
import DB_struct.time.Time;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class EnrolledClassDao {
    private Connection connection;
    private PreparedStatement preparedStatement;
    private ResultSet resultSet;

    public EnrolledClassDao(){
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

    public int enrollClass(String student, String classes, String course_id){
        //수강신청하기
        String count = "SELECT COUNT(*) FROM enrolledClass WHERE class_id = ?";

        try{
            // 조건 0 - > 같은 과목은 수강 불가 (-1)
            String SQL0 = "SELECT * FROM enrolledClass WHERE class_id = ? AND student_id = ?";
            preparedStatement = connection.prepareStatement(SQL0);
            preparedStatement.setString(1,classes);
            preparedStatement.setString(2,student);
            resultSet = preparedStatement.executeQuery();
            if(resultSet.next()){
                return -1;
            }
            else {
                // 조건 1 - > 이전 성적 B0 이상 (-2)

                String SQL1 = "SELECT * FROM credits WHERE (grade ='B0' OR grade ='B+' OR grade ='A0' OR grade ='A+') " +
                        "AND student_id = ? AND course_id = ?";
                preparedStatement = connection.prepareStatement(SQL1);
                preparedStatement.setString(1, student);
                preparedStatement.setString(2, course_id);
                resultSet = preparedStatement.executeQuery();
                if (resultSet.next()) {
                    return -2;
                } else {
                    // 조건 2 - > 정원 다 찼을 경우 (-3)
                    String SQL2 = "SELECT COUNT(*) A FROM enrolledClass WHERE class_id = ?";
                    String SQL_forMemeberNum = "SELECT person_max A FROM class WHERE class_id = ?";
                    PreparedStatement preparedStatement_forMemberNum = connection.prepareStatement(SQL_forMemeberNum);
                    preparedStatement_forMemberNum.setString(1, classes);
                    ResultSet resultSet_forMemberNum = preparedStatement_forMemberNum.executeQuery();
                    preparedStatement = connection.prepareStatement(SQL2);
                    preparedStatement.setString(1, classes);
                    resultSet = preparedStatement.executeQuery();
                    resultSet.next();
                    resultSet_forMemberNum.next();
                    if (resultSet.getInt("A") >= resultSet_forMemberNum.getInt("A")) {
                        return -3;
                    } else {
                        // 조건 3 - > 최대 학점은 18학점 (-4)
                        String SQL3 = "SELECT SUM(class.credit) A FROM student,enrolledClass,class WHERE student.student_id = enrolledClass.student_id AND enrolledClass.class_id = class.class_id " +
                                "AND enrolledClass.student_id = ?";
                        String SQL_forCountCredit = "SELECT credit A FROM class WHERE class_id = ?";
                        PreparedStatement preparedStatement_forCountCredit = connection.prepareStatement(SQL_forCountCredit);
                        preparedStatement_forCountCredit.setString(1,classes);
                        ResultSet resultSet_forCountCredit = preparedStatement_forCountCredit.executeQuery();
                        preparedStatement = connection.prepareStatement(SQL3);
                        preparedStatement.setString(1,student);
                        resultSet = preparedStatement.executeQuery();
                        resultSet.next();
                        resultSet_forCountCredit.next();
                        if(resultSet.getInt("A")+resultSet_forCountCredit.getInt("A")>18){
                            return -4;
                        }
                        else {
                            // 조건 4 - > 동일 시간대에 2개 이상의 과목 수강 신청 (-5)
                            String SQL_forFindTime = "SELECT begin, end FROM enrolledClass,time WHERE enrolledClass.class_id = time.class_id AND enrolledClass.student_id = ?";
                            PreparedStatement preparedStatement_forFindTime = connection.prepareStatement(SQL_forFindTime);
                            preparedStatement_forFindTime.setString(1,student);

                            ArrayList<Time> arrayList_forFindTime = new ArrayList<>();
                            ResultSet resultSet_forFindTime = preparedStatement_forFindTime.executeQuery();

                            while(resultSet_forFindTime.next()){
                                Time time = new Time();
                                time.setBegin(resultSet_forFindTime.getString(1));
                                time.setEnd(resultSet_forFindTime.getString(2));
                                arrayList_forFindTime.add(time);
                            }

                            String SQL4 = "SELECT begin, end FROM time WHERE class_id = ?";
                            preparedStatement = connection.prepareStatement(SQL4);
                            preparedStatement.setString(1,classes);
                            resultSet = preparedStatement.executeQuery();

                            ArrayList<Time> arrayList = new ArrayList<>();

                            while (resultSet.next()){
                                Time time = new Time();
                                time.setBegin(resultSet.getString(1));
                                time.setEnd(resultSet.getString(2));
                                arrayList.add(time);
                            }

                            for(int i=0;i<arrayList.size();i++){
                                for(int j=0;j<arrayList_forFindTime.size();j++){
                                    if(arrayList.get(i).getBegin().charAt(9)==arrayList_forFindTime.get(j).getBegin().charAt(9)){
                                        //기존 수업과 날짜가 같은 경우
                                        if(!(Integer.parseInt(arrayList_forFindTime.get(j).getBegin().substring(11,12))>Integer.parseInt(arrayList.get(i).getEnd().substring(11,12))
                                                || Integer.parseInt(arrayList_forFindTime.get(j).getEnd().substring(11,12))<Integer.parseInt(arrayList.get(i).getBegin().substring(11,12)))){
                                            //기존 수업과 시간까지 겹치는 경우
                                            return -5;
                                        }
                                    }
                                }
                            }

                            String SQL = "INSERT INTO enrolledClass(student_id,class_id) VALUES (?,?)";
                            preparedStatement = connection.prepareStatement(SQL);
                            preparedStatement.setString(1,student);
                            preparedStatement.setString(2,classes);
                            return preparedStatement.executeUpdate();
                            }

                    }
                }
            }
        } catch (Exception e){
            e.printStackTrace();
        }
        return -6;
    }

    public int deleteClass(String student, String classes){
        //수강 수업 삭제
        String SQL = "DELETE FROM enrolledClass WHERE student_id = ? AND class_id = ?";
        try{
            preparedStatement = connection.prepareStatement(SQL);
            preparedStatement.setString(1,student);
            preparedStatement.setString(2,classes);
            return preparedStatement.executeUpdate();
        } catch(Exception e){
            e.printStackTrace();
        }
        return -1;
    }

    public ArrayList<Classes> showAll(String student_id)
    {
        //수강하는 수업 전체 출력
        String SQL = "SELECT * FROM enrolledClass, class WHERE enrolledClass.class_id = class.class_id AND enrolledClass.student_id = ?";
        ArrayList<Classes> classesArrayList = new ArrayList<>();
        try
        {
            preparedStatement = connection.prepareStatement(SQL);
            preparedStatement.setString(1,student_id);
            resultSet = preparedStatement.executeQuery();

            while(resultSet.next())
            {
                Classes classes = new Classes();
                classes.setClass_id(resultSet.getString(4));
                classes.setClass_no(resultSet.getString(5));
                classes.setCourse_id(resultSet.getString(6));
                classes.setName(resultSet.getString(7));
                classes.setMajor_id(resultSet.getString(8));
                classes.setYear(resultSet.getString(9));
                classes.setCredit(resultSet.getString(10));
                classes.setLecturer_id(resultSet.getString(11));
                classes.setPerson_max(resultSet.getString(12));
                classes.setOpened(resultSet.getString(13));
                classes.setRoom_id(resultSet.getString(14));
                classesArrayList.add(classes);
            }

        } catch (Exception e)
        {
            e.printStackTrace();
        }
        return classesArrayList;
    }

}
