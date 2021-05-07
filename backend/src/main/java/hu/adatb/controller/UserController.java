
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

    @RequestMapping(value = "", method = RequestMethod.GET)
    public ResponseEntity<User> getUser(
            @RequestParam("id") int id
    ) {
        User user = userRepo.getUser(id);
        return ResponseEntity.ok(user);
    }

    @RequestMapping(value = "{id}", method = RequestMethod.GET)
    public ResponseEntity<User> getUserById(
            @PathVariable("id") int id
    ) {
        User user = userRepo.getUser(id);
        return ResponseEntity.ok(user);
    }

    @RequestMapping(value = "all", method = RequestMethod.GET)
    public ResponseEntity<List<User>> getUsers() {
        List<User> users = userRepo.getUsers();
        return ResponseEntity.ok(users);
    }

    @RequestMapping(value = "login", method = RequestMethod.POST)
    public User login(
            @RequestParam("email") String email,
            @RequestParam("jelszo") String password
    ) {
        return userRepo.getUser(email, password);
    }

    @RequestMapping(value = "register", method = RequestMethod.POST)
    public Long register(
            @RequestBody User user
    ) {
        return userRepo.insertUser(user);
    }

    @RequestMapping(value = "update", method = RequestMethod.POST)
    public Long updateUser(
            @RequestBody User user
    ) {

        return userRepo.updateUser(user);
    }

    @RequestMapping(value = "{id}", method = RequestMethod.DELETE)
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
