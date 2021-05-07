package hu.adatb.controller;

import hu.adatb.model.Group;
import hu.adatb.repository.GroupRepo;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@RestController
@RequestMapping("/api/group/")
public class GroupController {
    private final GroupRepo groupRepo;

    public GroupController(GroupRepo groupRepo) {
        this.groupRepo = groupRepo;
    }

    @GetMapping(value = "{id}")
    public Group getGroupById(@PathVariable("id") long id) {
        return groupRepo.get(id);
    }

    @GetMapping(value = "all")
    public List<Group> getAllGroup() {
        return groupRepo.getAll();
    }

    @PostMapping(value = "add")
    public Long save(@RequestBody Group group) {
        return groupRepo.save(group);
    }

    @DeleteMapping(value = "{id}")
    public boolean delete(@PathVariable("id") long id) {
        return groupRepo.delete(id);
    }

    @PatchMapping(value = "{id}")
    public boolean update(
            @RequestBody Group group,
            @PathVariable("id") long id
    ) {
        return groupRepo.update(id, group);
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