package com.unitrs.model.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor

public class AttendanceRecord {
    private int id;
    private int classSectionId;
    private Date sessionDate;
    private Timestamp createdAt;
    private int presentCount;
    private int absentCount;
    private int lateCount;
    private int excusedCount;
    private List<AttendanceEntry> entries;

}
