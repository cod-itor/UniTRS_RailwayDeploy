package com.unitrs.model.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import java.sql.Date;

import com.unitrs.utils.FormatUtils;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class AttendanceEntry {
    private int id;
    private int attendanceRecordId;
    private int studentId;
    private String status;

    private String studentName;
    private String studentIdentifier;
    private Date sessionDate;

    public String getFormattedStudentIdentifier() {
        return FormatUtils.formatIdentifier(this.studentIdentifier);
    }
}
