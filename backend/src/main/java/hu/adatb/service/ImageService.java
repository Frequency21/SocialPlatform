package hu.adatb.service;

import org.apache.commons.io.IOUtils;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.io.File;
import java.io.IOException;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;


@Service
public class ImageService {

    public final String storageDirectoryPath = System.getProperty("user.dir") + File.separatorChar + "uploads" +
            File.separatorChar;

    public ResponseEntity uploadToLocalFileSystem(MultipartFile file, String... prefixPath) {
        String fileName = StringUtils.cleanPath(file.getOriginalFilename());
        Path storageDirectory = Paths.get(storageDirectoryPath + String.join("" + File.separatorChar,
                prefixPath));

        if (!Files.exists(storageDirectory)) { // if the folder does not exist
            try {
                Files.createDirectories(storageDirectory);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        Path destination = Paths.get(storageDirectory.toString() + File.separatorChar + fileName);

        try {
            Files.copy(file.getInputStream(), destination, StandardCopyOption.REPLACE_EXISTING);
        } catch (IOException e) {
            e.printStackTrace();
        }

        // the response will be the download URL of the image
        String fileDownloadUri = ServletUriComponentsBuilder.fromCurrentContextPath()
                .path("api/images/getImage/")
                .path(fileName)
                .toUriString();
        // return the download image url as a response entity
        return ResponseEntity.ok(fileDownloadUri);
    }

    public byte[] getImageWithMediaType(String imageName, String... prefixPath) throws IOException {
        Path destination = Paths.get(storageDirectoryPath + String.join("" + File.separatorChar, prefixPath)
                + File.separatorChar + imageName);// retrieve the image by its name
        return IOUtils.toByteArray(destination.toUri());
    }


}