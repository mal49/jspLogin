/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bean;

/**
 *
 * @author ikhmalhanif
 */
public class LoginBean implements java.io.Serializable {
    public String username;
    public String password;
    
    public LoginBean(String username, String password) {
        this.username = username;
        this.password = password;
    }
    
    public LoginBean() {}
    
    public String getUsername() {
        return username;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
}
