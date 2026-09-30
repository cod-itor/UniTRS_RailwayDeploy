package com.unitrs.utils;

import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/** The fixed list of report categories and issues students and professors can choose from. */
public final class ReportCatalog {

    public static final String SEPARATOR = "::";

    public static class Issue {
        private final String label;
        private final String description;

        Issue(String label, String description) {
            this.label = label;
            this.description = description;
        }

        public String getLabel() {
            return label;
        }

        public String getDescription() {
            return description;
        }
    }

    private static final Map<String, List<Issue>> CATALOG = new LinkedHashMap<>();

    static {
        add("Academic Issues",
                new Issue("Understanding material", "Struggling to follow lessons or understand concepts."),
                new Issue("Missing assignments", "Unable to submit homework or projects on time."),
                new Issue("Grades or exam stress", "Anxiety about test performance or falling marks."),
                new Issue("Group work difficulties", "Issues collaborating with project partners."));
        add("Technical & Access Problems",
                new Issue("Software or login issues", "Unable to access school portals, email, or apps."),
                new Issue("Hardware malfunction", "Broken laptop, tablet, or charger."),
                new Issue("Internet connectivity", "Poor Wi-Fi preventing access to online learning."));
        add("Classroom & Behavioral Concerns",
                new Issue("Classroom distraction", "Difficulty focusing or disruptions from peers."),
                new Issue("Attendance or lateness", "Issues arriving to class or logging in on time."),
                new Issue("Bullying or harassment", "Unfair or harmful treatment from others."));
        add("Personal & Well-being Support",
                new Issue("Health or illness", "Missing school due to physical sickness or medical appointments."),
                new Issue("Mental health or burnout", "Feeling overwhelmed, anxious, or highly stressed."),
                new Issue("Scheduling conflict", "Personal, family, or work commitments overlapping with class."));
    }

    private ReportCatalog() {}

    private static void add(String category, Issue... issues) {
        List<Issue> list = new ArrayList<>();
        Collections.addAll(list, issues);
        CATALOG.put(category, Collections.unmodifiableList(list));
    }

    public static Map<String, List<Issue>> getCatalog() {
        return Collections.unmodifiableMap(CATALOG);
    }

    /** Returns {category, issue} for a submitted "Category::Issue" value, or null if it is not in the catalog. */
    public static String[] resolve(String submitted) {
        if (submitted == null) {
            return null;
        }
        int idx = submitted.indexOf(SEPARATOR);
        if (idx < 0) {
            return null;
        }
        String category = submitted.substring(0, idx);
        String issue = submitted.substring(idx + SEPARATOR.length());
        List<Issue> issues = CATALOG.get(category);
        if (issues == null) {
            return null;
        }
        for (Issue i : issues) {
            if (i.getLabel().equals(issue)) {
                return new String[] { category, issue };
            }
        }
        return null;
    }
}
