package es.backend.util;

import es.backend.exception.InvalidFileException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Base64;

@Component
@Slf4j
public class FileUtil {

    public static String processImageToBase64(MultipartFile file) throws IOException {

        if (file == null || file.isEmpty() || file.getSize() == 0) {
            throw new InvalidFileException("File is empty.");
        }


        if (!"image/jpeg".equals(file.getContentType()) && !"image/png".equals(file.getContentType())) {
            throw new InvalidFileException("Invalid file. Must send JPG o PNG type file.");
        }

        log.info("Processing image to Base64.");
        byte[] imagesBytes = file.getBytes();
        return Base64.getEncoder().encodeToString(imagesBytes);
    }
}