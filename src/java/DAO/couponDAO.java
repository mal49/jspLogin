package DAO;

import bean.coupon;
import util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;

public class couponDAO {

    // SQL queries - ONLY CHANGED NOW() TO CURRENT_TIMESTAMP
    private static final String INSERT_COUPON_SQL = "INSERT INTO coupons (code, description, discount_amount, discount_type, expiry_date, usage_limit, used_count, is_active, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP)";

    private static final String SELECT_COUPON_BY_ID = "SELECT id, code, description, discount_amount, discount_type, expiry_date, usage_limit, used_count, is_active, created_at FROM coupons WHERE id = ?";

    private static final String SELECT_ALL_COUPONS = "SELECT * FROM coupons ORDER BY created_at DESC";

    private static final String DELETE_COUPON_SQL = "DELETE FROM coupons WHERE id = ?";

    private static final String UPDATE_COUPON_SQL = "UPDATE coupons SET code = ?, description = ?, discount_amount = ?, discount_type = ?, expiry_date = ?, usage_limit = ?, is_active = ? WHERE id = ?";

    // Database connection - Use shared utility
    protected Connection getConnection() throws SQLException {
        Connection connection = DBConnection.createConnection();
        if (connection == null) {
            throw new SQLException("Failed to establish database connection");
        }
        System.out.println("CouponDAO: Database connection established successfully");
        return connection;
    }

    // CREATE - Insert coupon
    public void insertCoupon(coupon coupon) throws SQLException {
        System.out.println("DAO: Starting insertCoupon");
        if (coupon == null) {
            throw new IllegalArgumentException("Coupon cannot be null");
        }
        System.out.println("DAO: Coupon is not null, getting connection...");

        try (Connection connection = getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(INSERT_COUPON_SQL)) {

            System.out.println("DAO: Connection obtained, preparing statement...");

            System.out.println("DAO: Setting parameters - Code: " + coupon.getCode() +
                    ", Description: " + coupon.getDescription() +
                    ", DiscountAmount: " + coupon.getDiscountAmount() +
                    ", DiscountType: " + coupon.getDiscountType());

            preparedStatement.setString(1, coupon.getCode());
            preparedStatement.setString(2, coupon.getDescription());
            preparedStatement.setDouble(3, coupon.getDiscountAmount());
            preparedStatement.setString(4, coupon.getDiscountType());

            if (coupon.getExpiryDate() == null) {
                throw new IllegalArgumentException("Expiry date cannot be null");
            }
            preparedStatement.setTimestamp(5, new Timestamp(coupon.getExpiryDate().getTime()));
            preparedStatement.setInt(6, coupon.getUsageLimit());
            preparedStatement.setInt(7, coupon.getUsedCount());
            preparedStatement.setBoolean(8, coupon.isActive());

            System.out.println("DAO: All parameters set, executing update...");

            preparedStatement.executeUpdate();
            System.out.println("DAO: Coupon inserted successfully");
        } catch (SQLException e) {
            System.err.println("DAO: Error inserting coupon: " + e.getMessage());
            printSQLException(e);
            throw e;
        }
    }

    // READ - Select coupon by ID
    public coupon selectCoupon(int id) throws SQLException {
        coupon coupon = null;
        System.out.println("DAO: Selecting coupon with ID: " + id);

        try (Connection connection = getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(SELECT_COUPON_BY_ID)) {

            preparedStatement.setInt(1, id);
            ResultSet rs = preparedStatement.executeQuery();

            if (rs.next()) {
                coupon = mapRowToCoupon(rs);
                System.out.println("DAO: Found coupon: " + coupon.getCode());
            } else {
                System.out.println("DAO: No coupon found with ID: " + id);
            }
        } catch (SQLException e) {
            System.err.println("DAO: Error selecting coupon by ID: " + e.getMessage());
            printSQLException(e);
            throw e;
        }
        return coupon;
    }

    // READ - Select all coupons - FIXED ERROR HANDLING
    public List<coupon> selectAllCoupons() throws SQLException {
        List<coupon> coupons = new ArrayList<>();
        System.out.println("DAO: Starting selectAllCoupons");

        try (Connection connection = getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_COUPONS)) {

            System.out.println("DAO: Executing query: " + SELECT_ALL_COUPONS);
            ResultSet rs = preparedStatement.executeQuery();

            int count = 0;
            while (rs.next()) {
                coupon coupon = mapRowToCoupon(rs);
                coupons.add(coupon);
                count++;
                System.out.println("DAO: Added coupon " + count + ": " + coupon.getCode());
            }

            System.out.println("DAO: Successfully retrieved " + coupons.size() + " coupons from database");
        } catch (SQLException e) {
            System.err.println("DAO: Error selecting all coupons: " + e.getMessage());
            printSQLException(e);
            throw e; // Re-throw the exception instead of silently returning empty list
        }
        return coupons;
    }

    // ADD THIS TEST METHOD AFTER THE selectAllCoupons METHOD
    // Test method to verify database connection and table existence
    public void testDatabaseConnection() throws SQLException {
        System.out.println("=== Testing Database Connection ===");

        try (Connection connection = getConnection()) {
            System.out.println("✓ Database connection successful");

            // Test if coupons table exists
            DatabaseMetaData metaData = connection.getMetaData();
            ResultSet tables = metaData.getTables(null, null, "COUPONS", null);

            if (tables.next()) {
                System.out.println("✓ COUPONS table exists");

                // Count rows in table
                try (PreparedStatement countStmt = connection.prepareStatement("SELECT COUNT(*) FROM coupons");
                        ResultSet countRs = countStmt.executeQuery()) {

                    if (countRs.next()) {
                        int rowCount = countRs.getInt(1);
                        System.out.println("✓ COUPONS table has " + rowCount + " rows");

                        if (rowCount > 0) {
                            // Show first few records (Derby syntax)
                            try (PreparedStatement sampleStmt = connection
                                    .prepareStatement(
                                            "SELECT id, code, description FROM coupons ORDER BY id FETCH FIRST 3 ROWS ONLY");
                                    ResultSet sampleRs = sampleStmt.executeQuery()) {

                                System.out.println("Sample data:");
                                while (sampleRs.next()) {
                                    System.out.println("  ID: " + sampleRs.getInt("id") +
                                            ", Code: " + sampleRs.getString("code") +
                                            ", Description: " + sampleRs.getString("description"));
                                }
                            }
                        }
                    }
                }
            } else {
                System.err.println("✗ COUPONS table does not exist!");

                // List all tables
                ResultSet allTables = metaData.getTables(null, null, "%", null);
                System.out.println("Available tables:");
                while (allTables.next()) {
                    System.out.println("  - " + allTables.getString("TABLE_NAME"));
                }
            }

        } catch (SQLException e) {
            System.err.println("✗ Database connection failed: " + e.getMessage());
            printSQLException(e);
            throw e;
        }

        System.out.println("=== Database Test Complete ===");
    }

    // UPDATE - Update coupon - EXACTLY THE SAME AS YOUR ORIGINAL
    public boolean updateCoupon(coupon coupon) throws SQLException {
        boolean rowUpdated = false;
        try (Connection connection = getConnection();
                PreparedStatement statement = connection.prepareStatement(UPDATE_COUPON_SQL)) {

            statement.setString(1, coupon.getCode());
            statement.setString(2, coupon.getDescription());
            statement.setDouble(3, coupon.getDiscountAmount());
            statement.setString(4, coupon.getDiscountType());
            statement.setTimestamp(5, new Timestamp(coupon.getExpiryDate().getTime()));
            statement.setInt(6, coupon.getUsageLimit());
            statement.setBoolean(7, coupon.isActive());
            statement.setInt(8, coupon.getId());

            rowUpdated = statement.executeUpdate() > 0;
        } catch (SQLException e) {
            printSQLException(e);
            throw e;
        }
        return rowUpdated;
    }

    // DELETE - Delete coupon - EXACTLY THE SAME AS YOUR ORIGINAL
    public boolean deleteCoupon(int id) throws SQLException {
        boolean rowDeleted = false;
        try (Connection connection = getConnection();
                PreparedStatement statement = connection.prepareStatement(DELETE_COUPON_SQL)) {

            statement.setInt(1, id);
            rowDeleted = statement.executeUpdate() > 0;
        } catch (SQLException e) {
            printSQLException(e);
            throw e;
        }
        return rowDeleted;
    }

    // Helper method to map ResultSet to Coupon object - EXACTLY THE SAME AS YOUR
    // ORIGINAL
    private coupon mapRowToCoupon(ResultSet rs) throws SQLException {
        int id = rs.getInt("id");
        String code = rs.getString("code");
        String description = rs.getString("description");
        double discountAmount = rs.getDouble("discount_amount");
        String discountType = rs.getString("discount_type");
        Date expiryDate = new Date(rs.getTimestamp("expiry_date").getTime());
        int usageLimit = rs.getInt("usage_limit");
        int usedCount = rs.getInt("used_count");
        boolean isActive = rs.getBoolean("is_active");
        Date createdAt = new Date(rs.getTimestamp("created_at").getTime());

        coupon coupon = new coupon(code, description, discountAmount, discountType, expiryDate, usageLimit);
        coupon.setId(id);
        coupon.setUsedCount(usedCount);
        coupon.setActive(isActive);
        coupon.setCreatedAt(createdAt);

        return coupon;
    }

    // Utility method to print SQL exceptions - EXACTLY THE SAME AS YOUR ORIGINAL
    private void printSQLException(SQLException ex) {
        for (Throwable e : ex) {
            if (e instanceof SQLException) {
                e.printStackTrace(System.err);
                System.err.println("SQLState: " + ((SQLException) e).getSQLState());
                System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
                System.err.println("Message: " + e.getMessage());
                Throwable t = ex.getCause();
                while (t != null) {
                    System.err.println("Cause: " + t);
                    t = t.getCause();
                }
            }
        }
    }
}