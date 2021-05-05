package hu.adatb.controller;

import hu.adatb.model.User;
import hu.adatb.repository.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;


@RestController
@RequestMapping("api/user")
public class UserController {
    @Autowired
    private UserRepo userRepo;

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

    @RequestMapping(value = "/test", method = RequestMethod.GET)
    public ResponseEntity<?> testing() {
        HashMap<String, Object> result = new HashMap<>();
        result.put("name", "taylor");
        ArrayList<String> array = new ArrayList<String>();
        array.add("21");
        array.add("42");
        result.put("favorite numbers", array);
        return ResponseEntity.ok(result);
    }
}
