package hu.adatb.repository;

import hu.adatb.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


@Repository
public class UserRepo {
    private final JdbcTemplate jdbcTemplate;
    private final NamedParameterJdbcTemplate namedJdbc;
    private static final String INSERT_USER = "insert into FELHASZNALO(JELSZO, EMAIL, NEV, CSATL_DAT, SZUL_DAT, " +
            "MUNKA_ISKOLA, ISADMIN) VALUES (:JELSZO, :EMAIL, NEVTIPUS(:VNEV, :KNEV), :CSATL_DAT, :SZUL_DAT, " +
            ":MUNKA_ISKOLA, :ISADMIN)";
    private static final String DELETE_USER = "delete from FELHASZNALO where ID = ?";
    private static final String INSERT_PICTURE = "update FELHASZNALO set PICTURE = ? where ID = ?";
    private static final String SELECT_USER = "select ID, JELSZO, EMAIL, f.NEV.VEZETEKNEV as VNEV, f.NEV.KERESZTNEV " +
            "as KNEV, CSATL_DAT, SZUL_DAT, MUNKA_ISKOLA, PICTURE, ISADMIN from felhasznalo f where id = :id";
    private static final String SELECT_USER_BY_EMAIL_AND_PASSWORD = "select ID, JELSZO, EMAIL, f.NEV.VEZETEKNEV as " +
            "VNEV, f.NEV.KERESZTNEV as KNEV, CSATL_DAT, SZUL_DAT, MUNKA_ISKOLA, PICTURE, ISADMIN from felhasznalo f " +
            "where EMAIL = :EMAIL and JELSZO = :JELSZO";
    private static final String SELECT_ALL_USER = "select ID, JELSZO, EMAIL, f.NEV.VEZETEKNEV as VNEV, " +
            "f.NEV.KERESZTNEV as KNEV, CSATL_DAT, SZUL_DAT, MUNKA_ISKOLA, PICTURE, ISADMIN from felhasznalo f";
    private static final String UPDATE_USER = "UPDATE FELHASZNALO " +
            "SET JELSZO = :JELSZO, EMAIL = :EMAIL, NEV = NEVTIPUS(:VNEV, :KNEV), " +
            "SZUL_DAT = :SZUL_DAT, MUNKA_ISKOLA = :MUNKA_ISKOLA " +
            "WHERE id = :id";
    private static final String USER_ISMEROSEI = "select ID, JELSZO, EMAIL, f.NEV.VEZETEKNEV as VNEV, f.NEV.KERESZTNEV " +
            "as KNEV, CSATL_DAT, SZUL_DAT, MUNKA_ISKOLA, PICTURE, ISADMIN from " +
            "FELHASZNALO f inner join ISMEROS i on f.ID = i.FELHASZNALO1_ID where " +
            "i.FELHASZNALO1_ID = :ID or i.FELHASZNALO2_ID = :ID";
    private static final String FRIEND_REQUEST = "insert into ISMEROS values (?, ?)";

    public UserRepo(NamedParameterJdbcTemplate namedJdbc, JdbcTemplate jdbcTemplate) {
        this.namedJdbc = namedJdbc;
        this.jdbcTemplate = jdbcTemplate;
    }

    /* a mapRow szebb megoldás lenne, de már nem fogom refaktorálni arra (lásd GroupRepo) */
    private static User extractUser(ResultSet rs) throws SQLException {
        User u = new User();
        if (rs.next()) getUser(rs, u);
        return u;
    }

    private static void getUser(ResultSet rs, User u) throws SQLException {
        u.setId(rs.getLong("ID"));
        u.setEmail(rs.getString("EMAIL"));
        u.setJelszo(rs.getString("JELSZO"));
        u.setVnev(rs.getString("VNEV"));
        u.setKnev(rs.getString("KNEV"));
        u.setCsatl(rs.getDate("CSATL_DAT"));
        u.setSzulDat(rs.getDate("SZUL_DAT"));
        u.setMunkaIskola(rs.getString("MUNKA_ISKOLA"));
        u.setPicture(rs.getString("PICTURE"));
        u.setAdmin(rs.getBoolean("ISADMIN"));
    }

    public User getUser(int id) {
        MapSqlParameterSource map = new MapSqlParameterSource("id", id);
        return namedJdbc.query(SELECT_USER, map, UserRepo::extractUser);
    }

    public User getUser(String email, String password) {
        MapSqlParameterSource map = new MapSqlParameterSource()
                .addValue("EMAIL", email)
                .addValue("JELSZO", password);
        return namedJdbc.query(SELECT_USER_BY_EMAIL_AND_PASSWORD, map, UserRepo::extractUser);
    }


    public List<User> getUsers() {
        return jdbcTemplate.query(
                SELECT_ALL_USER,
                rs -> {
                    List<User> users = new ArrayList<>();
                    User u;
                    while (rs.next()) {
                        u = new User();
                        getUser(rs, u);
                        users.add(u);
                    }
                    return users;
                });
    }

    /* picture direkt nincs, azt csak sikeres regisztrációt követően */
    public Long insertUser(User user) {
        KeyHolder kh = new GeneratedKeyHolder();
        MapSqlParameterSource map = new MapSqlParameterSource()
                .addValue("JELSZO", user.getJelszo())
                .addValue("EMAIL", user.getEmail())
                .addValue("VNEV", user.getVnev())
                .addValue("KNEV", user.getKnev())
                .addValue("CSATL_DAT", user.getCsatl())
                .addValue("SZUL_DAT", user.getSzulDat())
                .addValue("MUNKA_ISKOLA", user.getMunkaIskola())
                .addValue("ISADMIN", user.isAdmin());
        try {
            namedJdbc.update(INSERT_USER, map, kh, new String[]{"ID"});
        } catch (DataAccessException dae) {
            return null;
        }
        return kh.getKey().longValue();
    }

    public Long updateUser(User user) {
        MapSqlParameterSource map = new MapSqlParameterSource()
                .addValue("id", user.getId())
                .addValue("JELSZO", user.getJelszo())
                .addValue("EMAIL", user.getEmail())
                .addValue("VNEV", user.getVnev())
                .addValue("KNEV", user.getKnev())
                .addValue("SZUL_DAT", user.getSzulDat())
                .addValue("MUNKA_ISKOLA", user.getMunkaIskola());
        try {
            namedJdbc.update(UPDATE_USER, map);
        } catch (DataAccessException dae) {
            System.out.println(dae);
            return null;
        }
        return user.getId();
    }


    public boolean deleteUser(int id) {
        return jdbcTemplate.update(DELETE_USER, id) == 1;
    }

    public void savePicture(long id, String uri) {
        jdbcTemplate.update(INSERT_PICTURE, ps -> {
            ps.setString(1, uri);
            ps.setLong(2, id);
        });
    }

    public List<User> getIsmerosei(long id) {
        return namedJdbc.query(
                USER_ISMEROSEI,
                new MapSqlParameterSource("ID", id),
                rs -> {
                    List<User> users = new ArrayList<>();
                    User u;
                    while (rs.next()) {
                        u = new User();
                        getUser(rs, u);
                        users.add(u);
                    }
                    return users;
                }
        );
    }

    public boolean friendRequest(long id1, long id2) {
        return jdbcTemplate.update(FRIEND_REQUEST, id1, id2) == 1;
    }
}
