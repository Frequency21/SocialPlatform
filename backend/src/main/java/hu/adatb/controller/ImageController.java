package hu.adatb.controller;

import hu.adatb.repository.UserRepo;
import hu.adatb.service.ImageService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@RestController
@RequestMapping(value = "/api/")
public class ImageController {

    private final ImageService imageService;
    private final UserRepo userRepo;
    private final Logger log = LoggerFactory.getLogger(ImageController.class);

    public ImageController(ImageService imageService, UserRepo userRepo) {
        this.imageService = imageService;
        this.userRepo = userRepo;
    }

    @PostMapping(value = "user/profile/{id}")
    public ResponseEntity<String> uploadProfileImage(
            @RequestParam MultipartFile file,
            @PathVariable("id") long id
    ) {
        String uri = imageService.uploadToLocalFileSystem(file, "/api/user/profile/", "" + id, "user", "profile");
        userRepo.savePicture(id, uri);
        return ResponseEntity.ok(uri);
    }

    @GetMapping(
            value = "user/profile/{id}",
            produces = {MediaType.IMAGE_JPEG_VALUE, MediaType.IMAGE_GIF_VALUE, MediaType.IMAGE_PNG_VALUE}
    )
    public byte[] getProfileImage(
            @PathVariable("id") long id
    ) throws IOException {
        log.debug("/api/user/profile/" + id);
        return imageService.getImage("" + id, "user", "profile");
    }

}