# Student Coupon Management System

A Java EE web application for managing discount coupons with user authentication, built using NetBeans IDE and deployed on GlassFish server.

## 🚀 Features

- **User Authentication**: Registration and login system
- **Coupon Management**: Create, read, update, and delete coupons
- **Dashboard**: User-friendly interface for managing coupons
- **Data Validation**: Form validation and error handling
- **Session Management**: Secure user sessions
- **Responsive Design**: Bootstrap-based modern UI

## 📋 Prerequisites

Before setting up this project, ensure you have the following installed:

- **NetBeans IDE** (version 8.2 or later)
- **Java Development Kit (JDK)** 8 or later
- **GlassFish Server** (version 4.1 or later)
- **Apache Derby Database** (Java DB)
- **Web Browser** (Chrome, Firefox, Safari, or Edge)

## 🗄️ Database Setup

This application uses Apache Derby (Java DB) database. Follow these steps to set up the database:

### 1. Start Derby Database Server

```bash
# Navigate to your Derby installation directory
cd [DERBY_HOME]/bin

# Start the Derby Network Server
startNetworkServer.bat (Windows) or ./startNetworkServer (Linux/Mac)
```

### 2. Create Database

Create a new database named `studentCP`:

```bash
# Connect to Derby using ij tool
cd [DERBY_HOME]/bin
ij

# In the ij prompt:
connect 'jdbc:derby://localhost:1527/studentCP;create=true;user=app;password=app';
```

### 3. Create Database Tables

Execute the following SQL commands to create the required tables:

#### Users Table
```sql
CREATE TABLE users (
    id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    firstname VARCHAR(50) NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    studentId VARCHAR(20) NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);
```

#### Coupons Table
```sql
CREATE TABLE coupons (
    id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    code VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(255) NOT NULL,
    discount_amount DOUBLE NOT NULL,
    discount_type VARCHAR(20) NOT NULL CHECK (discount_type IN ('PERCENTAGE', 'FIXED')),
    expiry_date DATE NOT NULL,
    usage_limit INTEGER NOT NULL DEFAULT 1,
    used_count INTEGER NOT NULL DEFAULT 0,
    is_active BOOLEAN NOT NULL DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);
```

### 4. Insert Sample Data (Optional)

#### Sample Users
```sql
INSERT INTO users (firstname, lastname, email, studentId, username, password) 
VALUES 
    ('John', 'Doe', 'john.doe@student.uitm.edu.my', '2023123456', 'johndoe', 'password123'),
    ('Jane', 'Smith', 'jane.smith@student.uitm.edu.my', '2023123457', 'janesmith', 'password123'),
    ('Admin', 'User', 'admin@uitm.edu.my', '2023000001', 'admin', 'admin123');
```

#### Sample Coupons
```sql
INSERT INTO coupons (code, description, discount_amount, discount_type, expiry_date, usage_limit, used_count, is_active) 
VALUES 
    ('WELCOME10', '10% off for new students', 10.0, 'PERCENTAGE', '2024-12-31', 100, 0, true),
    ('BOOK25', 'RM25 off on textbooks', 25.0, 'FIXED', '2024-12-31', 50, 5, true),
    ('STUDENT15', '15% student discount', 15.0, 'PERCENTAGE', '2024-06-30', 200, 12, true),
    ('CAFE10', 'RM10 off at campus cafe', 10.0, 'FIXED', '2024-12-31', 75, 3, true);
```

### 5. Verify Database Setup

```sql
-- Check if tables are created
SELECT * FROM SYS.SYSTABLES WHERE TABLENAME IN ('USERS', 'COUPONS');

-- Verify sample data
SELECT COUNT(*) FROM users;
SELECT COUNT(*) FROM coupons;
```

## 🛠️ NetBeans Project Setup

### 1. Clone/Import Project

1. Open NetBeans IDE
2. Go to `File` → `Open Project`
3. Navigate to the project directory and select it
4. Click `Open Project`

### 2. Configure Database Connection

1. In NetBeans, go to `Services` tab
2. Right-click on `Databases` → `New Connection`
3. Select `Java DB (Network)` as database driver
4. Configure connection settings:
   - **Host**: `localhost`
   - **Port**: `1527`
   - **Database**: `studentCP`
   - **User**: `app`
   - **Password**: `app`
5. Click `Test Connection` to verify
6. Click `OK` to save

### 3. Configure Server

1. In the `Services` tab, expand `Servers`
2. If GlassFish is not present, right-click `Servers` → `Add Server`
3. Select `GlassFish Server` and specify the installation directory
4. Configure with default settings

### 4. Project Dependencies

The project uses the following dependencies (already configured):

- **Java EE 7 API**
- **Apache Derby JDBC Driver**
- **Bootstrap 5.3.2** (CDN)
- **Bootstrap Icons** (CDN)

### 5. Deploy Database Resources

1. Right-click on the project → `Properties`
2. Go to `Run` category
3. Ensure GlassFish is selected as the server
4. The `glassfish-resources.xml` will automatically configure the database connection pool

## 🚀 Running the Application

### 1. Build the Project

```bash
# In NetBeans
Right-click project → Build
```

### 2. Deploy to Server

```bash
# In NetBeans
Right-click project → Run
```

### 3. Access the Application

Open your web browser and navigate to:
```
http://localhost:8080/studentCP/
```

## 📁 Project Structure

```
studentCP/
├── build.xml                      # Ant build configuration
├── nbproject/                     # NetBeans project files
├── src/java/                      # Java source files
│   ├── bean/                      # Data models (POJOs)
│   │   ├── coupon.java           # Coupon model
│   │   ├── LoginBean.java        # Login model
│   │   └── registerBean.java     # Registration model
│   ├── DAO/                       # Data Access Objects
│   │   ├── couponDAO.java        # Coupon database operations
│   │   ├── LoginDao.java         # Login database operations
│   │   └── registerDao.java      # Registration database operations
│   ├── service/                   # Business logic layer
│   │   └── couponService.java    # Coupon business logic
│   ├── util/                      # Utility classes
│   │   ├── DBConnection.java     # Database connection utility
│   │   ├── dateFormatter.java    # Date formatting utility
│   │   └── numberFormatter.java  # Number formatting utility
│   ├── viewModel/                 # View models for UI
│   │   └── couponViewModel.java  # Coupon view model
│   ├── couponServlet.java        # Coupon controller servlet
│   ├── LoginServlet.java         # Login controller servlet
│   ├── LogoutServlet.java        # Logout controller servlet
│   └── registerServlet.java      # Registration controller servlet
├── web/                           # Web resources
│   ├── WEB-INF/                   # Web application configuration
│   │   ├── web.xml               # Servlet configuration
│   │   ├── glassfish-web.xml     # GlassFish-specific configuration
│   │   └── glassfish-resources.xml # Database resource configuration
│   ├── index.jsp                 # Home page
│   ├── login.jsp                 # Login page
│   ├── register.jsp              # Registration page
│   ├── welcome.jsp               # Welcome dashboard
│   ├── coupon-form.jsp           # Coupon creation/edit form
│   ├── coupon-list.jsp           # Coupon listing page
│   └── coupon-view.jsp           # Coupon details page
└── README.md                      # This file
```

## 🔧 Configuration Details

### Database Configuration

- **JDBC URL**: `jdbc:derby://localhost:1527/studentCP`
- **Driver**: `org.apache.derby.jdbc.ClientDataSource`
- **Connection Pool**: Configured in `glassfish-resources.xml`

### Application URLs

- **Home**: `/studentCP/`
- **Login**: `/studentCP/login.jsp`
- **Register**: `/studentCP/register.jsp`
- **Dashboard**: `/studentCP/welcome.jsp`
- **Coupons**: `/studentCP/CouponServlet`

## 🐛 Troubleshooting

### Common Issues

1. **Database Connection Failed**
   - Ensure Derby server is running
   - Verify database credentials (app/app)
   - Check if database `studentCP` exists

2. **ClassNotFoundException: Derby Driver**
   - Verify Derby JAR files are in the project libraries
   - Check if derby.jar, derbyclient.jar, derbytools.jar are present

3. **404 Page Not Found**
   - Verify GlassFish server is running
   - Check if application is properly deployed
   - Verify servlet mappings in web.xml

4. **Build Errors**
   - Clean and rebuild the project
   - Verify Java EE libraries are properly configured
   - Check for any missing dependencies

### Logs Location

- **GlassFish Logs**: `[GLASSFISH_HOME]/glassfish/domains/domain1/logs/`
- **Application Logs**: Check NetBeans output window

## 📚 Technology Stack

- **Backend**: Java EE (Servlets, JSP)
- **Database**: Apache Derby (Java DB)
- **Server**: GlassFish Application Server
- **Frontend**: HTML5, CSS3, JavaScript, Bootstrap 5
- **IDE**: NetBeans
- **Build Tool**: Apache Ant

## 👥 Usage Guide

### For Students

1. **Registration**: Create a new account with student details
2. **Login**: Access the system with your credentials
3. **Browse Coupons**: View available discount coupons
4. **Apply Coupons**: Use coupon codes for discounts

### For Administrators

1. **Coupon Management**: Create, edit, and delete coupons
2. **User Management**: Monitor user registrations
3. **Analytics**: Track coupon usage and effectiveness

## 📝 License

This project is created for educational purposes as part of the CSC584 Mini Project at UiTM.

## 👨‍💻 Author

**Ikhmal Hanif**  
University Technology MARA (UiTM)  
CSC584 Mini Project

---

For any issues or questions, please contact the development team or refer to the troubleshooting section above. 