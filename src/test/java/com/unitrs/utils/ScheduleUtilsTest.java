package com.unitrs.utils;

import org.junit.jupiter.api.Test;

import java.util.Set;

import static org.junit.jupiter.api.Assertions.*;

public class ScheduleUtilsTest {

    @Test
    void testParseDaysMonFri() {
        Set<String> days = ScheduleUtils.parseDays("Mon-Fri");
        assertTrue(days.contains("mon"));
        assertTrue(days.contains("tue"));
        assertTrue(days.contains("wed"));
        assertTrue(days.contains("thu"));
        assertTrue(days.contains("fri"));
        assertFalse(days.contains("sat"));
        assertFalse(days.contains("sun"));
    }

    @Test
    void testParseDaysSatSun() {
        Set<String> days = ScheduleUtils.parseDays("Sat-Sun");
        assertTrue(days.contains("sat"));
        assertTrue(days.contains("sun"));
        assertFalse(days.contains("mon"));
    }

    @Test
    void testParseSpecificDays() {
        Set<String> days = ScheduleUtils.parseDays("Mon, Wed, Fri");
        assertTrue(days.contains("mon"));
        assertTrue(days.contains("wed"));
        assertTrue(days.contains("fri"));
        assertFalse(days.contains("tue"));
        assertFalse(days.contains("thu"));
    }

    @Test
    void testDaysOverlapTrue() {
        assertTrue(ScheduleUtils.daysOverlap("Mon-Fri", "Wed"));
        assertTrue(ScheduleUtils.daysOverlap("Mon, Tue", "Tue, Thu"));
        assertTrue(ScheduleUtils.daysOverlap("Mon - Fri", "Mon, Wed, Fri"));
        assertTrue(ScheduleUtils.daysOverlap("Sat-Sun", "Sun"));
    }

    @Test
    void testDaysOverlapFalse() {
        assertFalse(ScheduleUtils.daysOverlap("Mon-Fri", "Sat-Sun"));
        assertFalse(ScheduleUtils.daysOverlap("Mon, Wed", "Tue, Thu"));
        assertFalse(ScheduleUtils.daysOverlap("Sat", "Sun"));
        assertFalse(ScheduleUtils.daysOverlap(null, "Mon"));
        assertFalse(ScheduleUtils.daysOverlap("Mon", ""));
    }
}
