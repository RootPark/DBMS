package DB_struct.room;

public class Room {
    private String Room_id;
    private String Building_id;
    private String Occupancy;

    public String getRoom_id() {
        return Room_id;
    }
    public void setRoom_id(String room_id) {
        Room_id = room_id;
    }

    public String getBuilding_id() {
        return Building_id;
    }
    public void setBuilding_id(String building_id) {
        Building_id = building_id;
    }

    public String getOccupancy() {
        return Occupancy;
    }
    public void setOccupancy(String occupancy) {
        Occupancy = occupancy;
    }
}
