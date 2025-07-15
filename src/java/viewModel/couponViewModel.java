package viewModel;

import bean.coupon;
import service.couponService;
import util.dateFormatter;
import util.numberFormatter;

public class couponViewModel {
    private coupon coupon;
    private couponService couponService;

    public couponViewModel(coupon coupon, couponService couponService) {
        this.coupon = coupon;
        this.couponService = couponService;
    }

    // Delegate to original coupon methods
    public coupon getCoupon() {
        return coupon;
    }

    public int getId() {
        return coupon != null ? coupon.getId() : 0;
    }

    public String getCode() {
        return coupon != null ? coupon.getCode() : "";
    }

    public String getDescription() {
        return coupon != null ? coupon.getDescription() : "";
    }

    public double getDiscountAmount() {
        return coupon != null ? coupon.getDiscountAmount() : 0.0;
    }

    public String getDiscountType() {
        return coupon != null ? coupon.getDiscountType() : "";
    }

    public int getUsageLimit() {
        return coupon != null ? coupon.getUsageLimit() : 0;
    }

    public int getUsedCount() {
        return coupon != null ? coupon.getUsedCount() : 0;
    }

    public boolean isActive() {
        return coupon != null && coupon.isActive();
    }

    // Formatted display methods
    public String getFormattedDiscount() {
        if (coupon == null)
            return "";
        return numberFormatter.formatDiscount(coupon.getDiscountAmount(), coupon.getDiscountType());
    }

    public String getFormattedExpiryDate() {
        if (coupon == null)
            return "";
        return dateFormatter.formatDate(coupon.getExpiryDate());
    }

    public String getFormattedCreatedDate() {
        if (coupon == null)
            return "";
        return dateFormatter.formatDate(coupon.getCreatedAt());
    }

    public String getFormattedExpiryDateForInput() {
        if (coupon == null)
            return "";
        return dateFormatter.formatDateForInput(coupon.getExpiryDate());
    }

    public String getFormattedUsage() {
        if (coupon == null)
            return "";
        return numberFormatter.formatUsage(coupon.getUsedCount(), coupon.getUsageLimit());
    }

    public String getTimeRemainingText() {
        if (coupon == null)
            return "";
        return dateFormatter.getTimeRemainingText(coupon.getExpiryDate());
    }

    public String getTimeRemainingCssClass() {
        if (coupon == null)
            return "";
        return dateFormatter.getTimeRemainingCssClass(coupon.getExpiryDate());
    }

    // Status methods using service
    public boolean isValid() {
        return couponService.isCouponValid(coupon);
    }

    public boolean isExpired() {
        return couponService.isExpired(coupon);
    }

    public boolean isUsageLimitReached() {
        return couponService.isUsageLimitReached(coupon);
    }

    public String getStatusText() {
        return couponService.getCouponStatusText(coupon);
    }

    public String getStatusCssClass() {
        return couponService.getCouponStatusCssClass(coupon);
    }

    public String getStatusBadgeClass() {
        return couponService.getCouponStatusBadgeClass(coupon);
    }

    // Usage percentage and progress bar
    public double getUsagePercentage() {
        return couponService.getUsagePercentage(coupon);
    }

    public String getFormattedUsagePercentage() {
        double percentage = getUsagePercentage();
        return numberFormatter.formatPercentage(percentage, 1);
    }

    public String getProgressBarClass() {
        return couponService.getProgressBarClass(coupon);
    }

    public int getRemainingUsage() {
        return couponService.getRemainingUsage(coupon);
    }

    public String getFormattedRemainingUsage() {
        int remaining = getRemainingUsage();
        if (remaining == Integer.MAX_VALUE)
            return "Unlimited";
        return numberFormatter.formatInteger(remaining);
    }

    // Discount type specific methods
    public boolean isPercentageDiscount() {
        return "PERCENTAGE".equals(getDiscountType());
    }

    public boolean isFixedDiscount() {
        return "FIXED".equals(getDiscountType());
    }

    // Validation messages for forms
    public String getValidationMessage() {
        if (coupon == null)
            return "";

        if (!isValid()) {
            if (!isActive())
                return "This coupon is inactive and cannot be used.";
            if (isExpired())
                return "This coupon has expired.";
            if (isUsageLimitReached())
                return "This coupon has reached its usage limit.";
        }

        return "This coupon is valid and can be used.";
    }

    public String getValidationAlertClass() {
        if (coupon == null)
            return "alert-secondary";
        return isValid() ? "alert-success" : "alert-danger";
    }

    // Helper methods for display
    public String getDiscountTypeDisplayText() {
        if ("PERCENTAGE".equals(getDiscountType())) {
            return "Percentage";
        } else if ("FIXED".equals(getDiscountType())) {
            return "Fixed Amount";
        }
        return "Unknown";
    }

    public String getUsageLimitDisplayText() {
        if (coupon == null)
            return "";
        if (coupon.getUsageLimit() == 0)
            return "Unlimited";
        return numberFormatter.formatInteger(coupon.getUsageLimit()) + " times";
    }

    // Days until expiry
    public long getDaysUntilExpiry() {
        return couponService.getDaysUntilExpiry(coupon);
    }

    // Utility methods for JSP display
    public String escapeHtml(String text) {
        if (text == null)
            return "";
        return text.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#39;");
    }
}