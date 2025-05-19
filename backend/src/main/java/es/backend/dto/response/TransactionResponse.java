package es.backend.dto.response;

import java.time.LocalDate;

public record TransactionResponse(boolean valid,
                                  String reason,
                                  String storeName,
                                  LocalDate date,
                                  String totalAmount,
                                  String category) {
}