/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package util;
import java.sql.*;

/**
 *
 * @author ikhmalhanif
 */
public class DBConnection {
    public static Connection createConnection() {
        Connection conn = null;
        String url = "jdbc:derby://localhost:1527/studentCP";
        String user = "app";
        String pass = "app";
        try {
            try{
                Class.forName("org.apache.derby.ClientDriver");
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }
            conn = DriverManager.getConnection(url, user, pass);
            System.out.println("Printiting connection object" + conn);
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return conn;
    }
}
