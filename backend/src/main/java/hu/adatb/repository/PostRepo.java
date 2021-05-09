package hu.adatb.repository;

import hu.adatb.model.Post;
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
import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


@Repository
public class PostRepo {
    private final NamedParameterJdbcTemplate namedJdbc;
    private final JdbcTemplate jdbcTemplate;

    private static final String SELECT_ALL = "select IDOPONT, SZERZO_ID, CSOPORT_ID, FELHASZNALO_ID, SZOVEG, " +
            "p.ERTEKELES.LIKE_SZAMLALO as \"like\", p.ERTEKELES.DISLIKE_SZAMLALO as dislike, ISPUBLIC from POSZT p";

    private static final String SELECT_ALL_BY_USER_ID = "select IDOPONT, SZERZO_ID, CSOPORT_ID, FELHASZNALO_ID, SZOVEG, " +
            "p.ERTEKELES.LIKE_SZAMLALO as \"like\", p.ERTEKELES.DISLIKE_SZAMLALO as dislike, ISPUBLIC from POSZT p " +
            "where FELHASZNALO_ID = :FELHASZNALO_ID";
    private static final String INSERT_POSZT =
            "INSERT INTO POSZT(IDOPONT, SZERZO_ID, CSOPORT_ID, FELHASZNALO_ID, SZOVEG, ERTEKELES, ISPUBLIC)" +
            "VALUES(:IDOPONT, :SZERZO_ID, :CSOPORT_ID, :FELHASZNALO_ID, :SZOVEG, ERTEKELES(:LIKE , :DISLIKE), :ISPUBLIC)";

    public PostRepo(NamedParameterJdbcTemplate namedJdbc, JdbcTemplate jdbcTemplate) {
        this.namedJdbc = namedJdbc;
        this.jdbcTemplate = jdbcTemplate;
    }


    private static List<Post> extractPosts(ResultSet rs) throws SQLException {
        List<Post> result = new ArrayList<>();
        Post post;
        while (rs.next()) {
            post = getPost(rs);
            result.add(post);
        }
        return result;
    }

    private static Post extractPost(ResultSet rs) throws SQLException {
        Post result = new Post();
        if (rs.next()) result = getPost(rs);
        return result;
    }

    private static Post getPost(ResultSet rs) throws SQLException {
        Post result;
        result = new Post();
        result.setIdopont(rs.getDate("IDOPONT"));
        result.setSzerzoId(rs.getInt("SZERZO_ID"));
        result.setCsoportId(rs.getInt("CSOPORT_ID"));
        result.setFelhasznaloId(rs.getInt("FELHASZNALO_ID"));
        result.setSzoveg(rs.getString("SZOVEG"));
        result.setLike(rs.getInt("LIKE"));
        result.setDislike(rs.getInt("DISLIKE"));
        return result;
    }

    public Long insertPost(Post post) {
        System.out.println(post);
        KeyHolder kh = new GeneratedKeyHolder();
        MapSqlParameterSource map = new MapSqlParameterSource()
                .addValue("IDOPONT", new Date(System.currentTimeMillis()))
                .addValue("SZERZO_ID", post.getSzerzoId())
                .addValue("CSOPORT_ID", post.getCsoportId() == 0 ? null : post.getCsoportId())
                .addValue("FELHASZNALO_ID", post.getFelhasznaloId() == 0 ? null : post.getFelhasznaloId())
                .addValue("SZOVEG", post.getSzoveg())
                .addValue("LIKE", post.getLike())
                .addValue("DISLIKE", post.getDislike())
                .addValue("ISPUBLIC", post.isPublic());
        try {
            namedJdbc.update(INSERT_POSZT, map, kh, new String[]{"ID"});
        } catch (DataAccessException dae) {
            dae.printStackTrace();
            return null;
        }
        return kh.getKey().longValue();
    }

    @Transactional
    public List<Post> getPosts() {
        List<Post> res = jdbcTemplate.query(SELECT_ALL, PostRepo::extractPosts);
        return jdbcTemplate.query(SELECT_ALL, PostRepo::extractPosts);
    }

    @Transactional
    public List<Post> getPostByUserId(int id) {
        MapSqlParameterSource map = new MapSqlParameterSource("FELHASZNALO_ID", id);
        return namedJdbc.query(SELECT_ALL_BY_USER_ID, map, PostRepo::extractPosts);
    }

}
