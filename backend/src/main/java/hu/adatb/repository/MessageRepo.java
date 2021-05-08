package hu.adatb.repository;


import hu.adatb.model.Message;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;


@Repository
public class MessageRepo {
    private final JdbcTemplate jdbcTemplate;
    private final NamedParameterJdbcTemplate namedJdbc;
    private static final String SELECT_ALL_WITH_IMAGE = "select u.ID, KULDO_ID, CIMZETT_ID, SZOVEG, PICTURE, IDOPONT " +
            "from UZENET u inner join FELHASZNALO F on u.KULDO_ID = F.ID where KULDO_ID = :id_1 and CIMZETT_ID = :id_2 " +
            "or KULDO_ID = :id_2 and CIMZETT_ID = :id_1 order by IDOPONT";
    private static final String INSERT_MESSAGE = "insert into UZENET(IDOPONT, KULDO_ID, CIMZETT_ID, SZOVEG) VALUES " +
            "(?, ?, ?, ?)";
    private static final String DELETE_MESSAGE_BY_ID = "delete from UZENET where ID = ?";

    public MessageRepo(JdbcTemplate jdbcTemplate, NamedParameterJdbcTemplate namedJdbc) {
        this.jdbcTemplate = jdbcTemplate;
        this.namedJdbc = namedJdbc;
    }

    private static Message mapRow(ResultSet rs, int rowNum) throws SQLException {
        Message message = new Message();
        message.setId(rs.getLong("ID"));
        message.setIdopont(rs.getDate("IDOPONT"));
        message.setKuldoId(rs.getLong("KULDO_ID"));
        message.setCimzettId(rs.getLong("CIMZETT_ID"));
        message.setSzoveg(rs.getString("SZOVEG"));
        message.setFenykep(rs.getString("PICTURE"));
        return message;
    }

    public List<Message> getAll(long cimzett, long kuldo) {
        return namedJdbc.query(
                SELECT_ALL_WITH_IMAGE,
                new MapSqlParameterSource()
                        .addValue("id_1", cimzett)
                        .addValue("id_2", kuldo),
                MessageRepo::mapRow
        );
    }

    public boolean insert(Message message) {
        return jdbcTemplate.update(INSERT_MESSAGE, message.getIdopont(), message.getKuldoId(), message.getCimzettId(),
                message.getSzoveg()) == 1;
    }

    public boolean delete(long id) {
        return jdbcTemplate.update(DELETE_MESSAGE_BY_ID, id) == 1;
    }
}
