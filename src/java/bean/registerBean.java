/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bean;

/**
 *
 * @author ikhma
 */
public class registerBean {
    public int id;
    public String firstname;
    public String lastname;
    public String username;
    public String password;
    public String email;
    public String studentId;
    
    public registerBean(String firstname, String lastname, String username, String password, String email, String studentId){
        this.firstname = firstname;
        this.lastname = lastname;
        this.username = username;
        this.password = password;
        this.email = email;
        this.studentId = studentId;
    }
    
    public registerBean() {}
    
    public int getId() {
        return id;
    }
    
    public String getFirstname() {
        return firstname;
    }
    
    public String getLastname() {
        return lastname;
    }
    
    public String getUsername() {
        return username;
    }
    
    public String getPassword() {
        return password;
    }
    
    public String getEmail() {
        return email;
    }
    
    public String getStudentId() {
        return studentId;
    }
    
    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }
    
    public void setLastname(String lastname) {
        this.lastname = lastname;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }
    
    public void setId(int id) {
        this.id = id;
    }

}
