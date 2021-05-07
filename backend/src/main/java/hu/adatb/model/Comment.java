package hu.adatb.model;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.Date;


public class Comment {
    private long id;
    private Date idopont;
    @JsonProperty("komment_iro_id")
    private long kommentIroId;
    @JsonProperty("poszt_id")
    private long posztId;
    private String szoveg;
    private int like;
    private int dislike;
    private boolean isPublic;

    public Comment() { }

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

    public long getKommentIroId() {
        return kommentIroId;
    }

    public void setKommentIroId(long kommentIroId) {
        this.kommentIroId = kommentIroId;
    }

    public long getPosztId() {
        return posztId;
    }

    public void setPosztId(long posztId) {
        this.posztId = posztId;
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
        return "Comment{" +
                "id=" + id +
                ", idopont=" + idopont +
                ", kommentIroId=" + kommentIroId +
                ", posztId='" + posztId + '\'' +
                ", szoveg='" + szoveg + '\'' +
                ", like=" + like +
                ", dislike=" + dislike +
                ", isPublic=" + isPublic +
                '}';
    }
}
