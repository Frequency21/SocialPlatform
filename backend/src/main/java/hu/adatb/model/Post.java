package hu.adatb.model;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.Date;

public class Post {
    private Date idopont;
    @JsonProperty("szerzo_id")
    private int szerzoId;
    @JsonProperty("csoport_id")
    private int csoportId;
    @JsonProperty("felhasznalo_id")
    private int felhasznaloId;
    private String szoveg;
    private int like;
    private int dislike;
    private boolean isPublic;

    public Post() {
    }

    public Date getIdopont() {
        return idopont;
    }

    public void setIdopont(Date idopont) {
        this.idopont = idopont;
    }

    public int getSzerzoId() {
        return szerzoId;
    }

    public void setSzerzoId(int szerzoId) {
        this.szerzoId = szerzoId;
    }

    public int getCsoportId() {
        return csoportId;
    }

    public void setCsoportId(int csoportId) {
        this.csoportId = csoportId;
    }

    public int getFelhasznaloId() {
        return felhasznaloId;
    }

    public void setFelhasznaloId(int felhasznaloId) {
        this.felhasznaloId = felhasznaloId;
    }

    public String getSzoveg() {
        return szoveg;
    }

    public void setSzoveg(String szoveg) {
        this.szoveg = szoveg;
    }

    public int getLike() {
        return like;
    }

    public void setLike(int like) {
        this.like = like;
    }

    public int getDislike() {
        return dislike;
    }

    public void setDislike(int dislike) {
        this.dislike = dislike;
    }

    public boolean isPublic() {
        return isPublic;
    }

    public void setPublic(boolean aPublic) {
        isPublic = aPublic;
    }

    @Override
    public String toString() {
        return "Post{" +
                "idopont=" + idopont +
                ", szerzoId=" + szerzoId +
                ", csoportId=" + csoportId +
                ", felhasznaloId=" + felhasznaloId +
                ", szoveg='" + szoveg + '\'' +
                ", like=" + like +
                ", dislike=" + dislike +
                ", isPublic=" + isPublic +
                '}';
    }
}
