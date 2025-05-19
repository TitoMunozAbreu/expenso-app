package es.backend.util;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import es.backend.dto.response.TransactionResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
@Slf4j
public class GeminiUtil {

    @Autowired
    private ObjectMapper mapper;

    @Value("${spring.ai.receipt.prompt}")
    private String AI_RECEIPT_PROMPT;

    @Value("${gemini.body.template}")
    private String GEMINI_BODY_TEMPLATE;

    public String getGeminiPrompt(String imageBase64) {
        return String.format(GEMINI_BODY_TEMPLATE, AI_RECEIPT_PROMPT, imageBase64);
    }

    public TransactionResponse mapResponseToDto(String jsonResponse) throws JsonProcessingException {
        JsonNode root = mapper.readTree(jsonResponse);

        String jsonText = root
                .path("candidates")
                .get(0)
                .path("content")
                .path("parts")
                .get(0)
                .path("text")
                .asText();

        String cleanedJson = jsonText
                .replaceAll("(?s)```json|```", "")
                .trim();
        log.info("Mapping AI response.");
        return mapper.readValue(cleanedJson, TransactionResponse.class);
    }

}