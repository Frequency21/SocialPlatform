package hu.adatb.controller;


import hu.adatb.model.Post;
import hu.adatb.repository.PostRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@RestController
@RequestMapping("/post")
public class PostController {
    @Autowired
    PostRepo postRepo;
    @Autowired
    JdbcTemplate jdbcTemplate;

    @RequestMapping(value = "all", method = RequestMethod.GET)
    public ResponseEntity<List<Post>> getAllPost() {
        return ResponseEntity.ok(postRepo.getPosts());
    }

    @RequestMapping(value = "{id}", method = RequestMethod.GET)
    public ResponseEntity<List<Post>> getPostByUserId(
            @PathVariable int id
    ) {
        return ResponseEntity.ok(postRepo.getPostByUserId(id));
    }

}
