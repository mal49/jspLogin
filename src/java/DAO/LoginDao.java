/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;


import bean.LoginBean;
import java.sql.*;
import util.DBConnection;

/**
 *
 * @author ikhmalhanif
 */
public class LoginDao {
    public String authentication(LoginBean loginbean) {
        String username = loginbean.getUsername();
        String password = loginbean.getPassword();
        
        Connection conn = null;
        Statement statement = null;
        ResultSet resultset = null;
        String usernameDB = "";
        String passwordDB = "";
        
        try {
            conn = DBConnection.createConnection();
            statement = conn.createStatement();
            resultset = statement.executeQuery("SELECT username, password FROM users");
            while (resultset.next()) {
                usernameDB = resultset.getString("username");
                passwordDB = resultset.getString("password");
                if (username.equals(usernameDB) && password.equals(passwordDB)) {
                    return "SUCCESS";
                }
            }
        } catch (SQLException e){
            e.printStackTrace();
        }
        
        return "Invalid user credentials";
    }
}
