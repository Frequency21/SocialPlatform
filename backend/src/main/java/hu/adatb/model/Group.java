package hu.adatb.model;


import com.fasterxml.jackson.annotation.JsonProperty;

public class Group {
    @JsonProperty("csoport_id")
    private long csoportId;
    private String leiras;
    private String nev;
    @JsonProperty("tulaj_id")
    private long tulajId;

    public Group() { }

    public long getCsoportId() {
        return csoportId;
    }

    public void setCsoportId(long csoportId) {
        this.csoportId = csoportId;
    }

    public String getLeiras() {
        return leiras;
    }

    public void setLeiras(String leiras) {
        this.leiras = leiras;
    }

    public String getNev() {
        return nev;
    }

    public void setNev(String nev) {
        this.nev = nev;
    }

    public long getTulajId() {
        return tulajId;
    }

    public void setTulajId(long tulajId) {
        this.tulajId = tulajId;
    }

    @Override
    public String toString() {
        return "Group{" +
                "csoportId=" + csoportId +
                ", leiras='" + leiras + '\'' +
                ", nev='" + nev + '\'' +
                ", tulajId=" + tulajId +
                '}';
    }
}
