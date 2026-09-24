package com.unitrs.utils;

import com.unitrs.model.entity.Grade;
import java.util.List;

public class GradeCalculator {

    public static final double MAX_ATTENDANCE = 15.0;
    public static final double MAX_ASSIGNMENT = 25.0;
    public static final double MAX_MIDTERM = 30.0;
    public static final double MAX_FINAL = 30.0;
    public static final double MAX_TOTAL = 100.0;

    private GradeCalculator() {}

    public static double calculateTotal(double attendance, double assignment, double midterm, double finalScore) {
        double total = attendance + assignment + midterm + finalScore;
        if (total < 0) {
            return 0.0;
        }
        return Math.min(total, MAX_TOTAL);
    }

    public static String calculateLetterGrade(double totalScore) {
        if (totalScore >= 95.0) {
            return "A";
        } else if (totalScore >= 89.0) {
            return "B+";
        } else if (totalScore >= 83.0) {
            return "B";
        } else if (totalScore >= 77.0) {
            return "C+";
        } else if (totalScore >= 71.0) {
            return "C";
        } else if (totalScore >= 65.0) {
            return "D+";
        } else if (totalScore >= 60.0) {
            return "D";
        } else {
            return "F";
        }
    }

    public static double calculateGpaPoint(String letterGrade) {
        if (letterGrade == null) {
            return 0.00;
        }
        return switch (letterGrade.trim().toUpperCase()) {
            case "A" -> 4.00;
            case "B+" -> 3.50;
            case "B" -> 3.00;
            case "C+" -> 2.50;
            case "C" -> 2.00;
            case "D+" -> 1.50;
            case "D" -> 1.00;
            default -> 0.00;
        };
    }

    public static double calculateGpaPointFromScore(double totalScore) {
        return calculateGpaPoint(calculateLetterGrade(totalScore));
    }

    public static double calculateTermGpa(List<Grade> grades) {
        if (grades == null || grades.isEmpty()) {
            return 0.00;
        }

        double totalWeightedPoints = 0.0;
        int totalCredits = 0;

        for (Grade grade : grades) {
            String letter = grade.getLetterGrade();

            if (letter == null || letter.trim().isEmpty()
                    || "N/A".equalsIgnoreCase(letter.trim())
                    || "IN PROGRESS".equalsIgnoreCase(letter.trim())
                    || "PENDING".equalsIgnoreCase(letter.trim())) {
                continue;
            }

            int credits = grade.getCredits() > 0 ? grade.getCredits() : 3;
            totalWeightedPoints += (grade.getGpaPoint() * credits);
            totalCredits += credits;
        }

        if (totalCredits == 0) {
            return 0.00;
        }

        double gpa = totalWeightedPoints / totalCredits;
        return Math.round(gpa * 100.0) / 100.0;
    }

    public static boolean isValidAttendance(double score) {
        return score >= 0.0 && score <= MAX_ATTENDANCE;
    }

    public static boolean isValidAssignment(double score) {
        return score >= 0.0 && score <= MAX_ASSIGNMENT;
    }

    public static boolean isValidMidterm(double score) {
        return score >= 0.0 && score <= MAX_MIDTERM;
    }

    public static boolean isValidFinal(double score) {
        return score >= 0.0 && score <= MAX_FINAL;
    }

    public static boolean isValidScoreSet(double attendance, double assignment, double midterm, double finalScore) {
        return isValidAttendance(attendance) &&
               isValidAssignment(assignment) &&
               isValidMidterm(midterm) &&
               isValidFinal(finalScore);
    }

    public static double calculateAttendanceScore(int presentCount, int lateCount, int excusedCount, int totalSessions) {
        if (totalSessions <= 0) {
            return MAX_ATTENDANCE;
        }
        double effectivePresent = (double) presentCount + (0.5 * (double) lateCount) + (1.0 * (double) excusedCount);
        double ratio = Math.min(1.0, Math.max(0.0, effectivePresent / (double) totalSessions));
        double rawScore = ratio * MAX_ATTENDANCE;
        return Math.round(rawScore * 100.0) / 100.0;
    }
}
