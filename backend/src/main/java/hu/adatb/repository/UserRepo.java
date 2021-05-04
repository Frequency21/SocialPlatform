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
    private final static String SELECT_USER = "select ID, JELSZO from felhasznalo where id = :id";
    private final static String SELECT_ALL_USER = "select ID, JELSZO, EMAIL, f.nev.VEZETEKNEV as vnev, f.NEV.KERESZTNEV as knev, CSATL_DAT, SZUL_DAT, MUNKA_ISKOLA from felhasznalo f";

    @Transactional
    public User getUser(int id) {
        MapSqlParameterSource map = new MapSqlParameterSource("id", id);

        User user = namedJdbc.query(
                SELECT_USER,
                map, resultSet -> {
                    User result = new User();
                    resultSet.next();
                    result.setId(resultSet.getLong("id"));
                    result.setJelszo(resultSet.getString("jelszo"));
                    return result;
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
