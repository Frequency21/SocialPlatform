package hu.adatb.controller;

import hu.adatb.model.Comment;
import hu.adatb.repository.CommentRepo;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;


@RestController
@RequestMapping(value = "/api/komment/")
public class CommentController {

    private final CommentRepo commentRepo;

    public CommentController(CommentRepo commentRepo) {
        this.commentRepo = commentRepo;
    }

    @GetMapping("{id}")
    public Comment get(
            @PathVariable("id") long id
    ) {
        return commentRepo.get(id);
    }

    @GetMapping("all")
    public List<Comment> getAll() {
        return commentRepo.getAll();
    }

    @PutMapping("{id}")
    public boolean update(
            @PathVariable("id") long id,
            @RequestBody Comment to
    ) {
        return commentRepo.update(id, to);
    }

    // TODO: 2021. 05. 07. összes komment adott poszthoz idősorrendben növekvő
    @GetMapping(value = "posztok/{id}")
    public List<Comment> getCommentsForPost(
            @PathVariable("id") long id
    ) {
        return new ArrayList<>();
    }

    // TODO: 2021. 05. 07. kommentelés poszt alá
    @PostMapping(value = "{poszt_id}")
    public long getCommentsForPost(
            @PathVariable("poszt_id") long posztId,
            @RequestBody Comment comment
    ) {
        return 1;
    }

    @DeleteMapping("{id}")
    public boolean delete(
            @PathVariable("id") long id
    ) {
        return commentRepo.delete(id);
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