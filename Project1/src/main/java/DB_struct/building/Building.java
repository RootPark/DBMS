package DB_struct.building;

public class Building {
    private String Building_id;
    private String Name;
    private String Admin;
    private String Rooms;

    public String getBuilding_id(){
        return Building_id;
    }
    public void setBuilding_id(String building_id){
        Building_id = building_id;
    }

    public String getName(){
        return Name;
    }
    public void setName(String name){
        Name = name;
    }

    public String getAdmin(){
        return Admin;
    }
    public void setAdmin(String admin){
        Admin = admin;
    }

    public String getRooms(){
        return Rooms;
    }
    public void setRooms(String rooms){
        Rooms = rooms;
    }
}
