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
    private String courseCode;
    private String courseTitle;
    private int credits;
    private String professorName;
    private String termName;
    private String roomName;
    private int roomCapacity;
    private int enrolledCount;
}
