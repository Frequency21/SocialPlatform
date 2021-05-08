package hu.adatb.controller;


import hu.adatb.model.Picture;
import hu.adatb.repository.PictureRepo;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@RestController
@RequestMapping("/api/picture")
public class PictureController {
    private final PictureRepo pictureRepo;

    public PictureController(PictureRepo pictureRepo) {
        this.pictureRepo = pictureRepo;
    }

    @GetMapping("/all")
    public List<Picture> getAll(
            @RequestParam("kat_nev") String katNev,
            @RequestParam("felh_id") String felhId
    ) {
        return pictureRepo.getAll(katNev, felhId);
    }
}
