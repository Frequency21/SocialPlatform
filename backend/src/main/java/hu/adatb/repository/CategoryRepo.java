package hu.adatb.repository;


import hu.adatb.model.Category;
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
public class CategoryRepo {
    private final NamedParameterJdbcTemplate namedJdbc;
    private final JdbcTemplate jdbcTemplate;
    private static final String SELECT_ALL = "select * from KATEGORIA";
    private static final String SELECT_BY_FELH_ID = "select * from KATEGORIA where FELH_ID = :FELH_ID";
    private static final String SAVE_CATEGORY = "insert into KATEGORIA(NEV, FELH_ID) VALUES (:NEV, :FELH_ID)";
    private static final String DELETE_CATEGORY = "delete from KATEGORIA where NEV = ? and FELH_ID = ?";

    public CategoryRepo(NamedParameterJdbcTemplate namedJdbc, JdbcTemplate jdbcTemplate) {
        this.namedJdbc = namedJdbc;
        this.jdbcTemplate = jdbcTemplate;
    }

    private static Category mapRow(ResultSet rs, int i) throws SQLException {
        Category category = new Category();
        category.setNev(rs.getString("NEV"));
        category.setFelhId(rs.getLong("FELH_ID"));
        return category;
    }

    public Category get(long id) {
        return namedJdbc.queryForObject(
                SELECT_BY_FELH_ID,
                new MapSqlParameterSource("FELH_ID", id),
                CategoryRepo::mapRow
        );
    }

    public List<Category> getAll() {
        return jdbcTemplate.query(SELECT_ALL, CategoryRepo::mapRow);
    }

    public boolean save(Category category) {
        return namedJdbc.update(
                SAVE_CATEGORY,
                new MapSqlParameterSource()
                .addValue("NEV", category.getNev())
                .addValue("FELH_ID", category.getFelhId())) == 1;
    }

    public boolean delete(Category category) {
        return jdbcTemplate.update(DELETE_CATEGORY, category.getNev(), category.getFelhId()) == 1;
    }
}
