package hu.adatb.repository;

import hu.adatb.model.Post;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;


@Repository
public class PostRepo {
    @Autowired
    private NamedParameterJdbcTemplate namedJdbc;
    @Autowired
    private JdbcTemplate jdbcTemplate;

    private static final String SELECT_ALL = "select IDOPONT, SZERZO_ID, CSOPORT_ID, FELHASZNALO_ID, SZOVEG, " +
            "p.ERTEKELES.LIKE_SZAMLALO as \"like\", p.ERTEKELES.DISLIKE_SZAMLALO as dislike, ISPUBLIC from POSZT p";

    private static final String SELECT_ALL_BY_USER_ID = "select IDOPONT, SZERZO_ID, CSOPORT_ID, FELHASZNALO_ID, SZOVEG, " +
            "p.ERTEKELES.LIKE_SZAMLALO as \"like\", p.ERTEKELES.DISLIKE_SZAMLALO as dislike, ISPUBLIC from POSZT p " +
            "where FELHASZNALO_ID = :FELHASZNALO_ID";


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
