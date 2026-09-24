package com.unitrs.utils;

import com.unitrs.model.entity.AttendanceEntry;
import com.unitrs.model.entity.AttendanceRecord;
import com.unitrs.model.entity.ClassSection;
import com.unitrs.model.entity.School;
import com.unitrs.model.entity.User;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.*;

public class AttendanceExcelExporter {

    private static final String FONT_KHMER = "Khmer OS Muol Light";
    private static final String FONT_TIMES = "Times New Roman";

    public static byte[] exportSectionAttendance(ClassSection section, User professor, School school,
                                                 List<User> students, List<AttendanceRecord> records) throws IOException {
        try (XSSFWorkbook workbook = new XSSFWorkbook()) {
            StylePalette styles = new StylePalette(workbook);

            String sheetName = buildSheetName(section, 1);
            Sheet sheet = createUniqueSheet(workbook, sheetName);

            buildOfficialSheet(sheet, styles, section, professor, school, students, records);

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

            Map<ClassSection, List<User>> safeStudentsMap = sectionStudentsMap != null ? sectionStudentsMap : Collections.emptyMap();
            Map<Integer, List<AttendanceRecord>> safeAttendanceMap = sectionAttendanceMap != null ? sectionAttendanceMap : Collections.emptyMap();

            if (safeStudentsMap.isEmpty()) {
                Sheet sheet = createUniqueSheet(workbook, "Attendance");
                buildOfficialSheet(sheet, styles, null, professor, school, Collections.emptyList(), Collections.emptyList());
            } else {
                int sectionIndex = 1;
                for (Map.Entry<ClassSection, List<User>> entry : safeStudentsMap.entrySet()) {
                    ClassSection section = entry.getKey();
                    List<User> students = entry.getValue();
                    List<AttendanceRecord> records = (section != null) ? safeAttendanceMap.getOrDefault(section.getId(), Collections.emptyList()) : Collections.emptyList();

                    String sheetName = buildSheetName(section, sectionIndex);
                    Sheet sheet = createUniqueSheet(workbook, sheetName);

                    buildOfficialSheet(sheet, styles, section, professor, school, students, records);
                    sectionIndex++;
                }
            }

            try (ByteArrayOutputStream out = new ByteArrayOutputStream()) {
                workbook.write(out);
                return out.toByteArray();
            }
        }
    }

    private static String buildSheetName(ClassSection section, int fallbackIndex) {
        if (section == null) {
            return "Class " + fallbackIndex;
        }
        String code = section.getCourseCode();
        if (code == null || code.trim().isEmpty()) {
            code = "Class " + fallbackIndex;
        }
        return code + " - Sec " + section.getId();
    }

    private static Sheet createUniqueSheet(Workbook workbook, String desiredName) {
        String safeName = desiredName.replaceAll("[\\\\/*?\\[\\]:]", " ").trim();
        if (safeName.length() > 31) {
            safeName = safeName.substring(0, 31).trim();
        }
        if (safeName.isEmpty()) {
            safeName = "Attendance";
        }
        String finalName = safeName;
        int counter = 1;
        while (workbook.getSheet(finalName) != null) {
            String suffix = " (" + counter + ")";
            int maxBaseLen = 31 - suffix.length();
            String base = safeName.length() > maxBaseLen ? safeName.substring(0, maxBaseLen).trim() : safeName;
            finalName = base + suffix;
            counter++;
        }
        return workbook.createSheet(finalName);
    }

    private static void buildOfficialSheet(Sheet sheet, StylePalette styles, ClassSection section,
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
            if (rec.getSessionDate() != null) {
                Map<Integer, String> statusMap = new HashMap<>();
                if (rec.getEntries() != null) {
                    for (AttendanceEntry e : rec.getEntries()) {
                        statusMap.put(e.getStudentId(), e.getStatus());
                    }
                }
                dateStudentStatusMap.put(rec.getSessionDate(), statusMap);
            }
        }

        List<SessionColInfo> sessionCols = prepareSessionColumns(sortedRecords);
        int numSessions = sessionCols.size();
        int totalCols = 4 + numSessions + 4;

        sheet.setColumnWidth(0, (int) (5.5 * 256));
        sheet.setColumnWidth(1, (int) (26.5 * 256));
        sheet.setColumnWidth(2, (int) (4.5 * 256));
        sheet.setColumnWidth(3, (int) (13.0 * 256));

        for (int i = 0; i < numSessions; i++) {
            sheet.setColumnWidth(4 + i, (int) (5.2 * 256));
        }

        sheet.setColumnWidth(4 + numSessions, (int) (5.5 * 256));
        sheet.setColumnWidth(4 + numSessions + 1, (int) (5.5 * 256));
        sheet.setColumnWidth(4 + numSessions + 2, (int) (5.5 * 256));
        sheet.setColumnWidth(4 + numSessions + 3, (int) (7.5 * 256));

        Row r0 = sheet.createRow(0);
        r0.setHeight((short) (29.45 * 20));
        createMergedRow(sheet, r0, 0, totalCols - 1, "សាកលវិទ្យាល័យកម្ពុជា", styles.khmerHeader);

        Row r1 = sheet.createRow(1);
        r1.setHeight((short) (18.0 * 20));
        createMergedRow(sheet, r1, 0, totalCols - 1, "The University of Cambodia", styles.engHeader);

        Row r2 = sheet.createRow(2);
        r2.setHeight((short) (15.6 * 20));
        createMergedRow(sheet, r2, 0, totalCols - 1, "", styles.separatorRow);

        String termText = (section != null && section.getTermName() != null && !section.getTermName().trim().isEmpty())
                ? section.getTermName().trim() : "TERM 1";
        String academicYear = (section != null && section.getAcademicYear() != null && !section.getAcademicYear().trim().isEmpty())
                ? section.getAcademicYear().trim() : "2025-2026";
        String termBanner = "Attendance List for " + termText.toUpperCase() + " :  " + academicYear;

        Row r3 = sheet.createRow(3);
        r3.setHeight((short) (18.75 * 20));
        createMergedRow(sheet, r3, 0, totalCols - 1, termBanner, styles.termHeader);

        int labelEndCol = 6;
        int valueStartCol = 7;
        int valueEndCol = totalCols - 1;

        createMetadataRow(sheet, 4, 19.5, "Room:", getRoomDisplay(section), labelEndCol, valueStartCol, valueEndCol, styles);
        createMetadataRow(sheet, 5, 18.0, "Instructor:", getInstructorDisplay(section, professor), labelEndCol, valueStartCol, valueEndCol, styles);
        createMetadataRow(sheet, 6, 17.25, "Course Title:", (section != null && section.getCourseTitle() != null ? section.getCourseTitle() : ""), labelEndCol, valueStartCol, valueEndCol, styles);
        createMetadataRow(sheet, 7, 17.25, "Course Code:", (section != null && section.getCourseCode() != null ? section.getCourseCode() : ""), labelEndCol, valueStartCol, valueEndCol, styles);
        createMetadataRow(sheet, 8, 17.25, "Time:", getTimeDisplay(section), labelEndCol, valueStartCol, valueEndCol, styles);

        buildTableHeaders(sheet, 9, sessionCols, numSessions, totalCols, styles);

        int startDataRow = 12;
        List<User> safeStudents = new ArrayList<>(students != null ? students : Collections.emptyList());
        safeStudents.sort(Comparator.comparing(User::getFullName, Comparator.nullsLast(String.CASE_INSENSITIVE_ORDER)));

        int maleCount = 0;
        int femaleCount = 0;

        for (int i = 0; i < safeStudents.size(); i++) {
            User s = safeStudents.get(i);
            String sex = getStudentSex(s);
            if ("F".equals(sex)) femaleCount++;
            else maleCount++;

            Row row = sheet.createRow(startDataRow + i);
            row.setHeight((short) (26.25 * 20));

            createCell(row, 0, String.valueOf(i + 1), styles.tdCenter);
            createCell(row, 1, " " + (s.getFullName() != null ? s.getFullName() : ""), styles.tdLeft);
            createCell(row, 2, sex, styles.tdCenter);
            createCell(row, 3, s.getFormattedIdentifier() != null ? s.getFormattedIdentifier() : "", styles.tdCenter);

            int pCount = 0;
            int aCount = 0;
            int lCount = 0;
            for (int colIdx = 0; colIdx < numSessions; colIdx++) {
                SessionColInfo colInfo = sessionCols.get(colIdx);
                String mark = "";
                if (colInfo.date != null) {
                    Map<Integer, String> sMap = dateStudentStatusMap.get(colInfo.date);
                    if (sMap != null) {
                        String st = sMap.get(s.getId());
                        if ("PRESENT".equalsIgnoreCase(st)) {
                            mark = "P";
                            pCount++;
                        } else if ("ABSENT".equalsIgnoreCase(st)) {
                            mark = "A";
                            aCount++;
                        } else if ("LATE".equalsIgnoreCase(st)) {
                            mark = "L";
                            lCount++;
                        } else if ("EXCUSED".equalsIgnoreCase(st)) {
                            mark = "E";
                            pCount++;
                        }
                    }
                }
                createCell(row, 4 + colIdx, mark, styles.tdCenter);
            }

            createCell(row, 4 + numSessions, String.valueOf(pCount), styles.tdSummary);
            createCell(row, 4 + numSessions + 1, String.valueOf(aCount), styles.tdSummary);
            createCell(row, 4 + numSessions + 2, String.valueOf(lCount), styles.tdSummary);

            int totalMarked = pCount + aCount + lCount;
            String pctStr = totalMarked > 0 ? String.format(Locale.ENGLISH, "%.0f%%", ((pCount + 0.5 * lCount) / totalMarked) * 100.0) : "100%";
            createCell(row, 4 + numSessions + 3, pctStr, styles.tdSummary);
        }

        int currentTotalRows = safeStudents.size();
        int minTotalRows = Math.max(currentTotalRows, 35);
        for (int i = currentTotalRows; i < minTotalRows; i++) {
            Row row = sheet.createRow(startDataRow + i);
            row.setHeight((short) (26.25 * 20));

            createCell(row, 0, String.valueOf(i + 1), styles.tdCenter);
            createCell(row, 1, "", styles.tdLeft);
            createCell(row, 2, "", styles.tdCenter);
            createCell(row, 3, "", styles.tdCenter);

            for (int colIdx = 0; colIdx < numSessions; colIdx++) {
                createCell(row, 4 + colIdx, "", styles.tdCenter);
            }

            createCell(row, 4 + numSessions, "", styles.tdSummary);
            createCell(row, 4 + numSessions + 1, "", styles.tdSummary);
            createCell(row, 4 + numSessions + 2, "", styles.tdSummary);
            createCell(row, 4 + numSessions + 3, "", styles.tdSummary);
        }

        int footerRowIdx = startDataRow + minTotalRows;
        Row fRow = sheet.createRow(footerRowIdx);
        fRow.setHeight((short) (22.0 * 20));

        Cell cTotal = fRow.createCell(0);
        cTotal.setCellValue("Total Enrolled: " + safeStudents.size() + " Students");
        cTotal.setCellStyle(styles.footerLabel);
        sheet.addMergedRegion(new CellRangeAddress(footerRowIdx, footerRowIdx, 0, 1));

        Cell cSex = fRow.createCell(2);
        cSex.setCellValue("Male: " + maleCount + "   Female: " + femaleCount);
        cSex.setCellStyle(styles.footerSex);
        sheet.addMergedRegion(new CellRangeAddress(footerRowIdx, footerRowIdx, 2, 3));
    }

    private static List<SessionColInfo> prepareSessionColumns(List<AttendanceRecord> sortedRecords) {
        List<SessionColInfo> result = new ArrayList<>();
        SimpleDateFormat monthFmt = new SimpleDateFormat("MMMM", Locale.ENGLISH);
        SimpleDateFormat dayFmt = new SimpleDateFormat("d", Locale.ENGLISH);

        List<Date> recordDates = new ArrayList<>();
        for (AttendanceRecord r : sortedRecords) {
            if (r.getSessionDate() != null && !recordDates.contains(r.getSessionDate())) {
                recordDates.add(r.getSessionDate());
            }
        }

        int totalSessions = Math.max(16, recordDates.size());

        if (!recordDates.isEmpty()) {
            for (int i = 0; i < recordDates.size(); i++) {
                Date d = recordDates.get(i);
                result.add(new SessionColInfo(i, String.valueOf(i + 1), monthFmt.format(d), dayFmt.format(d), d));
            }
            if (result.size() < totalSessions) {
                Date lastDate = recordDates.get(recordDates.size() - 1);
                Calendar cal = Calendar.getInstance();
                cal.setTime(lastDate);
                for (int i = result.size(); i < totalSessions; i++) {
                    cal.add(Calendar.DAY_OF_MONTH, 7);
                    Date nextDate = new Date(cal.getTimeInMillis());
                    result.add(new SessionColInfo(i, String.valueOf(i + 1), monthFmt.format(nextDate), dayFmt.format(nextDate), null));
                }
            }
        } else {
            Calendar cal = Calendar.getInstance();
            for (int i = 0; i < totalSessions; i++) {
                Date d = new Date(cal.getTimeInMillis());
                result.add(new SessionColInfo(i, String.valueOf(i + 1), monthFmt.format(d), "", null));
                cal.add(Calendar.DAY_OF_MONTH, 7);
            }
        }

        return result;
    }

    private static void buildTableHeaders(Sheet sheet, int startHeaderRow, List<SessionColInfo> sessionCols,
                                         int numSessions, int totalCols, StylePalette styles) {

        int monthRowIdx = startHeaderRow;
        int dateRowIdx = startHeaderRow + 1;
        int headerRowIdx = startHeaderRow + 2;

        Row rMonth = sheet.createRow(monthRowIdx);
        rMonth.setHeight((short) (21.75 * 20));
        for (int c = 0; c < 4; c++) {
            createCell(rMonth, c, "", styles.thCenter);
        }

        int groupStart = 0;
        while (groupStart < sessionCols.size()) {
            String mName = sessionCols.get(groupStart).monthName;
            int groupEnd = groupStart;
            while (groupEnd + 1 < sessionCols.size() && mName.equalsIgnoreCase(sessionCols.get(groupEnd + 1).monthName)) {
                groupEnd++;
            }

            int startCol = 4 + groupStart;
            int endCol = 4 + groupEnd;

            for (int c = startCol; c <= endCol; c++) {
                createCell(rMonth, c, "", styles.thCenter);
            }

            Cell headCell = rMonth.getCell(startCol);
            headCell.setCellValue(mName);

            if (endCol > startCol) {
                sheet.addMergedRegion(new CellRangeAddress(monthRowIdx, monthRowIdx, startCol, endCol));
            }

            groupStart = groupEnd + 1;
        }

        int sumStart = 4 + numSessions;
        int sumEnd = totalCols - 1;
        for (int c = sumStart; c <= sumEnd; c++) {
            createCell(rMonth, c, "", styles.thCenter);
        }
        Cell sumHead = rMonth.getCell(sumStart);
        sumHead.setCellValue("Summary");
        sheet.addMergedRegion(new CellRangeAddress(monthRowIdx, monthRowIdx, sumStart, sumEnd));

        Row rDate = sheet.createRow(dateRowIdx);
        rDate.setHeight((short) (21.75 * 20));
        for (int c = 0; c < 3; c++) {
            createCell(rDate, c, "", styles.thCenter);
        }
        createCell(rDate, 3, "Date:", styles.thRight);

        for (int i = 0; i < numSessions; i++) {
            SessionColInfo colInfo = sessionCols.get(i);
            createCell(rDate, 4 + i, colInfo.dayStr, styles.thCenter);
        }

        for (int c = sumStart; c <= sumEnd; c++) {
            createCell(rDate, c, "", styles.thCenter);
        }

        Row rCol = sheet.createRow(headerRowIdx);
        rCol.setHeight((short) (21.75 * 20));

        createCell(rCol, 0, "Nº", styles.thCenter);
        createCell(rCol, 1, "Name", styles.thCenter);
        createCell(rCol, 2, "Sex", styles.thCenter);
        createCell(rCol, 3, "ID", styles.thCenter);

        for (int i = 0; i < numSessions; i++) {
            createCell(rCol, 4 + i, sessionCols.get(i).sessionNumber, styles.thCenter);
        }

        createCell(rCol, 4 + numSessions, "P", styles.thCenter);
        createCell(rCol, 4 + numSessions + 1, "A", styles.thCenter);
        createCell(rCol, 4 + numSessions + 2, "L", styles.thCenter);
        createCell(rCol, 4 + numSessions + 3, "%", styles.thCenter);
    }

    private static String getStudentSex(User s) {
        if (s == null) return "M";
        String g = s.getGender();
        if (g != null) {
            String trimmed = g.trim();
            if ("FEMALE".equalsIgnoreCase(trimmed) || "F".equalsIgnoreCase(trimmed)) {
                return "F";
            }
        }
        return "M";
    }

    private static String getRoomDisplay(ClassSection section) {
        if (section == null || section.getRoomName() == null || section.getRoomName().trim().isEmpty()) {
            return "501";
        }
        String r = section.getRoomName().trim();
        if (r.toLowerCase().startsWith("room")) {
            return r.substring(4).trim();
        }
        return r;
    }

    private static String getInstructorDisplay(ClassSection section, User professor) {
        if (professor != null && professor.getFullName() != null && !professor.getFullName().trim().isEmpty()) {
            return professor.getFullName().trim();
        }
        if (section != null && section.getProfessorName() != null && !section.getProfessorName().trim().isEmpty()) {
            return section.getProfessorName().trim();
        }
        return "Faculty Member";
    }

    private static String getTimeDisplay(ClassSection section) {
        if (section == null) return "Evening";
        String shift = section.getSessionShift() != null ? section.getSessionShift().name() : "Evening";
        String days = section.getDaysOfWeek() != null ? section.getDaysOfWeek().trim() : "";
        if (days.isEmpty()) {
            return shift;
        }
        return shift + " (" + days + ")";
    }

    private static void createMergedRow(Sheet sheet, Row row, int startCol, int endCol, String value, CellStyle style) {
        for (int c = startCol; c <= endCol; c++) {
            Cell cell = row.createCell(c);
            cell.setCellStyle(style);
        }
        Cell first = row.getCell(startCol);
        first.setCellValue(value);
        if (endCol > startCol) {
            sheet.addMergedRegion(new CellRangeAddress(row.getRowNum(), row.getRowNum(), startCol, endCol));
        }
    }

    private static void createMetadataRow(Sheet sheet, int rowIdx, double height, String label, String value,
                                         int labelEndCol, int valStartCol, int valEndCol, StylePalette styles) {
        Row row = sheet.createRow(rowIdx);
        row.setHeight((short) (height * 20));

        for (int c = 0; c <= labelEndCol; c++) {
            Cell cell = row.createCell(c);
            cell.setCellStyle(styles.metaLabel);
        }
        row.getCell(0).setCellValue(label);
        if (labelEndCol > 0) {
            sheet.addMergedRegion(new CellRangeAddress(rowIdx, rowIdx, 0, labelEndCol));
        }

        for (int c = valStartCol; c <= valEndCol; c++) {
            Cell cell = row.createCell(c);
            cell.setCellStyle(styles.metaValue);
        }
        row.getCell(valStartCol).setCellValue(value);
        if (valEndCol > valStartCol) {
            sheet.addMergedRegion(new CellRangeAddress(rowIdx, rowIdx, valStartCol, valEndCol));
        }
    }

    private static void createCell(Row row, int colIdx, String value, CellStyle style) {
        Cell cell = row.createCell(colIdx);
        cell.setCellValue(value);
        cell.setCellStyle(style);
    }

    static class SessionColInfo {
        int colIndex;
        String sessionNumber;
        String monthName;
        String dayStr;
        Date date;

        SessionColInfo(int colIndex, String sessionNumber, String monthName, String dayStr, Date date) {
            this.colIndex = colIndex;
            this.sessionNumber = sessionNumber;
            this.monthName = monthName;
            this.dayStr = dayStr;
            this.date = date;
        }
    }

    private static class StylePalette {
        final CellStyle khmerHeader;
        final CellStyle engHeader;
        final CellStyle separatorRow;
        final CellStyle termHeader;
        final CellStyle metaLabel;
        final CellStyle metaValue;
        final CellStyle thCenter;
        final CellStyle thRight;
        final CellStyle tdCenter;
        final CellStyle tdLeft;
        final CellStyle tdSummary;
        final CellStyle footerLabel;
        final CellStyle footerSex;

        StylePalette(Workbook wb) {
            Font fontKhmer = wb.createFont();
            fontKhmer.setFontName(FONT_KHMER);
            fontKhmer.setFontHeightInPoints((short) 12);
            fontKhmer.setBold(true);

            Font fontTimes11Bold = wb.createFont();
            fontTimes11Bold.setFontName(FONT_TIMES);
            fontTimes11Bold.setFontHeightInPoints((short) 11);
            fontTimes11Bold.setBold(true);

            Font fontTimes12Bold = wb.createFont();
            fontTimes12Bold.setFontName(FONT_TIMES);
            fontTimes12Bold.setFontHeightInPoints((short) 12);
            fontTimes12Bold.setBold(true);

            Font fontTimes11Norm = wb.createFont();
            fontTimes11Norm.setFontName(FONT_TIMES);
            fontTimes11Norm.setFontHeightInPoints((short) 11);
            fontTimes11Norm.setBold(false);

            Font fontTimes12Norm = wb.createFont();
            fontTimes12Norm.setFontName(FONT_TIMES);
            fontTimes12Norm.setFontHeightInPoints((short) 12);
            fontTimes12Norm.setBold(false);

            khmerHeader = wb.createCellStyle();
            khmerHeader.setFont(fontKhmer);
            khmerHeader.setAlignment(HorizontalAlignment.CENTER);
            khmerHeader.setVerticalAlignment(VerticalAlignment.CENTER);

            engHeader = wb.createCellStyle();
            engHeader.setFont(fontTimes11Bold);
            engHeader.setAlignment(HorizontalAlignment.CENTER);
            engHeader.setVerticalAlignment(VerticalAlignment.CENTER);

            separatorRow = wb.createCellStyle();
            separatorRow.setFont(fontTimes11Norm);
            separatorRow.setAlignment(HorizontalAlignment.CENTER);
            separatorRow.setVerticalAlignment(VerticalAlignment.CENTER);

            termHeader = wb.createCellStyle();
            termHeader.setFont(fontTimes12Bold);
            termHeader.setAlignment(HorizontalAlignment.CENTER);
            termHeader.setVerticalAlignment(VerticalAlignment.CENTER);

            metaLabel = wb.createCellStyle();
            metaLabel.setFont(fontTimes11Bold);
            metaLabel.setAlignment(HorizontalAlignment.RIGHT);
            metaLabel.setVerticalAlignment(VerticalAlignment.CENTER);

            metaValue = wb.createCellStyle();
            metaValue.setFont(fontTimes11Bold);
            metaValue.setAlignment(HorizontalAlignment.LEFT);
            metaValue.setVerticalAlignment(VerticalAlignment.CENTER);

            thCenter = wb.createCellStyle();
            thCenter.setFont(fontTimes11Bold);
            thCenter.setAlignment(HorizontalAlignment.CENTER);
            thCenter.setVerticalAlignment(VerticalAlignment.CENTER);
            applyThinBorders(thCenter);

            thRight = wb.createCellStyle();
            thRight.setFont(fontTimes11Bold);
            thRight.setAlignment(HorizontalAlignment.RIGHT);
            thRight.setVerticalAlignment(VerticalAlignment.CENTER);
            applyThinBorders(thRight);

            tdCenter = wb.createCellStyle();
            tdCenter.setFont(fontTimes11Norm);
            tdCenter.setAlignment(HorizontalAlignment.CENTER);
            tdCenter.setVerticalAlignment(VerticalAlignment.CENTER);
            applyThinBorders(tdCenter);

            tdLeft = wb.createCellStyle();
            tdLeft.setFont(fontTimes12Norm);
            tdLeft.setAlignment(HorizontalAlignment.LEFT);
            tdLeft.setVerticalAlignment(VerticalAlignment.CENTER);
            applyThinBorders(tdLeft);

            tdSummary = wb.createCellStyle();
            tdSummary.setFont(fontTimes11Bold);
            tdSummary.setAlignment(HorizontalAlignment.CENTER);
            tdSummary.setVerticalAlignment(VerticalAlignment.CENTER);
            applyThinBorders(tdSummary);

            footerLabel = wb.createCellStyle();
            footerLabel.setFont(fontTimes11Bold);
            footerLabel.setAlignment(HorizontalAlignment.LEFT);
            footerLabel.setVerticalAlignment(VerticalAlignment.CENTER);

            footerSex = wb.createCellStyle();
            footerSex.setFont(fontTimes11Bold);
            footerSex.setAlignment(HorizontalAlignment.CENTER);
            footerSex.setVerticalAlignment(VerticalAlignment.CENTER);
        }

        private static void applyThinBorders(CellStyle style) {
            style.setBorderTop(BorderStyle.THIN);
            style.setBorderBottom(BorderStyle.THIN);
            style.setBorderLeft(BorderStyle.THIN);
            style.setBorderRight(BorderStyle.THIN);
        }
    }
}
