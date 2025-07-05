/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import bean.registerBean;
import java.sql.*;
import util.DBConnection;

/**
 *
 * @author ikhma
 */
public class registerDao {
    public String registerUser(registerBean registerbean) {
        String username = registerbean.getUsername();
        String firstname = registerbean.getFirstname();
        String lastname = registerbean.getLastname();
        String password = registerbean.getPassword();
        String email = registerbean.getEmail();
        String studentId = registerbean.getStudentId();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet generatedKeys = null;

        try {
            conn = DBConnection.createConnection();

            // Check if username or email already exists
            if (isUserExists(conn, username, email)) {
                return "FAILED - Username or email already exists";
            }

            // Prepare statement to insert new user (ID will be auto-generated)
            // Use RETURN_GENERATED_KEYS to get the auto-generated ID
            pstmt = conn.prepareStatement(
                    "INSERT INTO users (firstname, lastname, email, studentId, username, password) VALUES (?, ?, ?, ?, ?, ?)",
                    Statement.RETURN_GENERATED_KEYS);
            pstmt.setString(1, firstname);
            pstmt.setString(2, lastname);
            pstmt.setString(3, email);
            pstmt.setString(4, studentId);
            pstmt.setString(5, username);
            pstmt.setString(6, password);

            // Execute the prepared statement
            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                // Get the auto-generated ID
                generatedKeys = pstmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    int generatedId = generatedKeys.getInt(1);
                    // Set the generated ID back to the bean (optional)
                    registerbean.setId(generatedId);
                    System.out.println("User registered successfully with ID: " + generatedId);
                }
                return "SUCCESS";
            } else {
                return "FAILED - No rows were inserted";
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return "FAILED - " + e.getMessage();
        } finally {
            // Properly close resources
            try {
                if (generatedKeys != null)
                    generatedKeys.close();
                if (pstmt != null)
                    pstmt.close();
                if (conn != null)
                    conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Helper method to check if user already exists
    private boolean isUserExists(Connection conn, String username, String email) throws SQLException {
        PreparedStatement checkStmt = null;
        ResultSet rs = null;
        try {
            checkStmt = conn.prepareStatement(
                    "SELECT COUNT(*) FROM users WHERE username = ? OR email = ?");
            checkStmt.setString(1, username);
            checkStmt.setString(2, email);
            rs = checkStmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } finally {
            if (rs != null)
                rs.close();
            if (checkStmt != null)
                checkStmt.close();
        }
        return false;
    }
}
