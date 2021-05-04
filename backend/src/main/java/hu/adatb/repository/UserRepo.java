package hu.adatb.repository;

import hu.adatb.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;


@Repository
public class UserRepo {
    @Autowired
    private NamedParameterJdbcTemplate namedJdbc;
    @Autowired
    private JdbcTemplate jdbcTemplate;
    private final static String SELECT_USER = "select ID, JELSZO, EMAIL, f.NEV.VEZETEKNEV as VNEV, f.NEV.KERESZTNEV as KNEV, CSATL_DAT, SZUL_DAT, MUNKA_ISKOLA, PICTURE, ISADMIN, TYPE from felhasznalo f where id = :id";
    private final static String SELECT_ALL_USER = "select ID, JELSZO, EMAIL, f.nev.VEZETEKNEV as vnev, f.NEV.KERESZTNEV as knev, CSATL_DAT, SZUL_DAT, MUNKA_ISKOLA from felhasznalo f";

    /*
    * private Long id;
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
    private String munkaIskola;*/

    @Transactional
    public User getUser(int id) {
        MapSqlParameterSource map = new MapSqlParameterSource("id", id);

        User user = namedJdbc.query(
                SELECT_USER,
                map, rs -> {
                    User u = new User();
                    rs.next();
                    u.setId(rs.getLong("ID"));
                    u.setJelszo(rs.getString("JELSZO"));
                    u.setEmail(rs.getString("EMAIL"));
                    u.setVnev(rs.getString("VNEV"));
                    u.setKnev(rs.getString("KNEV"));
                    u.setCsatl(rs.getDate("CSATL_DAT"));
                    u.setSzulDat(rs.getDate("SZUL_DAT"));
                    u.setMunkaIskola(rs.getString("MUNKA_ISKOLA"));
                    u.setPicture(rs.getBytes("PICTURE"));
                    u.setAdmin(rs.getBoolean("ISADMIN"));
                    return u;
                });
        return user;
    }

    @Transactional
    public List<User> getUsers() {
        List<User> user = jdbcTemplate.query(
                SELECT_ALL_USER,
                rs -> {
                    List<User> users = new ArrayList<>();
                    User u;
                    while (rs.next()) {
                        u = new User();
                        u.setId(rs.getLong("ID"));
                        u.setJelszo(rs.getString("JELSZO"));
                        u.setEmail(rs.getString("EMAIL"));
                        u.setVnev(rs.getString("VNEV"));
                        u.setKnev(rs.getString("KNEV"));
                        u.setCsatl(rs.getDate("CSATL_DAT"));
//                         SZUL_DAT
                        u.setMunkaIskola(rs.getString("MUNKA_ISKOLA"));
                        users.add(u);
                    }
                    return users;
                });
        return user;
    }

}
