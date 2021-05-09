package hu.adatb.repository;

import hu.adatb.model.Komment;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;


@Repository
public class CommentRepo {
    private final JdbcTemplate jdbcTemplate;
    private final NamedParameterJdbcTemplate namedJdbc;
    private static final String SELECT_ALL = "";
    private static final String INSERT_COMMENT = "INSERT INTO KOMMENT(IDOPONT, KOMMENT_IRO_ID, POSZT_ID, SZOVEG, ERTEKELES, ISPUBLIC)" +
            "VALUES(:IDOPONT, :KOMMENT_IRO_ID, :POSZT_ID, :SZOVEG, ERTEKELES(:LIKE, :DISLIKE), :ISPUBLIC)";
    private static final String SELECT_BY_ID = "select ID, IDOPONT, KOMMENT_IRO_ID, POSZT_ID, SZOVEG, " +
            "ERTEKELES.LIKE_SZAMLALO as \"like\", ERTEKELES .DISLIKE_SZAMLALO as dislike, ISPUBLIC from KOMMENT where ID = :ID";
    private static final String UPDATE_BY_ID = "update KOMMENT k set IDOPONT = ?, KOMMENT_IRO_ID = ?, POSZT_ID = ?, " +
            "SZOVEG = ?, k.ERTEKELES = ERTEKELES(?, ?), ISPUBLIC = ? where ID = ?";
    private static final String DELETE_BY_ID = "delete from KOMMENT where ID = ?";
    private static final String SElECT_ALL_BY_POST_ID = "SELECT k.ID, k.IDOPONT, k.KOMMENT_IRO_ID, k.POSZT_ID, k.SZOVEG, k.ERTEKELES.LIKE_SZAMLALO as \"like\", k.ERTEKELES.DISLIKE_SZAMLALO as dislike, k.ISPUBLIC, f.NEV.VEZETEKNEV AS vnev, f.NEV.KERESZTNEV AS knev FROM KOMMENT k INNER JOIN FELHASZNALO f ON f.ID = k.KOMMENT_IRO_ID WHERE k.POSZT_ID = :POSZT_ID";

    public CommentRepo(JdbcTemplate jdbcTemplate, NamedParameterJdbcTemplate namedJdbc) {
        this.jdbcTemplate = jdbcTemplate;
        this.namedJdbc = namedJdbc;
    }

    private static Komment mapRow(ResultSet rs, int rowNum) throws SQLException {
        Komment comment = new Komment();
        comment.setId(rs.getLong("ID"));
        comment.setIdopont(rs.getDate("IDOPONT"));
        comment.setKommentIroId(rs.getLong("KOMMENT_IRO_ID"));
        comment.setSzerzoKNEV(rs.getString("knev"));
        comment.setSzerzoVNEV(rs.getString("vnev"));
        comment.setPosztId(rs.getLong("POSZT_ID"));
        comment.setSzoveg(rs.getString("SZOVEG"));
        comment.setLike(rs.getInt("LIKE"));
        comment.setDislike(rs.getInt("DISLIKE"));
        comment.setPublic(rs.getBoolean("ISPUBLIC"));
        return comment;
    }

    public Komment get(long id) {
        return jdbcTemplate.queryForObject(SELECT_BY_ID, CommentRepo::mapRow, id);
    }

    public List<Komment> getAll() {
        return jdbcTemplate.query(SELECT_ALL, CommentRepo::mapRow);
    }

    public Long save(Komment comment) {
        KeyHolder kh = new GeneratedKeyHolder();
        MapSqlParameterSource map = new MapSqlParameterSource()
                .addValue("IDOPONT", new Date(System.currentTimeMillis()))
                .addValue("KOMMENT_IRO_ID", comment.getKommentIroId())
                .addValue("POSZT_ID", comment.getPosztId())
                .addValue("SZOVEG", comment.getSzoveg())
                .addValue("LIKE", comment.getLike())
                .addValue("DISLIKE", comment.getDislike())
                .addValue("ISPUBLIC", comment.isPublic());
        try {
            namedJdbc.update(INSERT_COMMENT, map, kh, new String[]{"ID"});
        } catch (DataAccessException dae) {
            dae.printStackTrace();
            return null;
        }
        return kh.getKey().longValue();
    }

    public List<Komment> getAllByPostId(long id) {
        MapSqlParameterSource map = new MapSqlParameterSource("POSZT_ID", id);
        return namedJdbc.query(SElECT_ALL_BY_POST_ID, map, CommentRepo::mapRow);
    }

    public boolean update(long id, Komment to) {
        return jdbcTemplate.update(UPDATE_BY_ID, to.getIdopont(), to.getKommentIroId(), to.getPosztId(), to.getSzoveg(),
                to.getLike(), to.getDislike(), to.isPublic(), id) == 1;
    }

    public boolean delete(long id) {
        return jdbcTemplate.update(DELETE_BY_ID, id) == 1;
    }


}
