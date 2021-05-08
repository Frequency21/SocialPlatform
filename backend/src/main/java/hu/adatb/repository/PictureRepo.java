package hu.adatb.repository;


import hu.adatb.model.Picture;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;


@Repository
public class PictureRepo {
    private final JdbcTemplate jdbcTemplate;
    private static final String SELECT_ALL = "select * from FENYKEP where FELH_ID = ? and KAT_NEV = ?";


    public PictureRepo(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    private static Picture mapRow(ResultSet rs, int i) throws SQLException {
        Picture picture = new Picture();
        picture.setKepId(rs.getLong("KEP_ID"));
        picture.setKep(rs.getString("KEP"));
        picture.setKepNev(rs.getString("KEP_NEV"));
        picture.setKatNev(rs.getString("KAT_NEV"));
        picture.setFelhId(rs.getLong("FELH_ID"));
        return picture;
    }

    public List<Picture> getAll(String katNev, String felhId) {
        return jdbcTemplate.query(
                SELECT_ALL,
                (RowMapper<Picture>) PictureRepo::mapRow,
                felhId, katNev
        );
    }
}
