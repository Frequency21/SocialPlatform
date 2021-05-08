package hu.adatb.model;


import com.fasterxml.jackson.annotation.JsonProperty;

public class Category {
    private String nev;
    @JsonProperty("felh_id")
    private long felhId;

    public Category() { }

    public String getNev() {
        return nev;
    }

    public void setNev(String nev) {
        this.nev = nev;
    }

    public long getFelhId() {
        return felhId;
    }

    public void setFelhId(long felhId) {
        this.felhId = felhId;
    }

    @Override
    public String toString() {
        return "Category{" +
                "nev='" + nev + '\'' +
                ", felhId=" + felhId +
                '}';
    }
}
