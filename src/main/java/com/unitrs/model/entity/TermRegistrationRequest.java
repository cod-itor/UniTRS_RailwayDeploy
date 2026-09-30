package com.unitrs.model.entity;

import java.sql.Timestamp;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class TermRegistrationRequest {
    private int id;
    private int studentId;
    private int termId;
    private String status;
    private Timestamp createdAt;

    private String studentName;
    private String studentIdentifier;
    private String termName;
    private int termNumber;

    private static final java.time.format.DateTimeFormatter LABEL_FORMAT =
            java.time.format.DateTimeFormatter.ofPattern("MMM dd, yyyy HH:mm", java.util.Locale.ENGLISH);

    public String getCreatedAtLabel() {
        return createdAt == null ? "" : createdAt.toLocalDateTime().format(LABEL_FORMAT);
    }
}
