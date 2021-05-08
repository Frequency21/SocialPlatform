package hu.adatb.model;


import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.Date;


public class Message {
    private long id;
    private Date idopont;
    @JsonProperty("kuldo_id")
    private long kuldoId;
    @JsonProperty("cimzett_id")
    private long cimzettId;
    private String szoveg;
    private String fenykep;

    public Message() { }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public Date getIdopont() {
        return idopont;
    }

    public void setIdopont(Date idopont) {
        this.idopont = idopont;
    }

    public long getKuldoId() {
        return kuldoId;
    }

    public void setKuldoId(long kuldoId) {
        this.kuldoId = kuldoId;
    }

    public long getCimzettId() {
        return cimzettId;
    }

    public void setCimzettId(long cimzettId) {
        this.cimzettId = cimzettId;
    }

    public String getSzoveg() {
        return szoveg;
    }

    public void setSzoveg(String szoveg) {
        this.szoveg = szoveg;
    }

    public String getFenykep() {
        return fenykep;
    }

    public void setFenykep(String fenykep) {
        this.fenykep = fenykep;
    }
}
