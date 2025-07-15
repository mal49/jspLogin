package util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class dateFormatter {

    private static final SimpleDateFormat DEFAULT_DATE_FORMAT = new SimpleDateFormat("MMM dd, yyyy");
    private static final SimpleDateFormat INPUT_DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
    private static final SimpleDateFormat FULL_DATE_FORMAT = new SimpleDateFormat("MMM dd, yyyy HH:mm:ss");

    /**
     * Format date using the default format (MMM dd, yyyy)
     */
    public static String formatDate(Date date) {
        if (date == null)
            return "";
        return DEFAULT_DATE_FORMAT.format(date);
    }

    /**
     * Format date using a custom pattern
     */
    public static String formatDate(Date date, String pattern) {
        if (date == null)
            return "";
        SimpleDateFormat sdf = new SimpleDateFormat(pattern);
        return sdf.format(date);
    }

    /**
     * Format date for HTML input type="date" (yyyy-MM-dd)
     */
    public static String formatDateForInput(Date date) {
        if (date == null)
            return "";
        return INPUT_DATE_FORMAT.format(date);
    }

    /**
     * Format date with full timestamp
     */
    public static String formatFullDate(Date date) {
        if (date == null)
            return "";
        return FULL_DATE_FORMAT.format(date);
    }

    /**
     * Parse date from HTML input format (yyyy-MM-dd)
     */
    public static Date parseDateFromInput(String dateString) throws Exception {
        if (dateString == null || dateString.trim().isEmpty())
            return null;
        return INPUT_DATE_FORMAT.parse(dateString);
    }

    /**
     * Get user-friendly time remaining text
     */
    public static String getTimeRemainingText(Date futureDate) {
        if (futureDate == null)
            return "Unknown";

        Date now = new Date();
        long diffInMillies = futureDate.getTime() - now.getTime();
        long days = diffInMillies / (1000 * 60 * 60 * 24);

        if (days < 0)
            return "Already Expired";
        if (days == 0)
            return "Expires Today";
        if (days == 1)
            return "1 day left";
        if (days <= 7)
            return days + " days left";
        if (days <= 30)
            return days + " days left";

        long weeks = days / 7;
        if (weeks == 1)
            return "1 week left";
        if (weeks <= 4)
            return weeks + " weeks left";

        long months = days / 30;
        if (months == 1)
            return "1 month left";
        return months + " months left";
    }

    /**
     * Get CSS class for time remaining status
     */
    public static String getTimeRemainingCssClass(Date futureDate) {
        if (futureDate == null)
            return "text-muted";

        Date now = new Date();
        long diffInMillies = futureDate.getTime() - now.getTime();
        long days = diffInMillies / (1000 * 60 * 60 * 24);

        if (days < 0)
            return "text-danger";
        if (days == 0)
            return "text-danger";
        if (days <= 7)
            return "text-warning";
        return "text-success";
    }
}