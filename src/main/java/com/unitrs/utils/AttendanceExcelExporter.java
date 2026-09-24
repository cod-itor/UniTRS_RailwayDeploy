package com.unitrs.utils;

import com.unitrs.model.entity.AttendanceEntry;
import com.unitrs.model.entity.AttendanceRecord;
import com.unitrs.model.entity.ClassSection;
import com.unitrs.model.entity.School;
import com.unitrs.model.entity.User;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.*;

public class AttendanceExcelExporter {

    private static final byte[] COLOR_NAVY = new byte[]{(byte) 15, (byte) 23, (byte) 42};
    private static final byte[] COLOR_ROYAL = new byte[]{(byte) 37, (byte) 99, (byte) 235};
    private static final byte[] COLOR_HEADER_BG = new byte[]{(byte) 30, (byte) 41, (byte) 59};
    private static final byte[] COLOR_CARD_BG = new byte[]{(byte) 241, (byte) 245, (byte) 249};
    private static final byte[] COLOR_ZEBRA = new byte[]{(byte) 248, (byte) 250, (byte) 252};
    private static final byte[] COLOR_BORDER = new byte[]{(byte) 203, (byte) 213, (byte) 225};

    private static final byte[] BG_PRESENT = new byte[]{(byte) 220, (byte) 252, (byte) 231};
    private static final byte[] FG_PRESENT = new byte[]{(byte) 22, (byte) 101, (byte) 52};

    private static final byte[] BG_ABSENT = new byte[]{(byte) 254, (byte) 226, (byte) 226};
    private static final byte[] FG_ABSENT = new byte[]{(byte) 153, (byte) 27, (byte) 27};

    private static final byte[] BG_LATE = new byte[]{(byte) 254, (byte) 243, (byte) 199};
    private static final byte[] FG_LATE = new byte[]{(byte) 146, (byte) 64, (byte) 14};

    private static final byte[] BG_EXCUSED = new byte[]{(byte) 224, (byte) 242, (byte) 254};
    private static final byte[] FG_EXCUSED = new byte[]{(byte) 7, (byte) 89, (byte) 133};

    private static final byte[] BG_UNMARKED = new byte[]{(byte) 241, (byte) 245, (byte) 249};
    private static final byte[] FG_UNMARKED = new byte[]{(byte) 148, (byte) 163, (byte) 184};

    public static byte[] exportSectionAttendance(ClassSection section, User professor, School school,
                                                 List<User> students, List<AttendanceRecord> records) throws IOException {
        try (XSSFWorkbook workbook = new XSSFWorkbook()) {
            StylePalette styles = new StylePalette(workbook);

            String sheetName = sanitizeSheetName(section.getCourseCode() != null ? section.getCourseCode() + " - Sec " + section.getId() : "Attendance");
            Sheet sheet = workbook.createSheet(sheetName);

            buildSectionSheet(sheet, styles, section, professor, school, students, records);

            try (ByteArrayOutputStream out = new ByteArrayOutputStream()) {
                workbook.write(out);
                return out.toByteArray();
            }
        }
    }

    public static byte[] exportAllSectionsAttendance(User professor, School school,
                                                    Map<ClassSection, List<User>> sectionStudentsMap,
                                                    Map<Integer, List<AttendanceRecord>> sectionAttendanceMap) throws IOException {
        try (XSSFWorkbook workbook = new XSSFWorkbook()) {
            StylePalette styles = new StylePalette(workbook);

            Sheet overviewSheet = workbook.createSheet("Teaching Overview");
            buildOverviewSheet(overviewSheet, styles, professor, school, sectionStudentsMap, sectionAttendanceMap);

            int sectionIndex = 1;
            for (Map.Entry<ClassSection, List<User>> entry : sectionStudentsMap.entrySet()) {
                ClassSection section = entry.getKey();
                List<User> students = entry.getValue();
                List<AttendanceRecord> records = sectionAttendanceMap.getOrDefault(section.getId(), Collections.emptyList());

                String rawName = (section.getCourseCode() != null ? section.getCourseCode() : "Class " + sectionIndex) + " (Sec " + section.getId() + ")";
                String sheetName = sanitizeSheetName(rawName);
                Sheet sheet = workbook.createSheet(sheetName);

                buildSectionSheet(sheet, styles, section, professor, school, students, records);
                sectionIndex++;
            }

            try (ByteArrayOutputStream out = new ByteArrayOutputStream()) {
                workbook.write(out);
                return out.toByteArray();
            }
        }
    }

    private static void buildSectionSheet(Sheet sheet, StylePalette styles, ClassSection section,
                                         User professor, School school, List<User> students,
                                         List<AttendanceRecord> records) {

        sheet.setDisplayGridlines(true);
        sheet.setPrintGridlines(true);
        sheet.setFitToPage(true);
        PrintSetup ps = sheet.getPrintSetup();
        ps.setLandscape(true);
        ps.setPaperSize(PrintSetup.A4_PAPERSIZE);
        ps.setFitWidth((short) 1);
        ps.setFitHeight((short) 0);

        List<AttendanceRecord> sortedRecords = new ArrayList<>(records != null ? records : Collections.emptyList());
        sortedRecords.sort(Comparator.comparing(AttendanceRecord::getSessionDate, Comparator.nullsLast(Comparator.naturalOrder())));

        Map<Date, Map<Integer, String>> dateStudentStatusMap = new LinkedHashMap<>();
        for (AttendanceRecord rec : sortedRecords) {
            Map<Integer, String> statusMap = new HashMap<>();
            if (rec.getEntries() != null) {
                for (AttendanceEntry e : rec.getEntries()) {
                    statusMap.put(e.getStudentId(), e.getStatus());
                }
            }
            dateStudentStatusMap.put(rec.getSessionDate(), statusMap);
        }

        int totalSessions = sortedRecords.size();
        int totalStudents = (students != null) ? students.size() : 0;
        int lastColIndex = Math.max(9, 3 + totalSessions + 6);

        int rowIdx = 0;

        sheet.createRow(rowIdx++).setHeightInPoints(8);

        Row titleRow = sheet.createRow(rowIdx++);
        titleRow.setHeightInPoints(32);
        Cell titleCell = titleRow.createCell(0);
        titleCell.setCellValue("UniTRS — UNIVERSITY MANAGEMENT SYSTEM");
        titleCell.setCellStyle(styles.mainTitleStyle);
        sheet.addMergedRegion(new CellRangeAddress(1, 1, 0, lastColIndex));

        Row subTitleRow = sheet.createRow(rowIdx++);
        subTitleRow.setHeightInPoints(22);
        Cell subTitleCell = subTitleRow.createCell(0);
        subTitleCell.setCellValue("OFFICIAL COURSE ATTENDANCE REGISTER & ROSTER REPORT");
        subTitleCell.setCellStyle(styles.subTitleStyle);
        sheet.addMergedRegion(new CellRangeAddress(2, 2, 0, lastColIndex));

        sheet.createRow(rowIdx++).setHeightInPoints(8);

        String courseCode = section.getCourseCode() != null ? section.getCourseCode() : "N/A";
        String courseTitle = section.getCourseTitle() != null ? section.getCourseTitle() : "Untitled Course";
        String termName = section.getTermName() != null ? section.getTermName() : "Current Term";
        String academicYear = section.getAcademicYear() != null ? section.getAcademicYear() : "";
        String shift = section.getSessionShift() != null ? section.getSessionShift().name() : "STANDARD";
        String days = section.getDaysOfWeek() != null ? section.getDaysOfWeek() : "Scheduled Days";
        String room = section.getRoomName() != null ? section.getRoomName() : "TBA";
        String profName = professor != null && professor.getFullName() != null ? professor.getFullName() : (section.getProfessorName() != null ? section.getProfessorName() : "Faculty Instructor");
        String profId = professor != null && professor.getUserIdentifier() != null ? professor.getFormattedIdentifier() : "N/A";
        String schoolName = school != null && school.getSchoolName() != null ? school.getSchoolName() : "Academic Department";
        String generatedAt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());

        createMetaRow(sheet, rowIdx++, "Course:", courseCode + " — " + courseTitle, "Instructor:", profName + " (" + profId + ")", styles);
        createMetaRow(sheet, rowIdx++, "Academic Term:", termName + (academicYear.isEmpty() ? "" : " (" + academicYear + ")"), "Department:", schoolName, styles);
        createMetaRow(sheet, rowIdx++, "Class Schedule:", shift + " • " + days + " (Room " + room + ")", "Enrolled Students:", totalStudents + " Students", styles);
        createMetaRow(sheet, rowIdx++, "Class Section ID:", "Section #" + section.getId(), "Report Generated:", generatedAt, styles);

        sheet.createRow(rowIdx++).setHeightInPoints(8);

        int grandTotalPresent = 0;
        int grandTotalAbsent = 0;
        int grandTotalLate = 0;
        int grandTotalExcused = 0;
        for (AttendanceRecord rec : sortedRecords) {
            grandTotalPresent += rec.getPresentCount();
            grandTotalAbsent += rec.getAbsentCount();
            grandTotalLate += rec.getLateCount();
            grandTotalExcused += rec.getExcusedCount();
        }
        int totalMarks = grandTotalPresent + grandTotalAbsent + grandTotalLate + grandTotalExcused;
        double overallAttRate = totalMarks > 0 ? ((grandTotalPresent + grandTotalLate) * 100.0 / totalMarks) : 100.0;

        Row kpiRow = sheet.createRow(rowIdx++);
        kpiRow.setHeightInPoints(24);
        createKpiCell(kpiRow, 0, 2, "Sessions Recorded: " + totalSessions, styles.kpiCardStyle, sheet);
        createKpiCell(kpiRow, 3, 5, "Attendance Marks: " + grandTotalPresent + " P / " + grandTotalLate + " L / " + grandTotalAbsent + " A", styles.kpiCardStyle, sheet);
        createKpiCell(kpiRow, 6, 8, String.format("Overall Attendance: %.1f%%", overallAttRate), styles.kpiCardStyle, sheet);
        createKpiCell(kpiRow, 9, lastColIndex, "Status: " + (totalSessions > 0 ? "Active Semester Log" : "Blank Register Ready for Class"), styles.kpiCardStyle, sheet);

        sheet.createRow(rowIdx++).setHeightInPoints(10);

        int headerRowIdx = rowIdx++;
        Row tableHeader = sheet.createRow(headerRowIdx);
        tableHeader.setHeightInPoints(26);

        int col = 0;
        createStyledCell(tableHeader, col++, "#", styles.thStyle);
        createStyledCell(tableHeader, col++, "Student ID", styles.thStyle);
        createStyledCell(tableHeader, col++, "Student Full Name", styles.thStyle);
        createStyledCell(tableHeader, col++, "Academic Major", styles.thStyle);

        SimpleDateFormat df = new SimpleDateFormat("MM/dd");
        for (AttendanceRecord rec : sortedRecords) {
            String dateLabel = rec.getSessionDate() != null ? df.format(rec.getSessionDate()) : "Date";
            createStyledCell(tableHeader, col++, dateLabel, styles.thDateStyle);
        }

        int extraBlankCols = (totalSessions == 0) ? 10 : Math.max(0, 3 - totalSessions);
        for (int b = 1; b <= extraBlankCols; b++) {
            createStyledCell(tableHeader, col++, "S" + (totalSessions + b), styles.thDateStyle);
        }

        int colPresent = col++;
        int colLate = col++;
        int colAbsent = col++;
        int colExcused = col++;
        int colRate = col++;
        int colStatus = col++;

        createStyledCell(tableHeader, colPresent, "Present (P)", styles.thGreenStyle);
        createStyledCell(tableHeader, colLate, "Late (L)", styles.thAmberStyle);
        createStyledCell(tableHeader, colAbsent, "Absent (A)", styles.thRedStyle);
        createStyledCell(tableHeader, colExcused, "Excused (E)", styles.thBlueStyle);
        createStyledCell(tableHeader, colRate, "Attended %", styles.thAccentStyle);
        createStyledCell(tableHeader, colStatus, "Exam Eligibility", styles.thStyle);

        int studentNum = 1;
        int dataStartRow = rowIdx;

        List<User> sortedStudents = new ArrayList<>(students != null ? students : Collections.emptyList());
        sortedStudents.sort(Comparator.comparing(u -> u.getFullName() != null ? u.getFullName() : ""));

        for (User student : sortedStudents) {
            Row row = sheet.createRow(rowIdx++);
            row.setHeightInPoints(20);
            boolean isZebra = (studentNum % 2 == 0);
            CellStyle baseStyle = isZebra ? styles.zebraDataStyle : styles.dataStyle;
            CellStyle baseCenterStyle = isZebra ? styles.zebraCenterStyle : styles.centerStyle;

            int c = 0;
            createStyledCell(row, c++, String.valueOf(studentNum++), baseCenterStyle);
            createStyledCell(row, c++, student.getFormattedIdentifier() != null ? student.getFormattedIdentifier() : "N/A", baseCenterStyle);
            createStyledCell(row, c++, student.getFullName() != null ? student.getFullName() : "Unknown", baseStyle);
            createStyledCell(row, c++, student.getMajor() != null ? student.getMajor() : "General", baseStyle);

            int stuPresent = 0;
            int stuLate = 0;
            int stuAbsent = 0;
            int stuExcused = 0;

            for (AttendanceRecord rec : sortedRecords) {
                Map<Integer, String> statusMap = dateStudentStatusMap.get(rec.getSessionDate());
                String status = (statusMap != null) ? statusMap.get(student.getId()) : null;

                if ("PRESENT".equalsIgnoreCase(status)) {
                    createStyledCell(row, c++, "P", styles.presentStyle);
                    stuPresent++;
                } else if ("LATE".equalsIgnoreCase(status)) {
                    createStyledCell(row, c++, "L", styles.lateStyle);
                    stuLate++;
                } else if ("ABSENT".equalsIgnoreCase(status)) {
                    createStyledCell(row, c++, "A", styles.absentStyle);
                    stuAbsent++;
                } else if ("EXCUSED".equalsIgnoreCase(status)) {
                    createStyledCell(row, c++, "E", styles.excusedStyle);
                    stuExcused++;
                } else {
                    createStyledCell(row, c++, "—", styles.unmarkedStyle);
                }
            }

            for (int b = 1; b <= extraBlankCols; b++) {
                createStyledCell(row, c++, "", baseCenterStyle);
            }

            createStyledCell(row, colPresent, String.valueOf(stuPresent), baseCenterStyle);
            createStyledCell(row, colLate, String.valueOf(stuLate), baseCenterStyle);
            createStyledCell(row, colAbsent, String.valueOf(stuAbsent), baseCenterStyle);
            createStyledCell(row, colExcused, String.valueOf(stuExcused), baseCenterStyle);

            double stuRate = (totalSessions > 0) ? ((stuPresent + stuLate) * 100.0 / totalSessions) : 100.0;
            String rateStr = (totalSessions > 0) ? String.format("%.1f%%", stuRate) : "100.0%";
            createStyledCell(row, colRate, rateStr, baseCenterStyle);

            String eligibilityText;
            CellStyle elStyle;
            if (totalSessions == 0 || stuRate >= 80.0) {
                eligibilityText = "Eligible";
                elStyle = styles.eligibleStyle;
            } else if (stuRate >= 70.0) {
                eligibilityText = "At Risk (<80%)";
                elStyle = styles.atRiskStyle;
            } else {
                eligibilityText = "Barred (<70%)";
                elStyle = styles.barredStyle;
            }
            createStyledCell(row, colStatus, eligibilityText, elStyle);
        }

        if (sortedStudents.isEmpty()) {
            Row row = sheet.createRow(rowIdx++);
            row.setHeightInPoints(24);
            Cell emptyCell = row.createCell(0);
            emptyCell.setCellValue("No students are currently registered in this class section.");
            emptyCell.setCellStyle(styles.centerStyle);
            sheet.addMergedRegion(new CellRangeAddress(rowIdx - 1, rowIdx - 1, 0, lastColIndex));
        }

        Row totalRow = sheet.createRow(rowIdx++);
        totalRow.setHeightInPoints(22);
        createStyledCell(totalRow, 0, "", styles.totalRowStyle);
        createStyledCell(totalRow, 1, "", styles.totalRowStyle);
        createStyledCell(totalRow, 2, "SESSION ATTENDEES (PRESENT / TOTAL)", styles.totalRowBoldStyle);
        createStyledCell(totalRow, 3, "", styles.totalRowStyle);

        int c = 4;
        for (AttendanceRecord rec : sortedRecords) {
            int pCount = rec.getPresentCount() + rec.getLateCount();
            int tCount = totalStudents;
            String sessionStat = (tCount > 0) ? (pCount + "/" + tCount) : String.valueOf(pCount);
            createStyledCell(totalRow, c++, sessionStat, styles.totalRowCenterStyle);
        }
        for (int b = 1; b <= extraBlankCols; b++) {
            createStyledCell(totalRow, c++, "", styles.totalRowCenterStyle);
        }
        createStyledCell(totalRow, colPresent, String.valueOf(grandTotalPresent), styles.totalRowCenterStyle);
        createStyledCell(totalRow, colLate, String.valueOf(grandTotalLate), styles.totalRowCenterStyle);
        createStyledCell(totalRow, colAbsent, String.valueOf(grandTotalAbsent), styles.totalRowCenterStyle);
        createStyledCell(totalRow, colExcused, String.valueOf(grandTotalExcused), styles.totalRowCenterStyle);
        createStyledCell(totalRow, colRate, String.format("%.1f%%", overallAttRate), styles.totalRowCenterStyle);
        createStyledCell(totalRow, colStatus, "", styles.totalRowStyle);

        sheet.createRow(rowIdx++).setHeightInPoints(12);

        Row legendRow = sheet.createRow(rowIdx++);
        legendRow.setHeightInPoints(18);
        Cell legendCell = legendRow.createCell(0);
        legendCell.setCellValue("ATTENDANCE LEGEND:   [P] Present (Full Credit)     [L] Late (Partial Credit)     [E] Excused Absence     [A] Unexcused Absent (0 Credit)     [—] Unrecorded");
        legendCell.setCellStyle(styles.legendStyle);
        sheet.addMergedRegion(new CellRangeAddress(rowIdx - 1, rowIdx - 1, 0, lastColIndex));

        Row ruleRow = sheet.createRow(rowIdx++);
        ruleRow.setHeightInPoints(18);
        Cell ruleCell = ruleRow.createCell(0);
        ruleCell.setCellValue("ACADEMIC POLICY: Students with attendance below 80% are flagged as At Risk. Students below 70% attendance are barred from taking the final examination.");
        ruleCell.setCellStyle(styles.legendStyle);
        sheet.addMergedRegion(new CellRangeAddress(rowIdx - 1, rowIdx - 1, 0, lastColIndex));

        sheet.createRow(rowIdx++).setHeightInPoints(14);

        Row signRow1 = sheet.createRow(rowIdx++);
        signRow1.setHeightInPoints(24);
        createStyledCell(signRow1, 1, "Course Instructor Signature: ________________________________________", styles.signStyle);
        createStyledCell(signRow1, 5, "Dean / Dept Chair Approval: ________________________________________", styles.signStyle);

        Row signRow2 = sheet.createRow(rowIdx++);
        signRow2.setHeightInPoints(20);
        createStyledCell(signRow2, 1, "Date Verified: ________________________", styles.signSubStyle);
        createStyledCell(signRow2, 5, "Date Approved: ________________________", styles.signSubStyle);

        sheet.setColumnWidth(0, 6 * 256);
        sheet.setColumnWidth(1, 16 * 256);
        sheet.setColumnWidth(2, 28 * 256);
        sheet.setColumnWidth(3, 22 * 256);

        for (int i = 4; i < colPresent; i++) {
            sheet.setColumnWidth(i, 11 * 256);
        }
        sheet.setColumnWidth(colPresent, 12 * 256);
        sheet.setColumnWidth(colLate, 10 * 256);
        sheet.setColumnWidth(colAbsent, 12 * 256);
        sheet.setColumnWidth(colExcused, 12 * 256);
        sheet.setColumnWidth(colRate, 14 * 256);
        sheet.setColumnWidth(colStatus, 18 * 256);

        sheet.createFreezePane(3, headerRowIdx + 1);
    }

    private static void buildOverviewSheet(Sheet sheet, StylePalette styles, User professor, School school,
                                          Map<ClassSection, List<User>> sectionStudentsMap,
                                          Map<Integer, List<AttendanceRecord>> sectionAttendanceMap) {
        sheet.setDisplayGridlines(true);
        sheet.setPrintGridlines(true);

        int rowIdx = 0;
        sheet.createRow(rowIdx++).setHeightInPoints(8);

        Row titleRow = sheet.createRow(rowIdx++);
        titleRow.setHeightInPoints(32);
        Cell titleCell = titleRow.createCell(0);
        titleCell.setCellValue("UniTRS — FACULTY TEACHING LOAD & ATTENDANCE SUMMARY");
        titleCell.setCellStyle(styles.mainTitleStyle);
        sheet.addMergedRegion(new CellRangeAddress(1, 1, 0, 7));

        Row subTitleRow = sheet.createRow(rowIdx++);
        subTitleRow.setHeightInPoints(22);
        Cell subTitleCell = subTitleRow.createCell(0);
        subTitleCell.setCellValue("SEMESTER ATTENDANCE AUDIT & SECTION PORTFOLIO");
        subTitleCell.setCellStyle(styles.subTitleStyle);
        sheet.addMergedRegion(new CellRangeAddress(2, 2, 0, 7));

        sheet.createRow(rowIdx++).setHeightInPoints(8);

        String profName = professor != null && professor.getFullName() != null ? professor.getFullName() : "Faculty Member";
        String profId = professor != null && professor.getUserIdentifier() != null ? professor.getFormattedIdentifier() : "N/A";
        String schoolName = school != null && school.getSchoolName() != null ? school.getSchoolName() : "Academic Department";
        String generatedAt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());

        createMetaRow(sheet, rowIdx++, "Faculty Member:", profName + " (" + profId + ")", "Department:", schoolName, styles);
        createMetaRow(sheet, rowIdx++, "Assigned Sections:", sectionStudentsMap.size() + " Classes", "Report Generated:", generatedAt, styles);

        sheet.createRow(rowIdx++).setHeightInPoints(12);

        Row tableHeader = sheet.createRow(rowIdx++);
        tableHeader.setHeightInPoints(26);
        createStyledCell(tableHeader, 0, "Sec #", styles.thStyle);
        createStyledCell(tableHeader, 1, "Course Code", styles.thStyle);
        createStyledCell(tableHeader, 2, "Course Title", styles.thStyle);
        createStyledCell(tableHeader, 3, "Schedule & Room", styles.thStyle);
        createStyledCell(tableHeader, 4, "Enrolled", styles.thStyle);
        createStyledCell(tableHeader, 5, "Sessions Held", styles.thDateStyle);
        createStyledCell(tableHeader, 6, "Total Marks (P/L/A/E)", styles.thStyle);
        createStyledCell(tableHeader, 7, "Attendance Rate", styles.thAccentStyle);

        int totalStudentsAll = 0;
        int totalSessionsAll = 0;
        int totalMarksAll = 0;
        int totalPresentAll = 0;

        int num = 1;
        for (Map.Entry<ClassSection, List<User>> entry : sectionStudentsMap.entrySet()) {
            ClassSection sec = entry.getKey();
            List<User> students = entry.getValue();
            List<AttendanceRecord> records = sectionAttendanceMap.getOrDefault(sec.getId(), Collections.emptyList());

            int secStudents = students != null ? students.size() : 0;
            int secSessions = records.size();

            int secP = 0, secL = 0, secA = 0, secE = 0;
            for (AttendanceRecord r : records) {
                secP += r.getPresentCount();
                secL += r.getLateCount();
                secA += r.getAbsentCount();
                secE += r.getExcusedCount();
            }
            int secTotalMarks = secP + secL + secA + secE;
            double secRate = secTotalMarks > 0 ? ((secP + secL) * 100.0 / secTotalMarks) : 100.0;

            totalStudentsAll += secStudents;
            totalSessionsAll += secSessions;
            totalMarksAll += secTotalMarks;
            totalPresentAll += (secP + secL);

            Row r = sheet.createRow(rowIdx++);
            r.setHeightInPoints(22);
            boolean isZebra = (num++ % 2 == 0);
            CellStyle bStyle = isZebra ? styles.zebraDataStyle : styles.dataStyle;
            CellStyle bCenter = isZebra ? styles.zebraCenterStyle : styles.centerStyle;

            createStyledCell(r, 0, "#" + sec.getId(), bCenter);
            createStyledCell(r, 1, sec.getCourseCode() != null ? sec.getCourseCode() : "", bCenter);
            createStyledCell(r, 2, sec.getCourseTitle() != null ? sec.getCourseTitle() : "", bStyle);
            createStyledCell(r, 3, (sec.getSessionShift() != null ? sec.getSessionShift().name() : "") + " • " + (sec.getRoomName() != null ? sec.getRoomName() : ""), bStyle);
            createStyledCell(r, 4, secStudents + " Students", bCenter);
            createStyledCell(r, 5, secSessions + " Dates", bCenter);
            createStyledCell(r, 6, secP + "P / " + secL + "L / " + secA + "A / " + secE + "E", bCenter);
            createStyledCell(r, 7, secTotalMarks > 0 ? String.format("%.1f%%", secRate) : "100.0%", bCenter);
        }

        Row totRow = sheet.createRow(rowIdx++);
        totRow.setHeightInPoints(24);
        createStyledCell(totRow, 0, "TOTAL", styles.totalRowCenterStyle);
        createStyledCell(totRow, 1, sectionStudentsMap.size() + " Classes", styles.totalRowCenterStyle);
        createStyledCell(totRow, 2, "", styles.totalRowStyle);
        createStyledCell(totRow, 3, "", styles.totalRowStyle);
        createStyledCell(totRow, 4, totalStudentsAll + " Total Students", styles.totalRowCenterStyle);
        createStyledCell(totRow, 5, totalSessionsAll + " Total Sessions", styles.totalRowCenterStyle);
        createStyledCell(totRow, 6, totalMarksAll + " Total Records", styles.totalRowCenterStyle);
        double overallAvg = totalMarksAll > 0 ? (totalPresentAll * 100.0 / totalMarksAll) : 100.0;
        createStyledCell(totRow, 7, String.format("%.1f%% Avg", overallAvg), styles.totalRowCenterStyle);

        sheet.setColumnWidth(0, 10 * 256);
        sheet.setColumnWidth(1, 16 * 256);
        sheet.setColumnWidth(2, 34 * 256);
        sheet.setColumnWidth(3, 26 * 256);
        sheet.setColumnWidth(4, 16 * 256);
        sheet.setColumnWidth(5, 16 * 256);
        sheet.setColumnWidth(6, 26 * 256);
        sheet.setColumnWidth(7, 18 * 256);
    }

    private static void createMetaRow(Sheet sheet, int rowIdx, String label1, String val1, String label2, String val2, StylePalette styles) {
        Row row = sheet.createRow(rowIdx);
        row.setHeightInPoints(18);

        Cell l1 = row.createCell(0);
        l1.setCellValue(label1);
        l1.setCellStyle(styles.metaLabelStyle);

        Cell v1 = row.createCell(1);
        v1.setCellValue(val1);
        v1.setCellStyle(styles.metaValueStyle);
        sheet.addMergedRegion(new CellRangeAddress(rowIdx, rowIdx, 1, 3));

        Cell l2 = row.createCell(4);
        l2.setCellValue(label2);
        l2.setCellStyle(styles.metaLabelStyle);

        Cell v2 = row.createCell(5);
        v2.setCellValue(val2);
        v2.setCellStyle(styles.metaValueStyle);
        sheet.addMergedRegion(new CellRangeAddress(rowIdx, rowIdx, 5, 8));
    }

    private static void createKpiCell(Row row, int startCol, int endCol, String text, CellStyle style, Sheet sheet) {
        for (int c = startCol; c <= endCol; c++) {
            Cell cell = row.createCell(c);
            cell.setCellStyle(style);
            if (c == startCol) {
                cell.setCellValue(text);
            }
        }
        if (startCol < endCol) {
            sheet.addMergedRegion(new CellRangeAddress(row.getRowNum(), row.getRowNum(), startCol, endCol));
        }
    }

    private static void createStyledCell(Row row, int col, String value, CellStyle style) {
        Cell cell = row.createCell(col);
        cell.setCellValue(value != null ? value : "");
        cell.setCellStyle(style);
    }

    private static String sanitizeSheetName(String name) {
        if (name == null || name.trim().isEmpty()) {
            return "Sheet";
        }
        String clean = name.replaceAll("[\\\\/*?:\\[\\]]", " ").trim();
        return clean.length() > 30 ? clean.substring(0, 30) : clean;
    }

    private static class StylePalette {
        final CellStyle mainTitleStyle;
        final CellStyle subTitleStyle;
        final CellStyle metaLabelStyle;
        final CellStyle metaValueStyle;
        final CellStyle kpiCardStyle;

        final CellStyle thStyle;
        final CellStyle thDateStyle;
        final CellStyle thGreenStyle;
        final CellStyle thAmberStyle;
        final CellStyle thRedStyle;
        final CellStyle thBlueStyle;
        final CellStyle thAccentStyle;

        final CellStyle dataStyle;
        final CellStyle centerStyle;
        final CellStyle zebraDataStyle;
        final CellStyle zebraCenterStyle;

        final CellStyle presentStyle;
        final CellStyle absentStyle;
        final CellStyle lateStyle;
        final CellStyle excusedStyle;
        final CellStyle unmarkedStyle;

        final CellStyle eligibleStyle;
        final CellStyle atRiskStyle;
        final CellStyle barredStyle;

        final CellStyle totalRowStyle;
        final CellStyle totalRowBoldStyle;
        final CellStyle totalRowCenterStyle;
        final CellStyle legendStyle;
        final CellStyle signStyle;
        final CellStyle signSubStyle;

        StylePalette(XSSFWorkbook wb) {

            XSSFFont titleFont = wb.createFont();
            titleFont.setFontName("Segoe UI");
            titleFont.setFontHeightInPoints((short) 14);
            titleFont.setBold(true);
            titleFont.setColor(IndexedColors.WHITE.getIndex());

            XSSFFont subTitleFont = wb.createFont();
            subTitleFont.setFontName("Segoe UI");
            subTitleFont.setFontHeightInPoints((short) 11);
            subTitleFont.setBold(true);
            subTitleFont.setColor(IndexedColors.WHITE.getIndex());

            XSSFFont thFont = wb.createFont();
            thFont.setFontName("Segoe UI");
            thFont.setFontHeightInPoints((short) 10);
            thFont.setBold(true);
            thFont.setColor(IndexedColors.WHITE.getIndex());

            XSSFFont regularFont = wb.createFont();
            regularFont.setFontName("Segoe UI");
            regularFont.setFontHeightInPoints((short) 9);

            XSSFFont boldFont = wb.createFont();
            boldFont.setFontName("Segoe UI");
            boldFont.setFontHeightInPoints((short) 9);
            boldFont.setBold(true);

            XSSFFont italicFont = wb.createFont();
            italicFont.setFontName("Segoe UI");
            italicFont.setFontHeightInPoints((short) 8);
            italicFont.setItalic(true);
            italicFont.setColor(IndexedColors.GREY_50_PERCENT.getIndex());

            mainTitleStyle = wb.createCellStyle();
            mainTitleStyle.setFont(titleFont);
            mainTitleStyle.setAlignment(HorizontalAlignment.CENTER);
            mainTitleStyle.setVerticalAlignment(VerticalAlignment.CENTER);
            ((XSSFCellStyle) mainTitleStyle).setFillForegroundColor(new XSSFColor(COLOR_NAVY, null));
            mainTitleStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);

            subTitleStyle = wb.createCellStyle();
            subTitleStyle.setFont(subTitleFont);
            subTitleStyle.setAlignment(HorizontalAlignment.CENTER);
            subTitleStyle.setVerticalAlignment(VerticalAlignment.CENTER);
            ((XSSFCellStyle) subTitleStyle).setFillForegroundColor(new XSSFColor(COLOR_ROYAL, null));
            subTitleStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);

            metaLabelStyle = wb.createCellStyle();
            metaLabelStyle.setFont(boldFont);
            metaLabelStyle.setAlignment(HorizontalAlignment.RIGHT);
            metaLabelStyle.setVerticalAlignment(VerticalAlignment.CENTER);

            metaValueStyle = wb.createCellStyle();
            metaValueStyle.setFont(regularFont);
            metaValueStyle.setAlignment(HorizontalAlignment.LEFT);
            metaValueStyle.setVerticalAlignment(VerticalAlignment.CENTER);

            kpiCardStyle = wb.createCellStyle();
            kpiCardStyle.setFont(boldFont);
            kpiCardStyle.setAlignment(HorizontalAlignment.CENTER);
            kpiCardStyle.setVerticalAlignment(VerticalAlignment.CENTER);
            ((XSSFCellStyle) kpiCardStyle).setFillForegroundColor(new XSSFColor(COLOR_CARD_BG, null));
            kpiCardStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            setBorders(kpiCardStyle, BorderStyle.THIN, new XSSFColor(COLOR_BORDER, null));

            thStyle = createHeaderStyle(wb, thFont, COLOR_HEADER_BG);
            thDateStyle = createHeaderStyle(wb, thFont, COLOR_ROYAL);
            thGreenStyle = createHeaderStyle(wb, thFont, new byte[]{(byte) 21, (byte) 128, (byte) 61});
            thAmberStyle = createHeaderStyle(wb, thFont, new byte[]{(byte) 180, (byte) 83, (byte) 9});
            thRedStyle = createHeaderStyle(wb, thFont, new byte[]{(byte) 185, (byte) 28, (byte) 28});
            thBlueStyle = createHeaderStyle(wb, thFont, new byte[]{(byte) 3, (byte) 105, (byte) 161});
            thAccentStyle = createHeaderStyle(wb, thFont, new byte[]{(byte) 79, (byte) 70, (byte) 229});

            dataStyle = createDataStyle(wb, regularFont, HorizontalAlignment.LEFT, false);
            centerStyle = createDataStyle(wb, regularFont, HorizontalAlignment.CENTER, false);
            zebraDataStyle = createDataStyle(wb, regularFont, HorizontalAlignment.LEFT, true);
            zebraCenterStyle = createDataStyle(wb, regularFont, HorizontalAlignment.CENTER, true);

            presentStyle = createStatusStyle(wb, BG_PRESENT, FG_PRESENT);
            absentStyle = createStatusStyle(wb, BG_ABSENT, FG_ABSENT);
            lateStyle = createStatusStyle(wb, BG_LATE, FG_LATE);
            excusedStyle = createStatusStyle(wb, BG_EXCUSED, FG_EXCUSED);
            unmarkedStyle = createStatusStyle(wb, BG_UNMARKED, FG_UNMARKED);

            eligibleStyle = createStatusStyle(wb, BG_PRESENT, FG_PRESENT);
            atRiskStyle = createStatusStyle(wb, BG_LATE, FG_LATE);
            barredStyle = createStatusStyle(wb, BG_ABSENT, FG_ABSENT);

            totalRowStyle = wb.createCellStyle();
            totalRowStyle.setFont(regularFont);
            ((XSSFCellStyle) totalRowStyle).setFillForegroundColor(new XSSFColor(COLOR_CARD_BG, null));
            totalRowStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            totalRowStyle.setBorderTop(BorderStyle.MEDIUM);
            totalRowStyle.setBorderBottom(BorderStyle.DOUBLE);

            totalRowBoldStyle = wb.createCellStyle();
            totalRowBoldStyle.setFont(boldFont);
            ((XSSFCellStyle) totalRowBoldStyle).setFillForegroundColor(new XSSFColor(COLOR_CARD_BG, null));
            totalRowBoldStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            totalRowBoldStyle.setBorderTop(BorderStyle.MEDIUM);
            totalRowBoldStyle.setBorderBottom(BorderStyle.DOUBLE);

            totalRowCenterStyle = wb.createCellStyle();
            totalRowCenterStyle.setFont(boldFont);
            totalRowCenterStyle.setAlignment(HorizontalAlignment.CENTER);
            ((XSSFCellStyle) totalRowCenterStyle).setFillForegroundColor(new XSSFColor(COLOR_CARD_BG, null));
            totalRowCenterStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            totalRowCenterStyle.setBorderTop(BorderStyle.MEDIUM);
            totalRowCenterStyle.setBorderBottom(BorderStyle.DOUBLE);

            legendStyle = wb.createCellStyle();
            legendStyle.setFont(italicFont);
            legendStyle.setVerticalAlignment(VerticalAlignment.CENTER);

            signStyle = wb.createCellStyle();
            signStyle.setFont(boldFont);
            signStyle.setVerticalAlignment(VerticalAlignment.BOTTOM);

            signSubStyle = wb.createCellStyle();
            signSubStyle.setFont(regularFont);
            signSubStyle.setVerticalAlignment(VerticalAlignment.TOP);
        }

        private CellStyle createHeaderStyle(XSSFWorkbook wb, XSSFFont font, byte[] bgRgb) {
            CellStyle s = wb.createCellStyle();
            s.setFont(font);
            s.setAlignment(HorizontalAlignment.CENTER);
            s.setVerticalAlignment(VerticalAlignment.CENTER);
            ((XSSFCellStyle) s).setFillForegroundColor(new XSSFColor(bgRgb, null));
            s.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            setBorders(s, BorderStyle.THIN, new XSSFColor(COLOR_BORDER, null));
            return s;
        }

        private CellStyle createDataStyle(XSSFWorkbook wb, XSSFFont font, HorizontalAlignment align, boolean isZebra) {
            CellStyle s = wb.createCellStyle();
            s.setFont(font);
            s.setAlignment(align);
            s.setVerticalAlignment(VerticalAlignment.CENTER);
            if (isZebra) {
                ((XSSFCellStyle) s).setFillForegroundColor(new XSSFColor(COLOR_ZEBRA, null));
                s.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            }
            setBorders(s, BorderStyle.THIN, new XSSFColor(COLOR_BORDER, null));
            return s;
        }

        private CellStyle createStatusStyle(XSSFWorkbook wb, byte[] bgRgb, byte[] fgRgb) {
            XSSFFont f = wb.createFont();
            f.setFontName("Segoe UI");
            f.setFontHeightInPoints((short) 9);
            f.setBold(true);
            ((org.apache.poi.xssf.usermodel.XSSFFont) f).setColor(new XSSFColor(fgRgb, null));

            CellStyle s = wb.createCellStyle();
            s.setFont(f);
            s.setAlignment(HorizontalAlignment.CENTER);
            s.setVerticalAlignment(VerticalAlignment.CENTER);
            ((XSSFCellStyle) s).setFillForegroundColor(new XSSFColor(bgRgb, null));
            s.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            setBorders(s, BorderStyle.THIN, new XSSFColor(COLOR_BORDER, null));
            return s;
        }

        private void setBorders(CellStyle s, BorderStyle border, XSSFColor borderColor) {
            s.setBorderTop(border);
            s.setBorderBottom(border);
            s.setBorderLeft(border);
            s.setBorderRight(border);
            ((XSSFCellStyle) s).setTopBorderColor(borderColor);
            ((XSSFCellStyle) s).setBottomBorderColor(borderColor);
            ((XSSFCellStyle) s).setLeftBorderColor(borderColor);
            ((XSSFCellStyle) s).setRightBorderColor(borderColor);
        }
    }
}
