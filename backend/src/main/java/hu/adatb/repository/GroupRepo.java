package hu.adatb.repository;


import hu.adatb.model.Group;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;


@Repository
public class GroupRepo {
    @Autowired
    private NamedParameterJdbcTemplate namedJdbc;
    @Autowired
    private JdbcTemplate jdbcTemplate;


//    public Group getById(long id) {
//        return jdbcTemplate
//    }

}
