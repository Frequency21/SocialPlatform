package hu.adatb.model;


import com.fasterxml.jackson.annotation.JsonProperty;

public class Picture {
    @JsonProperty("kep_id")
    private long kepId;
    private String kep;
    @JsonProperty("kep_nev")
    private String kepNev;
    @JsonProperty("kat_nev")
    private String katNev;
    @JsonProperty("felh_id")
    private long felhId;

    public Picture() { }

    public long getKepId() {
        return kepId;
    }

    public void setKepId(long kepId) {
        this.kepId = kepId;
    }

    public String getKep() {
        return kep;
    }

    public void setKep(String kep) {
        this.kep = kep;
    }

    public String getKepNev() {
        return kepNev;
    }

    public void setKepNev(String kepNev) {
        this.kepNev = kepNev;
    }

    public String getKatNev() {
        return katNev;
    }

    public void setKatNev(String katNev) {
        this.katNev = katNev;
    }

    public long getFelhId() {
        return felhId;
    }

    public void setFelhId(long felhId) {
        this.felhId = felhId;
    }

    @Override
    public String toString() {
        return "Picture{" +
                "kepId=" + kepId +
                ", kep='" + kep + '\'' +
                ", kepNev='" + kepNev + '\'' +
                ", katNev='" + katNev + '\'' +
                ", felhId=" + felhId +
                '}';
    }
}
