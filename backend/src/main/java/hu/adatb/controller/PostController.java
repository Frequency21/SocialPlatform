package hu.adatb.controller;


import hu.adatb.model.Post;
import hu.adatb.repository.PostRepo;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.http.HttpStatus;
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

    @RequestMapping(value = "/all", method = RequestMethod.GET)
    public ResponseEntity<List<Post>> getAllPost() {
        return ResponseEntity.ok(postRepo.getPosts());
    }

    @RequestMapping(value = "/user/{id}", method = RequestMethod.GET)
    public ResponseEntity<List<Post>> getPostByUserId(
            @PathVariable int id
    ) {
        return ResponseEntity.ok(postRepo.getPostByUserId(id));
    }

    @RequestMapping(value = "/group/{id}", method = RequestMethod.GET)
    public ResponseEntity<List<Post>> getPostByGroupId(
            @PathVariable int id
    ) {
        return ResponseEntity.ok(postRepo.getPostByCsoportId(id));
    }

    // TODO: 2021. 05. 07. post hozzáadás hírfolyamhoz
    @PostMapping(value = "/add")
    public long addPost(
            @RequestBody Post post
    ) {
        return postRepo.insertPost(post);
    }

    @DeleteMapping(value = "/{id}")
    public boolean deleteUser(
            @PathVariable("id") int id
    ) {
        return postRepo.deletePoszt(id);
    }

    @ExceptionHandler({DataIntegrityViolationException.class})
    public HttpStatus conflict() {
        return HttpStatus.CONFLICT;
    }

    @ExceptionHandler({EmptyResultDataAccessException.class})
    public HttpStatus empty() {
        return HttpStatus.NOT_FOUND;
    }
}
