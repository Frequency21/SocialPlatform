package hu.adatb.controller;


import hu.adatb.model.Message;
import hu.adatb.repository.MessageRepo;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;


// TODO: 2021. 05. 07.
@RestController
@RequestMapping(value = "/api/message")
public class MessageController {

    private final MessageRepo messageRepo;

    public MessageController(MessageRepo messageRepo) {
        this.messageRepo = messageRepo;
    }

    @GetMapping
    public List<Message> getMessages(
            @RequestParam("id_1") long id1,
            @RequestParam("id_2") long id2
    ) {
        return messageRepo.getAll(id1, id2);
    }

    @GetMapping("/{id_1}/{id_2}")
    public List<Message> getMessagesPathV(
            @PathVariable("id_1") long id1,
            @PathVariable("id_2") long id2
    ) {
        return messageRepo.getAll(id1, id2);
    }

    @PostMapping
    public boolean sendMessage(@RequestBody Message message) {
        return messageRepo.insert(message);
    }

    @DeleteMapping(value = "/{id}")
    public boolean delete(@PathVariable("id") long id) {
        return messageRepo.delete(id);
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
