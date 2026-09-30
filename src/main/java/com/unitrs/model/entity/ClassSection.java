package com.unitrs.model.entity;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ClassSection {
    private int id;
    private int termId;
    private int courseId;
    private int schoolId;
    private int professorId;
    private int roomId;
    private SessionShift sessionShift;
    private String daysOfWeek;
    private String academicYear;
    private java.sql.Date startDate;
    private java.sql.Date endDate;
    private String courseCode;
    private String courseTitle;
    private int credits;
    private String professorName;
    private String termName;
    private String roomName;
    private int roomCapacity;
    private int enrolledCount;

    private static final java.time.format.DateTimeFormatter DATE_LABEL =
            java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy", java.util.Locale.ENGLISH);

    public String getStartDateLabel() {
        return startDate == null ? "" : startDate.toLocalDate().format(DATE_LABEL);
    }

    public String getEndDateLabel() {
        return endDate == null ? "" : endDate.toLocalDate().format(DATE_LABEL);
    }
}
