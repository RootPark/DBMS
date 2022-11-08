package DB_struct.time;

public class Time {
    private String Time_id;
    private String Class_id;
    private String Period;
    private String Begin;
    private String End;

    public String getTime_id() {
        return Time_id;
    }
    public void setTime_id(String time_id) {
        Time_id = time_id;
    }

    public String getClass_id() {
        return Class_id;
    }
    public void setClass_id(String class_id) {
        Class_id = class_id;
    }

    public String getPeriod() {
        return Period;
    }
    public void setPeriod(String period) {
        Period = period;
    }

    public String getBegin() {
        return Begin;
    }
    public void setBegin(String begin) {
        Begin = begin;
    }

    public String getEnd() {
        return End;
    }
    public void setEnd(String end) {
        End = end;
    }
}
