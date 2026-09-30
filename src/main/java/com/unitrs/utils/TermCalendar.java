package com.unitrs.utils;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.temporal.TemporalAdjusters;
import java.util.Set;

/**
 * Fixed academic calendar: every academic year has 3 terms that always start on the same Monday.
 *
 * <pre>
 * Year starts on the first Monday of August. Each term is 16 weeks (Mon..Sun), followed by a 1-week break.
 * e.g. 2026-2027: Term slot 1 = 03 Aug - 22 Nov 2026, slot 2 = 30 Nov 2026 - 21 Mar 2027, slot 3 = 29 Mar - 18 Jul 2027
 * </pre>
 *
 * A course needs 15 sessions. Even a class that meets only one day a week finishes by week 15, which leaves
 * one spare week in the 16-week window for public holidays.
 * Curriculum terms are numbered 1, 2, 3, ... : terms 1-3 are the first study year, 4-6 the second, and so on,
 * so the calendar slot of curriculum term N is ((N - 1) % 3) + 1.
 */
public final class TermCalendar {

    public static final int TERMS_PER_YEAR = 3;
    public static final int SESSIONS_PER_TERM = 15;
    public static final int TERM_WEEKS = 16;
    public static final int BREAK_WEEKS = 1;

    private TermCalendar() {}

    public static final class Window {
        private final int slot;
        private final LocalDate start;
        private final LocalDate end;

        Window(int slot, LocalDate start, LocalDate end) {
            this.slot = slot;
            this.start = start;
            this.end = end;
        }

        public int getSlot() {
            return slot;
        }

        public LocalDate getStart() {
            return start;
        }

        public LocalDate getEnd() {
            return end;
        }

        public java.sql.Date getStartDate() {
            return java.sql.Date.valueOf(start);
        }

        public java.sql.Date getEndDate() {
            return java.sql.Date.valueOf(end);
        }
    }

    /** Calendar slot (1..3) of a curriculum term number. */
    public static int slotOf(int termNumber) {
        return ((Math.max(termNumber, 1) - 1) % TERMS_PER_YEAR) + 1;
    }

    /** First year of an academic year label such as "2026-2027". */
    public static int startYearOf(String academicYear) {
        if (academicYear == null || !academicYear.trim().matches("^\\d{4}(-\\d{4})?$")) {
            throw new IllegalArgumentException("Invalid academic year: " + academicYear);
        }
        return Integer.parseInt(academicYear.trim().substring(0, 4));
    }

    public static LocalDate academicYearStart(int startYear) {
        return LocalDate.of(startYear, 8, 1).with(TemporalAdjusters.firstInMonth(DayOfWeek.MONDAY));
    }

    public static Window window(String academicYear, int termNumber) {
        int slot = slotOf(termNumber);
        LocalDate start = academicYearStart(startYearOf(academicYear))
                .plusWeeks((long) (slot - 1) * (TERM_WEEKS + BREAK_WEEKS));
        LocalDate end = start.plusWeeks(TERM_WEEKS).minusDays(1);
        return new Window(slot, start, end);
    }

    /** Date of the first class meeting on or after the term start. */
    public static LocalDate firstSession(String daysOfWeek, LocalDate termStart) {
        return sessionDate(daysOfWeek, termStart, 1);
    }

    /** Date of the given session number (1-based) counting only the days the class meets. */
    public static LocalDate sessionDate(String daysOfWeek, LocalDate termStart, int sessionNumber) {
        Set<String> days = ScheduleUtils.parseDays(daysOfWeek);
        if (days.isEmpty()) {
            throw new IllegalArgumentException("No meeting days in: " + daysOfWeek);
        }
        LocalDate date = termStart;
        int count = 0;
        while (true) {
            if (days.contains(date.getDayOfWeek().name().substring(0, 3).toLowerCase())) {
                count++;
                if (count == sessionNumber) {
                    return date;
                }
            }
            date = date.plusDays(1);
        }
    }
}
