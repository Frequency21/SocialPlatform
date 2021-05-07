
package hu.adatb.controller;

import hu.adatb.model.User;
import hu.adatb.repository.UserRepo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@RestController
@RequestMapping("/api/user/")
public class UserController {
    private final UserRepo userRepo;
    private final Logger log = LoggerFactory.getLogger(UserController.class);

    public UserController(UserRepo userRepo) {
        this.userRepo = userRepo;
    }

    @GetMapping(value = "")
    public ResponseEntity<User> getUser(
            @RequestParam("id") int id
    ) {
        User user = userRepo.getUser(id);
        return ResponseEntity.ok(user);
    }

    @GetMapping(value = "{id}")
    public ResponseEntity<User> getUserById(
            @PathVariable("id") int id
    ) {
        User user = userRepo.getUser(id);
        return ResponseEntity.ok(user);
    }

    @GetMapping(value = "all")
    public ResponseEntity<List<User>> getUsers() {
        List<User> users = userRepo.getUsers();
        return ResponseEntity.ok(users);
    }

    @GetMapping(value = "ismerosei/{id}")
    public List<User> getIsmerosei(@PathVariable("id") long id) {
        return userRepo.getIsmerosei(id);
    }

    @PostMapping(value = "login")
    public User login(
            @RequestParam("email") String email,
            @RequestParam("jelszo") String password
    ) {
        return userRepo.getUser(email, password);
    }

    @PostMapping(value = "register")
    public Long register(
            @RequestBody User user
    ) {
        return userRepo.insertUser(user);
    }

    @PostMapping(value = "update")
    public Long updateUser(
            @RequestBody User user
    ) {

        return userRepo.updateUser(user);
    }

    // TODO: 2021. 05. 07. ismerősnek jelölés
    // /api/user?id_1=1&id_2=2
    @PostMapping(value = "{id_1}/{id_2}")
    public boolean friendRequest(
            @RequestParam("id_1") long id1,
            @RequestParam("id_2") long id2
    ) {
        return true;
    }

    @DeleteMapping(value = "{id}")
    public boolean deleteUser(
            @PathVariable("id") int id
    ) {
        return userRepo.deleteUser(id);
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
