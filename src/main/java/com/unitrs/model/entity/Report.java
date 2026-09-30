package com.unitrs.model.entity;

import java.sql.Timestamp;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Report {
    private int id;
    private int reporterId;
    private String reporterName;
    private String reporterRole;
    private Integer schoolId;
    private String category;
    private String issue;
    private String details;
    private Timestamp createdAt;

    private String reporterIdentifier;
    private String reporterEmail;

    private static final java.time.format.DateTimeFormatter LABEL_FORMAT =
            java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy, HH:mm", java.util.Locale.ENGLISH);

    public String getCreatedAtLabel() {
        return createdAt == null ? "" : createdAt.toLocalDateTime().format(LABEL_FORMAT);
    }
}
