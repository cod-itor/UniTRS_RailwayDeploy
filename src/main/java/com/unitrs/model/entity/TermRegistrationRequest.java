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
}
