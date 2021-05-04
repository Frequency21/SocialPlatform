package hu.adatb.model;


import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.Date;

public class User {

    private Long id;
    private String vnev;
    private String knev;
    private Date csatl;
    @JsonProperty("szul_dat")
    private Date szulDat;
    private String email;
    private String jelszo;
    private byte[] picture;
    private boolean isAdmin;
    @JsonProperty("munka_iskola")
    private String munkaIskola;

    public User() { }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getVnev() {
        return vnev;
    }

    public void setVnev(String vnev) {
        this.vnev = vnev;
    }

    public String getKnev() {
        return knev;
    }

    public void setKnev(String knev) {
        this.knev = knev;
    }

    public Date getCsatl() {
        return csatl;
    }

    public void setCsatl(Date csatl) {
        this.csatl = csatl;
    }

    public Date getSzulDat() {
        return szulDat;
    }

    public void setSzulDat(Date szulDat) {
        this.szulDat = szulDat;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getJelszo() {
        return jelszo;
    }

    public void setJelszo(String jelszo) {
        this.jelszo = jelszo;
    }

    public byte[] getPicture() {
        return picture;
    }

    public void setPicture(byte[] picture) {
        this.picture = picture;
    }

    public boolean isAdmin() {
        return isAdmin;
    }

    public void setAdmin(boolean admin) {
        isAdmin = admin;
    }

    public String getMunkaIskola() {
        return munkaIskola;
    }

    public void setMunkaIskola(String munkaIskola) {
        this.munkaIskola = munkaIskola;
    }


}
