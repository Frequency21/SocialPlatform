package hu.adatb.controller;

import hu.adatb.repository.UserRepo;
import hu.adatb.service.ImageService;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;


@RestController
@RequestMapping(value = "api/images")
public class ImageController {

    @Autowired
    private ImageService imageService;
    @Autowired
    private UserRepo userRepo;

    @PostMapping(value = "upload/user/{id}/profile")
    public ResponseEntity uploadImage(
            @RequestParam MultipartFile file,
            @PathVariable("id") long id
    ) {
        // TODO: 2021. 05. 06. save img path, change path in db-s to varcchar(500)..
        // userRepo.saveImage(...);
        return this.imageService.uploadToLocalFileSystem(file, "user", "profile", "" + id);
    }

    @GetMapping(
            value = "getImage/{imageName:.+}",
            produces = {MediaType.IMAGE_JPEG_VALUE, MediaType.IMAGE_GIF_VALUE, MediaType.IMAGE_PNG_VALUE}
    )
    public @ResponseBody
    byte[] getImageWithMediaType(@PathVariable(name = "imageName") String fileName) throws IOException {
        return this.imageService.getImageWithMediaType(fileName, "user", "tmp");
    }
}