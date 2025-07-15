package util;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.Locale;

public class numberFormatter {

    private static final DecimalFormat CURRENCY_FORMAT = new DecimalFormat("$#,##0.00");
    private static final DecimalFormat PERCENTAGE_FORMAT = new DecimalFormat("#,##0.0");
    private static final DecimalFormat INTEGER_FORMAT = new DecimalFormat("#,##0");
    private static final DecimalFormat DECIMAL_FORMAT = new DecimalFormat("#,##0.00");

    /**
     * Format number as currency ($1,234.56)
     */
    public static String formatCurrency(double amount) {
        return CURRENCY_FORMAT.format(amount);
    }

    /**
     * Format number as currency with minimum fraction digits
     */
    public static String formatCurrency(double amount, int minFractionDigits) {
        DecimalFormat df = new DecimalFormat("$#,##0.00");
        df.setMinimumFractionDigits(minFractionDigits);
        return df.format(amount);
    }

    /**
     * Format number as percentage (25.5%)
     */
    public static String formatPercentage(double percentage) {
        return PERCENTAGE_FORMAT.format(percentage) + "%";
    }

    /**
     * Format number as percentage with specified decimal places
     */
    public static String formatPercentage(double percentage, int decimalPlaces) {
        String pattern = "#,##0";
        if (decimalPlaces > 0) {
            pattern += ".";
            for (int i = 0; i < decimalPlaces; i++) {
                pattern += "0";
            }
        }
        DecimalFormat df = new DecimalFormat(pattern);
        return df.format(percentage) + "%";
    }

    /**
     * Format integer with thousands separator (1,234)
     */
    public static String formatInteger(int number) {
        return INTEGER_FORMAT.format(number);
    }

    /**
     * Format long with thousands separator (1,234)
     */
    public static String formatLong(long number) {
        return INTEGER_FORMAT.format(number);
    }

    /**
     * Format decimal number with 2 decimal places (1,234.56)
     */
    public static String formatDecimal(double number) {
        return DECIMAL_FORMAT.format(number);
    }

    /**
     * Format decimal number with specified decimal places
     */
    public static String formatDecimal(double number, int decimalPlaces) {
        String pattern = "#,##0";
        if (decimalPlaces > 0) {
            pattern += ".";
            for (int i = 0; i < decimalPlaces; i++) {
                pattern += "0";
            }
        }
        DecimalFormat df = new DecimalFormat(pattern);
        return df.format(number);
    }

    /**
     * Format number without decimal places if it's a whole number
     */
    public static String formatNumber(double number) {
        if (number == (long) number) {
            return formatLong((long) number);
        } else {
            return formatDecimal(number);
        }
    }

    /**
     * Format usage display (e.g., "5 / 10" or "5 / ∞")
     */
    public static String formatUsage(int used, int limit) {
        if (limit == 0) {
            return formatInteger(used) + " / ∞";
        }
        return formatInteger(used) + " / " + formatInteger(limit);
    }

    /**
     * Format discount display based on type
     */
    public static String formatDiscount(double amount, String type) {
        if ("PERCENTAGE".equals(type)) {
            return formatNumber(amount) + "%";
        } else {
            return formatCurrency(amount);
        }
    }

    /**
     * Check if number is effectively zero
     */
    public static boolean isZero(double number) {
        return Math.abs(number) < 0.001;
    }

    /**
     * Safe parse integer from string
     */
    public static int parseInt(String str, int defaultValue) {
        try {
            return Integer.parseInt(str);
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    /**
     * Safe parse double from string
     */
    public static double parseDouble(String str, double defaultValue) {
        try {
            return Double.parseDouble(str);
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }
}