package com.unitrs.model.entity;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class School {
    private int id;
    private String schoolName;

    public String getSchoolCode() {
        if (schoolName == null || schoolName.trim().isEmpty()) {
            return "UNIV";
        }
        if (schoolName.contains("Science and Tech")) return "COST";
        if (schoolName.contains("Business")) return "SOB";
        if (schoolName.contains("Law")) return "COL";
        if (schoolName.contains("Media")) return "CMC";
        if (schoolName.contains("Arts and Human")) return "CAH";
        if (schoolName.contains("Education")) return "COE";
        if (schoolName.contains("Social")) return "CSS";
        if (schoolName.contains("Foreign")) return "SFL";
        if (schoolName.contains("Creative")) return "SCA";
        if (schoolName.contains("Undergraduate")) return "SUS";
        if (schoolName.contains("Graduate")) return "SGS";
        if (schoolName.contains("Government")) return "TSS";

        String[] words = schoolName.trim().split("\\s+");
        StringBuilder sb = new StringBuilder();
        for (String w : words) {
            if (!w.equalsIgnoreCase("of") && !w.equalsIgnoreCase("and") && !w.equalsIgnoreCase("the") && !w.isEmpty()) {
                sb.append(Character.toUpperCase(w.charAt(0)));
            }
        }
        return sb.length() > 0 ? sb.toString() : "DEPT";
    }
}
