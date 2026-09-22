package com.unitrs.utils;

import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.http.HttpServletRequest;

public class FormatUtils {

    public static String formatIdentifier(String raw) {
        if (raw == null) {
            return "";
        }
        String trimmed = raw.trim();
        if (trimmed.isEmpty() || trimmed.contains("-") || trimmed.contains("@")) {
            return trimmed;
        }

        if (trimmed.matches("^\\d+$")) {
            int length = trimmed.length();
            if (length == 10) {
                return trimmed.substring(0, 3) + "-" + trimmed.substring(3, 6) + "-" + trimmed.substring(6);
            }
            if (length >= 6) {
                List<String> parts = new ArrayList<>();
                int i = 0;
                while (i < length) {
                    int rem = length - i;

                    if (rem <= 4 && parts.size() >= 2) {
                        parts.add(trimmed.substring(i));
                        break;
                    }
                    int take = Math.min(3, rem);
                    parts.add(trimmed.substring(i, i + take));
                    i += take;
                }
                return String.join("-", parts);
            }
        }
        return trimmed;
    }

    public static boolean isMobile(HttpServletRequest request) {
        if (request == null)
            return false;
        String ua = request.getHeader("User-Agent");
        if (ua == null)
            return false;
        ua = ua.toLowerCase();
        return ua.contains("mobile") || ua.contains("android") || ua.contains("iphone")
                || ua.contains("ipod") || ua.contains("blackberry") || ua.contains("iemobile")
                || ua.contains("opera mini") || ua.contains("webos");
    }
}
