package com.unitrs.utils;

import com.unitrs.model.entity.Grade;
import org.junit.jupiter.api.Test;

import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

public class GradeCalculatorTest {

    @Test
    void testCalculateTotal() {
        assertEquals(85.0, GradeCalculator.calculateTotal(15.0, 20.0, 25.0, 25.0));
        assertEquals(100.0, GradeCalculator.calculateTotal(15.0, 25.0, 30.0, 30.0));
        assertEquals(0.0, GradeCalculator.calculateTotal(-5.0, 0.0, 0.0, 0.0));
    }

    @Test
    void testCalculateLetterGrade() {
        assertEquals("A", GradeCalculator.calculateLetterGrade(95.0));
        assertEquals("B+", GradeCalculator.calculateLetterGrade(89.5));
        assertEquals("B", GradeCalculator.calculateLetterGrade(84.0));
        assertEquals("C+", GradeCalculator.calculateLetterGrade(78.0));
        assertEquals("C", GradeCalculator.calculateLetterGrade(72.0));
        assertEquals("D+", GradeCalculator.calculateLetterGrade(66.0));
        assertEquals("D", GradeCalculator.calculateLetterGrade(60.0));
        assertEquals("F", GradeCalculator.calculateLetterGrade(59.9));
    }

    @Test
    void testCalculateGpaPoint() {
        assertEquals(4.0, GradeCalculator.calculateGpaPoint("A"));
        assertEquals(3.5, GradeCalculator.calculateGpaPoint("B+"));
        assertEquals(3.0, GradeCalculator.calculateGpaPoint("B"));
        assertEquals(2.5, GradeCalculator.calculateGpaPoint("C+"));
        assertEquals(2.0, GradeCalculator.calculateGpaPoint("C"));
        assertEquals(1.5, GradeCalculator.calculateGpaPoint("D+"));
        assertEquals(1.0, GradeCalculator.calculateGpaPoint("D"));
        assertEquals(0.0, GradeCalculator.calculateGpaPoint("F"));
        assertEquals(0.0, GradeCalculator.calculateGpaPoint("N/A"));
        assertEquals(0.0, GradeCalculator.calculateGpaPoint(null));
    }

    @Test
    void testCalculateTermGpaWithAllGraded() {
        List<Grade> grades = new ArrayList<>();

        Grade g1 = new Grade();
        g1.setCredits(3);
        g1.setGpaPoint(4.0);
        g1.setLetterGrade("A");
        grades.add(g1);

        Grade g2 = new Grade();
        g2.setCredits(3);
        g2.setGpaPoint(3.0);
        g2.setLetterGrade("B");
        grades.add(g2);

        assertEquals(3.50, GradeCalculator.calculateTermGpa(grades));
    }

    @Test
    void testCalculateTermGpaIgnoresUngradedCourses() {
        List<Grade> grades = new ArrayList<>();

        Grade gradedCourse = new Grade();
        gradedCourse.setCredits(3);
        gradedCourse.setGpaPoint(4.0);
        gradedCourse.setLetterGrade("A");
        grades.add(gradedCourse);

        Grade unGraded1 = new Grade();
        unGraded1.setCredits(3);
        unGraded1.setGpaPoint(0.0);
        unGraded1.setLetterGrade("N/A");
        grades.add(unGraded1);

        Grade unGraded2 = new Grade();
        unGraded2.setCredits(3);
        unGraded2.setGpaPoint(0.0);
        unGraded2.setLetterGrade(null);
        grades.add(unGraded2);

        Grade inProgress = new Grade();
        inProgress.setCredits(3);
        inProgress.setGpaPoint(0.0);
        inProgress.setLetterGrade("IN PROGRESS");
        grades.add(inProgress);

        assertEquals(4.00, GradeCalculator.calculateTermGpa(grades));
    }

    @Test
    void testCalculateTermGpaAllUngradedReturnsZero() {
        List<Grade> grades = new ArrayList<>();

        Grade unGraded = new Grade();
        unGraded.setCredits(3);
        unGraded.setGpaPoint(0.0);
        unGraded.setLetterGrade("N/A");
        grades.add(unGraded);

        assertEquals(0.00, GradeCalculator.calculateTermGpa(grades));
    }

    @Test
    void testCalculateAttendanceScore() {
        assertEquals(15.0, GradeCalculator.calculateAttendanceScore(10, 0, 0, 10));
        assertEquals(15.0, GradeCalculator.calculateAttendanceScore(0, 0, 0, 0));
        assertEquals(7.5, GradeCalculator.calculateAttendanceScore(5, 0, 0, 10));
        assertEquals(8.25, GradeCalculator.calculateAttendanceScore(5, 1, 0, 10));
        assertEquals(9.75, GradeCalculator.calculateAttendanceScore(5, 1, 1, 10));
        assertEquals(0.0, GradeCalculator.calculateAttendanceScore(0, 0, 0, 10));
    }
}
