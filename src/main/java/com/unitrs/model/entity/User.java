package com.unitrs.model.entity;

import java.sql.Timestamp;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class User {
    private int id;
    private String userIdentifier;
    private String password;
    private String fullName;
    private String email;
    private Role role;
    private String major;
    private boolean isVerified;
    private boolean isActive;
    private Integer deanSchoolId;
    private Integer studentSchoolId;
    private boolean twoFactorEnabled;
    private Timestamp createdAt;

    public boolean isTwoFactorEnabled() {
        return twoFactorEnabled;
    }

    public void setTwoFactorEnabled(boolean twoFactorEnabled) {
        this.twoFactorEnabled = twoFactorEnabled;
    }
}
