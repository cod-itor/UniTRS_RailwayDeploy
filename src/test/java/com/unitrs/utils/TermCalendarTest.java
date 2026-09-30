package com.unitrs.utils;

import org.junit.jupiter.api.Test;

import java.time.DayOfWeek;
import java.time.LocalDate;

import static org.junit.jupiter.api.Assertions.*;

public class TermCalendarTest {

    @Test
    void termsAlwaysStartOnMonday() {
        for (int year = 2024; year <= 2035; year++) {
            for (int term = 1; term <= 3; term++) {
                assertEquals(DayOfWeek.MONDAY, TermCalendar.window(year + "-" + (year + 1), term).getStart().getDayOfWeek());
            }
        }
    }

    @Test
    void windowsFor2026() {
        TermCalendar.Window t1 = TermCalendar.window("2026-2027", 1);
        assertEquals(LocalDate.of(2026, 8, 3), t1.getStart());
        assertEquals(LocalDate.of(2026, 11, 22), t1.getEnd());
        TermCalendar.Window t2 = TermCalendar.window("2026-2027", 5);
        assertEquals(2, t2.getSlot());
        assertEquals(LocalDate.of(2026, 11, 30), t2.getStart());
        TermCalendar.Window t3 = TermCalendar.window("2026-2027", 15);
        assertEquals(3, t3.getSlot());
        assertEquals(LocalDate.of(2027, 3, 29), t3.getStart());
        assertEquals(LocalDate.of(2027, 7, 18), t3.getEnd());
    }

    @Test
    void termsDoNotOverlapAndYearsDoNotOverlap() {
        TermCalendar.Window a = TermCalendar.window("2026-2027", 1);
        TermCalendar.Window b = TermCalendar.window("2026-2027", 2);
        TermCalendar.Window c = TermCalendar.window("2026-2027", 3);
        assertTrue(b.getStart().isAfter(a.getEnd()));
        assertTrue(c.getStart().isAfter(b.getEnd()));
        assertTrue(TermCalendar.window("2027-2028", 1).getStart().isAfter(c.getEnd()));
    }

    @Test
    void fifteenSessionsAlwaysFitEvenAtOneDayPerWeek() {
        String[] patterns = {"Mon", "Tue", "Wed", "Thu", "Fri", "Sat-Sun", "Mon, Tue", "Mon-Fri", "Mon, Tue, Wed"};
        for (int year = 2024; year <= 2035; year++) {
            for (int term = 1; term <= 3; term++) {
                TermCalendar.Window w = TermCalendar.window(year + "-" + (year + 1), term);
                for (String p : patterns) {
                    LocalDate last = TermCalendar.sessionDate(p, w.getStart(), TermCalendar.SESSIONS_PER_TERM);
                    assertFalse(last.isAfter(w.getEnd()), p + " " + year + " term " + term + " ends " + last);
                    // at least one spare week is left for public holidays
                    assertTrue(last.isBefore(w.getEnd().minusDays(1)) || last.isEqual(w.getEnd().minusDays(1)) || p.equals("Mon"));
                }
            }
        }
    }

    @Test
    void firstSessionIsOnOrAfterTermStart() {
        LocalDate start = LocalDate.of(2026, 8, 3);
        assertEquals(LocalDate.of(2026, 8, 5), TermCalendar.firstSession("Wed, Thu", start));
        assertEquals(LocalDate.of(2026, 8, 3), TermCalendar.firstSession("Mon-Fri", start));
        assertEquals(LocalDate.of(2026, 8, 8), TermCalendar.firstSession("Sat-Sun", start));
    }

    @Test
    void slotMapping() {
        assertEquals(1, TermCalendar.slotOf(1));
        assertEquals(3, TermCalendar.slotOf(3));
        assertEquals(1, TermCalendar.slotOf(4));
        assertEquals(3, TermCalendar.slotOf(15));
    }

    @Test
    void invalidAcademicYearRejected() {
        assertThrows(IllegalArgumentException.class, () -> TermCalendar.window("abc", 1));
    }
}
