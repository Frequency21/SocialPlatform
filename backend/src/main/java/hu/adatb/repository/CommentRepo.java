package hu.adatb.repository;

import hu.adatb.model.Comment;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;


@Repository
public class CommentRepo {
    private final JdbcTemplate jdbcTemplate;
    private final NamedParameterJdbcTemplate namedJdbc;
    private static final String SELECT_ALL = "";
    private static final String SELECT_BY_ID = "select ID, IDOPONT, KOMMENT_IRO_ID, POSZT_ID, SZOVEG, " +
            "ERTEKELES.LIKE_SZAMLALO as \"like\", ERTEKELES.DISLIKE_SZAMLALO as dislike, ISPUBLIC from KOMMENT where ID = :ID";
    private static final String UPDATE_BY_ID = "update KOMMENT k set IDOPONT = ?, KOMMENT_IRO_ID = ?, POSZT_ID = ?, " +
            "SZOVEG = ?, k.ERTEKELES = ERTEKELES(?, ?), ISPUBLIC = ? where ID = ?";
    private static final String DELETE_BY_ID = "delete from KOMMENT where ID = ?";

    public CommentRepo(JdbcTemplate jdbcTemplate, NamedParameterJdbcTemplate namedJdbc) {
        this.jdbcTemplate = jdbcTemplate;
        this.namedJdbc = namedJdbc;
    }

    private static Comment mapRow(ResultSet rs, int rowNum) throws SQLException {
        Comment comment = new Comment();
        comment.setId(rs.getLong("ID"));
        comment.setIdopont(rs.getDate("IDOPONT"));
        comment.setKommentIroId(rs.getLong("KOMMENT_IRO_ID"));
        comment.setPosztId(rs.getLong("POSZT_ID"));
        comment.setSzoveg(rs.getString("SZOVEG"));
        comment.setLike(rs.getInt("LIKE"));
        comment.setDislike(rs.getInt("DISLIKE"));
        comment.setPublic(rs.getBoolean("ISPUBLIC"));
        return comment;
    }

    public Comment get(long id) {
        return jdbcTemplate.queryForObject(SELECT_BY_ID, CommentRepo::mapRow, id);
    }

    public List<Comment> getAll() {
        return jdbcTemplate.query(SELECT_ALL, CommentRepo::mapRow);
    }

    public boolean update(long id, Comment to) {
        return jdbcTemplate.update(UPDATE_BY_ID, to.getIdopont(), to.getKommentIroId(), to.getPosztId(), to.getSzoveg(),
                to.getLike(), to.getDislike(), to.isPublic(), id) == 1;
    }

    public boolean delete(long id) {
        return jdbcTemplate.update(DELETE_BY_ID, id) == 1;
    }


}
