package hu.adatb.controller;


import hu.adatb.model.Post;
import hu.adatb.repository.PostRepo;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@RestController
@RequestMapping("api/post")
public class PostController {
    private final PostRepo postRepo;

    public PostController(PostRepo postRepo, JdbcTemplate jdbcTemplate) {
        this.postRepo = postRepo;
    }

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
