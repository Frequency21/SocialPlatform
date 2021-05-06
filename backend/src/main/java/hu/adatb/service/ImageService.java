package hu.adatb.service;

import org.apache.commons.io.IOUtils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

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
    private final Logger log = LoggerFactory.getLogger(this.getClass());

    public String uploadToLocalFileSystem(MultipartFile file, String apiPath, String name, String... prefixPath) {
        Path storageDirectory = Paths.get(storageDirectoryPath + String.join("" + File.separatorChar, prefixPath));

        if (!Files.exists(storageDirectory)) { // if the folder does not exist
            try {
                Files.createDirectories(storageDirectory);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        Path destination = Paths.get(storageDirectory.toString() + File.separatorChar + name);

        try {
            Files.copy(file.getInputStream(), destination, StandardCopyOption.REPLACE_EXISTING);
        } catch (IOException e) {
            e.printStackTrace();
        }

        String result = ServletUriComponentsBuilder
                .fromCurrentContextPath()
                .path(apiPath)
                .path(name)
                .toUriString();
        log.debug("uploadToLocalFileSystem: " + result);
        return result;
    }

    public byte[] getImage(String name, String... prefixPath) throws IOException {
        Path destination = Paths.get(storageDirectoryPath + String.join("" + File.separatorChar, prefixPath)
                + File.separatorChar + name);// retrieve the image by its name
        log.debug("getImage: " + destination);
        return IOUtils.toByteArray(destination.toUri());
    }

}