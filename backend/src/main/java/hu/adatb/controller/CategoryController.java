package hu.adatb.controller;


import hu.adatb.model.Category;
import hu.adatb.repository.CategoryRepo;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@RestController
@RequestMapping("/api/category")
public class CategoryController {
    private final CategoryRepo categoryRepo;

    public CategoryController(CategoryRepo categoryRepo) {
        this.categoryRepo = categoryRepo;
    }

    @GetMapping("/{id}/{nev}")
    public Category get(
            @PathVariable("id") long id,
            @PathVariable("nev") String name
    ) {
        return categoryRepo.get(id, name);
    }

    @GetMapping("/all")
    public List<Category> getAll() {
        return categoryRepo.getAll();
    }

    @GetMapping("/{id}")
    public List<Category> getAllById(
            @PathVariable("id") long id
    ) {
        return categoryRepo.getAllById(id);
    }

    /* return generated id */
    @PostMapping
    public boolean save(@RequestBody Category category) {
        return categoryRepo.save(category);
    }

    /* success? */
    @DeleteMapping()
    public boolean delete(@RequestBody Category category) {
        return categoryRepo.delete(category);
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
