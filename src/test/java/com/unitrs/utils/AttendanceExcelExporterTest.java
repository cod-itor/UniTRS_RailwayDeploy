package com.unitrs.utils;

import com.unitrs.model.entity.*;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.*;

import static org.junit.jupiter.api.Assertions.*;

class AttendanceExcelExporterTest {

    @Test
    @DisplayName("Should generate valid Excel workbook for a single section with attendance records")
    void testExportSectionAttendance() throws IOException {
        ClassSection section = new ClassSection();
        section.setId(101);
        section.setCourseCode("CSC101");
        section.setCourseTitle("Introduction to Programming");
        section.setTermName("Term 1");
        section.setAcademicYear("2025-2026");
        section.setSessionShift(SessionShift.MORNING);
        section.setDaysOfWeek("Mon, Wed, Fri");
        section.setRoomName("Room 102");
        section.setProfessorName("Dr. Alan Turing");

        User prof = new User();
        prof.setId(1);
        prof.setFullName("Dr. Alan Turing");
        prof.setUserIdentifier("P101");

        School school = new School();
        school.setId(7);
        school.setSchoolName("College of Science and Technology");

        User s1 = new User();
        s1.setId(201);
        s1.setFullName("Alice Smith");
        s1.setUserIdentifier("S201");
        s1.setMajor("Computer Science");

        User s2 = new User();
        s2.setId(202);
        s2.setFullName("Bob Johnson");
        s2.setUserIdentifier("S202");
        s2.setMajor("Computer Science");

        List<User> students = List.of(s1, s2);

        Date d1 = Date.valueOf(LocalDate.of(2026, 9, 1));
        Date d2 = Date.valueOf(LocalDate.of(2026, 9, 3));

        AttendanceRecord r1 = new AttendanceRecord();
        r1.setId(1);
        r1.setClassSectionId(101);
        r1.setSessionDate(d1);
        r1.setPresentCount(2);
        r1.setAbsentCount(0);
        r1.setLateCount(0);
        r1.setExcusedCount(0);
        r1.setEntries(List.of(
                new AttendanceEntry(1, 1, 201, "PRESENT", "Alice Smith", "S201", d1),
                new AttendanceEntry(2, 1, 202, "PRESENT", "Bob Johnson", "S202", d1)
        ));

        AttendanceRecord r2 = new AttendanceRecord();
        r2.setId(2);
        r2.setClassSectionId(101);
        r2.setSessionDate(d2);
        r2.setPresentCount(1);
        r2.setAbsentCount(1);
        r2.setLateCount(0);
        r2.setExcusedCount(0);
        r2.setEntries(List.of(
                new AttendanceEntry(3, 2, 201, "PRESENT", "Alice Smith", "S201", d2),
                new AttendanceEntry(4, 2, 202, "ABSENT", "Bob Johnson", "S202", d2)
        ));

        List<AttendanceRecord> records = List.of(r1, r2);

        byte[] excelBytes = AttendanceExcelExporter.exportSectionAttendance(section, prof, school, students, records);
        assertNotNull(excelBytes);
        assertTrue(excelBytes.length > 0);

        // Verify valid POI workbook
        try (XSSFWorkbook wb = new XSSFWorkbook(new ByteArrayInputStream(excelBytes))) {
            assertEquals(1, wb.getNumberOfSheets());
            Sheet sheet = wb.getSheetAt(0);
            assertNotNull(sheet);
            assertTrue(sheet.getSheetName().contains("CSC101"));

            // Check header banner
            Row titleRow = sheet.getRow(1);
            assertNotNull(titleRow);
            assertEquals("UniTRS — UNIVERSITY MANAGEMENT SYSTEM", titleRow.getCell(0).getStringCellValue());

            // Check metadata row
            Row metaRow = sheet.getRow(4);
            assertNotNull(metaRow);
            assertTrue(metaRow.getCell(1).getStringCellValue().contains("CSC101"));
        }
    }

    @Test
    @DisplayName("Should generate valid Excel workbook when section has no recorded sessions")
    void testExportSectionWithNoAttendanceRecords() throws IOException {
        ClassSection section = new ClassSection();
        section.setId(102);
        section.setCourseCode("CSC201");
        section.setCourseTitle("Data Structures");
        section.setSessionShift(SessionShift.EVENING);

        User prof = new User();
        prof.setId(2);
        prof.setFullName("Dr. Grace Hopper");

        School school = new School();
        school.setSchoolName("College of Science and Technology");

        User s1 = new User();
        s1.setId(201);
        s1.setFullName("Alice Smith");

        byte[] excelBytes = AttendanceExcelExporter.exportSectionAttendance(section, prof, school, List.of(s1), Collections.emptyList());
        assertNotNull(excelBytes);
        assertTrue(excelBytes.length > 0);

        try (XSSFWorkbook wb = new XSSFWorkbook(new ByteArrayInputStream(excelBytes))) {
            assertEquals(1, wb.getNumberOfSheets());
            Sheet sheet = wb.getSheetAt(0);
            assertTrue(sheet.getSheetName().contains("CSC201"));
        }
    }

    @Test
    @DisplayName("Should generate multi-sheet workbook for all assigned classes with an Overview sheet")
    void testExportAllSectionsAttendance() throws IOException {
        ClassSection s1 = new ClassSection();
        s1.setId(1);
        s1.setCourseCode("ITE205");
        s1.setCourseTitle("Database Systems");
        s1.setSessionShift(SessionShift.AFTERNOON);

        ClassSection s2 = new ClassSection();
        s2.setId(2);
        s2.setCourseCode("ITE301");
        s2.setCourseTitle("Web Programming");
        s2.setSessionShift(SessionShift.MORNING);

        User prof = new User();
        prof.setId(10);
        prof.setFullName("Prof. Sok Chan");
        prof.setUserIdentifier("P101");

        School school = new School();
        school.setSchoolName("College of Science and Technology");

        Map<ClassSection, List<User>> studentsMap = new LinkedHashMap<>();
        studentsMap.put(s1, List.of(new User()));
        studentsMap.put(s2, List.of(new User(), new User()));

        Map<Integer, List<AttendanceRecord>> attMap = new HashMap<>();

        byte[] bytes = AttendanceExcelExporter.exportAllSectionsAttendance(prof, school, studentsMap, attMap);
        assertNotNull(bytes);
        assertTrue(bytes.length > 0);

        try (XSSFWorkbook wb = new XSSFWorkbook(new ByteArrayInputStream(bytes))) {
            assertEquals(3, wb.getNumberOfSheets());
            assertEquals("Teaching Overview", wb.getSheetName(0));
            assertTrue(wb.getSheetName(1).contains("ITE205"));
            assertTrue(wb.getSheetName(2).contains("ITE301"));
        }
    }
}
