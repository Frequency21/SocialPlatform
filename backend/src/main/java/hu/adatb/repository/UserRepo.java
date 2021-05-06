package hu.adatb.repository;

import hu.adatb.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;
import java.net.http.HttpResponse;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


@Repository
public class UserRepo {
    private static final String INSERT_USER = "insert into FELHASZNALO(JELSZO, EMAIL, NEV, CSATL_DAT, SZUL_DAT, " +
            "MUNKA_ISKOLA, ISADMIN) VALUES (:JELSZO, :EMAIL, NEVTIPUS(:VNEV, :KNEV), :CSATL_DAT, :SZUL_DAT, " +
            ":MUNKA_ISKOLA, :ISADMIN)";
    private static final String DELETE_USER = "delete from FELHASZNALO where ID = ?";
    @Autowired
    private NamedParameterJdbcTemplate namedJdbc;
    @Autowired
    private JdbcTemplate jdbcTemplate;
    private static final String SELECT_USER = "select ID, JELSZO, EMAIL, f.NEV.VEZETEKNEV as VNEV, f.NEV.KERESZTNEV " +
            "as KNEV, CSATL_DAT, SZUL_DAT, MUNKA_ISKOLA, PICTURE, ISADMIN from felhasznalo f where id = :id";
    private static final String SELECT_ALL_USER = "select ID, JELSZO, EMAIL, f.nev.VEZETEKNEV as vnev, " +
            "f.NEV.KERESZTNEV as knev, CSATL_DAT, SZUL_DAT, MUNKA_ISKOLA from felhasznalo f";

    public User getUser(int id) {
        MapSqlParameterSource map = new MapSqlParameterSource("id", id);

        return namedJdbc.query(
                SELECT_USER,
                map, rs -> {
                    User u = new User();
                    if (rs.next()) {
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
                    }
                    return u;
                });
    }

    public List<User> getUsers() {
        return jdbcTemplate.query(
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
                        u.setMunkaIskola(rs.getString("MUNKA_ISKOLA"));
                        users.add(u);
                    }
                    return users;
                });
    }

    public Long insertUser(User user) {
        KeyHolder kh = new GeneratedKeyHolder();
        MapSqlParameterSource map = new MapSqlParameterSource()
                .addValue("JELSZO", user.getJelszo())
                .addValue("EMAIL", user.getEmail())
                .addValue("VNEV", user.getVnev())
                .addValue("KNEV", user.getKnev())
                .addValue("CSATL_DAT", new Date(System.currentTimeMillis()))
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

    public boolean deleteUser(int id) {
        return jdbcTemplate.update(DELETE_USER, id) == 1;
    }

}
