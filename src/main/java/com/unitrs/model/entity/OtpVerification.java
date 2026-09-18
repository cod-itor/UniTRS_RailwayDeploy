package com.unitrs.model.entity;

import java.sql.Timestamp;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class OtpVerification {
    private int id;
    private String email;
    private String otpCode;
    private String otpType;
    private Timestamp expiresAt;
    private boolean isUsed;
    private Timestamp createdAt;
}
