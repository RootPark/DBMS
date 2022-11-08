package DB_struct.administrator;

public class Administrator {
    private String Administrator_id;
    private String Password;

    public String getAdministrator_id(){
        return Administrator_id;
    }
    public void setAdministrator_id(String administrator_id){
        Administrator_id = administrator_id;
    }

    public String getPassword(){
        return Password;
    }
    public void setPassword(String password){
        Password = password;
    }
}
