package com.unitrs.model.entity;

import java.sql.Timestamp;

import com.unitrs.utils.FormatUtils;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Grade {
    private int id;
    private int enrollmentId;
    private double attendanceScore;
    private double assignmentScore;
    private double midtermScore;
    private double finalScore;
    private double totalScore;
    private String letterGrade = "F";
    private double gpaPoint;
    private Timestamp updatedAt;

    private int studentId;
    private String studentIdentifier;
    private String studentName;
    private String studentEmail;
    private String courseCode;
    private String courseTitle;
    private int credits;
    private String termName;
    private int termNumber;
    private SessionShift sessionShift;
    private String academicYear;

    public String getFormattedStudentIdentifier() {
        return FormatUtils.formatIdentifier(this.studentIdentifier);
    }
}
