package com.unitrs.model.entity;

import java.sql.Timestamp;

import com.unitrs.utils.FormatUtils;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Enrollment {
    private int id;
    private int studentId;
    private int classSectionId;
    private Timestamp enrolledAt;

    private String studentIdentifier;
    private String studentName;
    private String studentEmail;
    private String courseCode;
    private String courseTitle;
    private int credits;
    private SessionShift sessionShift;
    private String room;
    private String daysOfWeek;
    private String professorName;
    private String termName;
    private String academicYear;

    public String getFormattedStudentIdentifier() {
        return FormatUtils.formatIdentifier(this.studentIdentifier);
    }
}
