package service;

import DAO.couponDAO;
import bean.coupon;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

public class couponService {
    private couponDAO couponDAO;

    public couponService() {
        this.couponDAO = new couponDAO();
    }

    public couponService(couponDAO couponDAO) {
        this.couponDAO = couponDAO;
    }

    // Add test method after constructor
    public void testDatabaseConnection() throws SQLException {
        System.out.println("CouponService: Testing database connection...");
        couponDAO.testDatabaseConnection();
    }

    // Business logic methods
    public List<coupon> getAllCoupons() throws SQLException {
        System.out.println("CouponService: Getting all coupons...");
        List<coupon> coupons = couponDAO.selectAllCoupons();
        System.out.println("CouponService: Retrieved " + (coupons != null ? coupons.size() : 0) + " coupons");
        return coupons;
    }

    public coupon getCouponById(int id) throws SQLException {
        return couponDAO.selectCoupon(id);
    }

    public boolean createCoupon(coupon coupon) throws SQLException {
        validateCoupon(coupon);
        couponDAO.insertCoupon(coupon);
        return true;
    }

    public boolean updateCoupon(coupon coupon) throws SQLException {
        validateCoupon(coupon);
        return couponDAO.updateCoupon(coupon);
    }

    public boolean deleteCoupon(int id) throws SQLException {
        return couponDAO.deleteCoupon(id);
    }

    // Business logic for coupon validation
    public boolean isCouponValid(coupon coupon) {
        if (coupon == null)
            return false;

        // Check if coupon is active
        if (!coupon.isActive())
            return false;

        // Check if coupon is expired
        if (isExpired(coupon))
            return false;

        // Check if usage limit is reached
        if (isUsageLimitReached(coupon))
            return false;

        return true;
    }

    public boolean isExpired(coupon coupon) {
        if (coupon == null || coupon.getExpiryDate() == null)
            return true;
        return coupon.getExpiryDate().before(new Date());
    }

    public boolean isUsageLimitReached(coupon coupon) {
        if (coupon == null)
            return true;
        if (coupon.getUsageLimit() == 0)
            return false; // Unlimited usage
        return coupon.getUsedCount() >= coupon.getUsageLimit();
    }

    public long getDaysUntilExpiry(coupon coupon) {
        if (coupon == null || coupon.getExpiryDate() == null)
            return 0;

        Date now = new Date();
        long diffInMillies = coupon.getExpiryDate().getTime() - now.getTime();
        return diffInMillies / (1000 * 60 * 60 * 24);
    }

    public double getUsagePercentage(coupon coupon) {
        if (coupon == null || coupon.getUsageLimit() == 0)
            return 0.0;
        return (double) coupon.getUsedCount() * 100.0 / coupon.getUsageLimit();
    }

    public int getRemainingUsage(coupon coupon) {
        if (coupon == null)
            return 0;
        if (coupon.getUsageLimit() == 0)
            return Integer.MAX_VALUE; // Unlimited
        return Math.max(0, coupon.getUsageLimit() - coupon.getUsedCount());
    }

    public String getCouponStatusText(coupon coupon) {
        if (coupon == null)
            return "Invalid";

        if (!coupon.isActive())
            return "Inactive";
        if (isExpired(coupon))
            return "Expired";
        if (isUsageLimitReached(coupon))
            return "Usage Limit Reached";
        return "Valid & Active";
    }

    public String getCouponStatusCssClass(coupon coupon) {
        if (coupon == null)
            return "status-invalid";

        if (!coupon.isActive())
            return "status-inactive";
        if (isExpired(coupon))
            return "status-expired";
        if (isUsageLimitReached(coupon))
            return "status-limit";
        return "status-valid";
    }

    public String getCouponStatusBadgeClass(coupon coupon) {
        if (coupon == null)
            return "badge-secondary";

        if (!coupon.isActive())
            return "badge-secondary";
        if (isExpired(coupon))
            return "badge-danger";
        if (isUsageLimitReached(coupon))
            return "badge-warning";
        return "badge-success";
    }

    public String getProgressBarClass(coupon coupon) {
        if (coupon == null)
            return "bg-secondary";

        double percentage = getUsagePercentage(coupon);
        if (percentage >= 100)
            return "bg-danger";
        if (percentage >= 80)
            return "bg-warning";
        return "bg-success";
    }

    // Private validation method
    private void validateCoupon(coupon coupon) throws IllegalArgumentException {
        if (coupon == null) {
            throw new IllegalArgumentException("Coupon cannot be null");
        }

        if (coupon.getCode() == null || coupon.getCode().trim().isEmpty()) {
            throw new IllegalArgumentException("Coupon code is required");
        }

        if (coupon.getDescription() == null || coupon.getDescription().trim().isEmpty()) {
            throw new IllegalArgumentException("Coupon description is required");
        }

        if (coupon.getDiscountAmount() <= 0) {
            throw new IllegalArgumentException("Discount amount must be greater than 0");
        }

        if ("percentage".equalsIgnoreCase(coupon.getDiscountType()) && coupon.getDiscountAmount() > 100) {
            throw new IllegalArgumentException("Percentage discount cannot exceed 100%");
        }

        if (coupon.getExpiryDate() == null) {
            throw new IllegalArgumentException("Expiry date is required");
        }

        if (coupon.getUsageLimit() < 0) {
            throw new IllegalArgumentException("Usage limit cannot be negative");
        }
    }
}