package es.backend.exception.handler;

import com.fasterxml.jackson.core.JsonProcessingException;
import es.backend.exception.InvalidFileException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.io.IOException;

import static org.springframework.http.HttpStatus.BAD_REQUEST;

@RestControllerAdvice
@Order(Ordered.HIGHEST_PRECEDENCE)
@Slf4j
public class GlobalExceptionHandler {

    @ExceptionHandler(InvalidFileException.class)
    public ResponseEntity<?> handleInvalidFileException(InvalidFileException ex) {
        return new ResponseEntity<>(ex.getMessage(), BAD_REQUEST);
    }

    @ExceptionHandler(IOException.class)
    public ResponseEntity<?> handleIOException(IOException ex) {
        return new ResponseEntity<>("Failed to process image to bytes: " + ex.getMessage(), BAD_REQUEST);
    }

    @ExceptionHandler(JsonProcessingException.class)
    public ResponseEntity<?> handleJsonProcessingException(JsonProcessingException ex) {
        return new ResponseEntity<>("Failed to mapping JSON: " + ex.getMessage(), BAD_REQUEST);
    }
}