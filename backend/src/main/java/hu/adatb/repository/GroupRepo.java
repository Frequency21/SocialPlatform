package hu.adatb.repository;


import hu.adatb.model.Group;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;


@Repository
public class GroupRepo {
    private final JdbcTemplate jdbcTemplate;
    private final NamedParameterJdbcTemplate namedJdbc;
    private static final String SAVE_GROUP = "insert into CSOPORT(NEV, LEIRAS, TULAJ_ID) VALUES (:NEV, :LEIRAS, :TULAJ_ID)";
    private static final String SELECT_GROUP_BY_ID = "select * from CSOPORT where CSOPORT_ID = ?";
    private static final String SELECT_ALL = "select * from CSOPORT";
    private static final String UPDATE_BY_ID = "update CSOPORT set LEIRAS = ?, NEV = ?, TULAJ_ID = ? where CSOPORT_ID = ?";
    private static final String DELETE_BY_ID = "delete from CSOPORT where CSOPORT_ID = ?";

    public GroupRepo(JdbcTemplate jdbcTemplate, NamedParameterJdbcTemplate namedJdbc) {
        this.jdbcTemplate = jdbcTemplate;
        this.namedJdbc = namedJdbc;
    }

    private static Group mapRow(ResultSet rs, int rowNum) throws SQLException {
        Group group = new Group();
        group.setNev(rs.getString("NEV"));
        group.setCsoportId(rs.getLong("CSOPORT_ID"));
        group.setLeiras(rs.getString("LEIRAS"));
        group.setTulajId(rs.getLong("TULAJ_ID"));
        return group;
    }

    public Long save(Group group) {
        KeyHolder kh = new GeneratedKeyHolder();
        namedJdbc.update(
                SAVE_GROUP,
                new MapSqlParameterSource()
                        .addValue("NEV", group.getNev())
                        .addValue("LEIRAS", group.getLeiras())
                        .addValue("TULAJ_ID", group.getTulajId()),
                kh,
                new String[]{"CSOPORT_ID"}
        );
        return kh.getKey().longValue();
    }

    public Group get(long id) {
        return jdbcTemplate.queryForObject(SELECT_GROUP_BY_ID, GroupRepo::mapRow, id);
    }

    public List<Group> getAll() {
        return jdbcTemplate.query(SELECT_ALL, GroupRepo::mapRow);
    }

    public boolean update(Group to) {
        return jdbcTemplate.update(UPDATE_BY_ID, to.getLeiras(), to.getNev(), to.getTulajId(), to.getCsoportId()) == 1;
    }

    public boolean delete(long id) {
        return jdbcTemplate.update(DELETE_BY_ID, id) == 1;
    }

}
