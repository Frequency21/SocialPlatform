package hu.adatb.controller;


import hu.adatb.model.Message;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;


// TODO: 2021. 05. 07.
@RestController(value = "/api/message/")
public class MessageController {

    @GetMapping("{id-1}/{id_2}")
    public List<Message> getMessages(
            @RequestParam("id_1") long id1,
            @RequestParam("id_2") long id2
    ) {
        return new ArrayList<>();
    }

    @PostMapping("{id-1}/{id_2}")
    public long sendMessage(
            @RequestBody Message message
    ) {
        return 1;
    }


}
