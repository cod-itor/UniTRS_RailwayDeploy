package com.unitrs.utils;

import java.util.HashSet;
import java.util.Set;

public class ScheduleUtils {

    private static final String[] WEEKDAYS = {"mon", "tue", "wed", "thu", "fri"};
    private static final String[] WEEKENDS = {"sat", "sun"};
    private static final String[] ALL_DAYS = {"mon", "tue", "wed", "thu", "fri", "sat", "sun"};

    private ScheduleUtils() {}

    public static Set<String> parseDays(String daysStr) {
        Set<String> result = new HashSet<>();
        if (daysStr == null || daysStr.trim().isEmpty()) {
            return result;
        }

        String lower = daysStr.toLowerCase();
        if (lower.contains("mon-fri") || lower.contains("mon - fri")) {
            for (String d : WEEKDAYS) {
                result.add(d);
            }
        }
        if (lower.contains("sat-sun") || lower.contains("sat - sun")) {
            for (String d : WEEKENDS) {
                result.add(d);
            }
        }

        for (String day : ALL_DAYS) {
            if (lower.contains(day)) {
                result.add(day);
            }
        }
        return result;
    }

    public static boolean daysOverlap(String days1, String days2) {
        Set<String> set1 = parseDays(days1);
        Set<String> set2 = parseDays(days2);

        for (String d : set1) {
            if (set2.contains(d)) {
                return true;
            }
        }
        return false;
    }
}
