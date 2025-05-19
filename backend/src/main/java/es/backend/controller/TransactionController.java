package es.backend.controller;

import es.backend.util.GeminiUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestClient;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

import static es.backend.util.FileUtil.processImageToBase64;

@RestController
@RequestMapping("/transactions")
@Slf4j
public class TransactionController {

    private final RestClient restClient;
    private final GeminiUtil geminiUtil;

    @Value("${spring.ai.openai.api-key}")
    private String OPEN_IA_API_KEY;

    public TransactionController(RestClient restClient, GeminiUtil geminiUtil) {
        this.restClient = restClient;
        this.geminiUtil = geminiUtil;
    }

    @PostMapping("/upload-receipt")
    private ResponseEntity<?> processReceiptImage(@RequestParam("file") MultipartFile file) throws IOException {
        String imageToBase64 = processImageToBase64(file);

        log.info("Send request to AI chat to process receipt image.");
        String jsonResponse = restClient.post()
                .uri(String.format("/v1beta/models/gemini-2.0-flash:generateContent?key=%s", OPEN_IA_API_KEY))
                .body(geminiUtil.getGeminiPrompt(imageToBase64))
                .retrieve()
                .body(String.class);

        return ResponseEntity.ok(geminiUtil.mapResponseToDto(jsonResponse));
    }
}