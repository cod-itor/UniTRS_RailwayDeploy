# UniTRS - University Management System (UMS)

[![Java 17](https://img.shields.io/badge/Java-17%20LTS-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)](https://www.oracle.com/java/)
[![Jakarta EE 10](https://img.shields.io/badge/Jakarta%20EE-10-F09819?style=for-the-badge&logo=eclipse&logoColor=white)](https://jakarta.ee/)
[![Apache Tomcat 11](https://img.shields.io/badge/Tomcat-11.0.x-F8DC75?style=for-the-badge&logo=apache-tomcat&logoColor=black)](https://tomcat.apache.org/)
[![MySQL 8](https://img.shields.io/badge/MySQL-8.0-4479A1?style=for-the-badge&logo=mysql&logoColor=white)](https://www.mysql.com/)
[![PWA Ready](https://img.shields.io/badge/PWA-Ready-5A0FC8?style=for-the-badge&logo=pwa&logoColor=white)](https://web.dev/progressive-web-apps/)
[![Apache POI](https://img.shields.io/badge/Apache%20POI-5.2.5-D22128?style=for-the-badge)](https://poi.apache.org/)

An enterprise-grade, 4-tier role-based Jakarta EE web application engineered for university administration, academic scheduling, and cohort enrollment, structured around **The University of Cambodia (UC) Academic Model**.

UniTRS manages the full academic lifecycle across students, professors, deans, and administrators: identity-verified registration, term-course bundle enrollment, timetable clash detection, session attendance tracking, continuous 4-component assessment grading, official bilingual attendance Excel export via Apache POI, and mobile-first Progressive Web App (PWA) operation.

---

## Project Information

* **Course:** ITE 204 - Java Enterprise Edition
* **Target Platform:** Jakarta EE 10 / Apache Tomcat 11.0.x
* **Institutional Standard:** The University of Cambodia (UC) Academic Model & Grading Regulations
* **Instructor:** Chum Rasy
* **Authors & Contributors:** Hor Tongan | Dita Rector | Ly Senghuy
* **Repository:** [lysenghuy/ITE204_UniTRS](https://github.com/lysenghuy/ITE204_UniTRS)
* **Primary Branch:** `mobileUI`

---

## System Architecture

UniTRS follows a classic 4-tier enterprise Jakarta EE architecture with separation of concerns:

```
                                  +-----------------------------+
                                  |     Jakarta EE 10 Web       |
                                  |   (Apache Tomcat 11.0.x)    |
                                  +--------------+--------------+
                                                 |
         +--------------------+------------------+------------------+--------------------+
         |                    |                                     |                    |
         v                    v                                     v                    v
  +--------------+    +----------------+                     +--------------+    +---------------+
  |   Student    |    |   Professor    |                     |     Dean     |    |     Admin     |
  |    Portal    |    |     Portal     |                     |    Portal    |    |    Portal     |
  +-------+------+    +-------+--------+                     +-------+------+    +-------+-------+
          |                   |                                      |                   |
          | Term Enrollment   | 4-Component Continuous Grading       | Curriculum        | User Mgmt
          | Timetable Grid    | Attendance Tracker (P/A/L/E)         | Course Bundling   | ID Verification
          | Live Transcripts  | Official UC Excel Sheet Exporter     | Class Scheduling  | Role Provisioning
          | Attendance Rate   | Class QR Generator                   | Shift Allocation  | Dean Assignment
          +-------------------+------------------+-------------------+-------------------+
                                                 |
                                  +--------------v--------------+
                                  |       Controller Tier       |
                                  | (Jakarta Servlets & Filters)|
                                  +--------------+--------------+
                                                 |
                                  +--------------v--------------+
                                  |        Service Tier         |
                                  |  (Business Logic & Rules)   |
                                  +--------------+--------------+
                                                 |
                                  +--------------v--------------+
                                  |     DAO / Repository Tier   |
                                  |  (Raw JDBC, PreparedStmts)  |
                                  +--------------+--------------+
                                                 |
                                  +--------------v--------------+
                                  |       MySQL 8.0 Database    |
                                  |   (Indexes, Views, Schemas) |
                                  +-----------------------------+
```

---

## Features

### 1. Student Portal
* **Identity-Verified Registration:** Self-registration requiring student email, academic school selection, gender for avatar provisioning, and strict University ID formatting (`YY-YY-YY-YY`, e.g., `60-24-04-91`). Accounts enter an administrative verification queue until approved.
* **Term & Course Registration:** View all open course sections offered by the student's assigned school, inspect real-time seat capacities, and enroll in classes with modal confirmation.
* **Weekly Timetable Matrix:**
  * **Interactive Matrix Grid:** View enrolled courses in an organized Monday-through-Sunday timetable grid matching university shifts (**Morning: 08:00 - 11:15**, **Afternoon: 14:00 - 17:15**, **Evening: 17:45 - 20:45**, **Weekend: 08:00 - 16:30**).
  * **Table View:** Alternative linear schedule view detailing term, course, professor, shift, room, and enrollment status.
  * **Day Filtering:** Instant one-click day filtering (All Week, Mon, Tue, Wed, Thu, Fri, Sat, Sun) highlighting relevant slots.
* **Academic Performance & Live Transcript:**
  * Displays continuous assessment grades, total score percentages, letter grades (`A` through `F`), and GPA points (`0.00` to `4.00`).
  * Real-time Term GPA and Cumulative GPA calculation.
  * Progress meter tracking accumulated earned credits toward degree completion.
* **Official Digital Student ID Card:**
  * Displays university credential header, student avatar/headshot, full name, major, school, and academic year.
  * Includes an interactive one-click "Copy Student ID" utility with toast feedback.
  * Official verified student credential status indicator.
* **Account Security & 2FA:** Self-service Two-Factor Authentication (2FA) toggle with email OTP verification.

---

### 2. Professor Portal
* **Teaching Schedule & Class Sections:** Overview of assigned courses, academic terms, room allocations, session shifts, and total enrolled students.
* **Live Session Attendance Tracker:**
  * Record class attendance on a per-session basis by date.
  * Four attendance status options: **Present (P)**, **Absent (A)**, **Late (L)**, and **Excused (E)**.
  * Instant status summary counters for each class session.
* **Official University of Cambodia Attendance Excel Exporter:**
  * Export official `.xlsx` registers formatted to the exact physical paper standard of The University of Cambodia via Apache POI.
  * **Single Section Export:** Generate an attendance register for an individual class section.
  * **Batch Multi-Sheet Export:** Export all assigned classes into a single multi-sheet workbook with sanitised, unique sheet names.
* **Continuous 4-Component Assessment Grading:**
  * Record student marks across four standardized continuous assessment categories:
    $$\text{Total Score} = \text{Attendance (10\%)} + \text{Assignments (20\%)} + \text{Midterm (30\%)} + \text{Final Exam (40\%)} \le 100\%$$
  * Automated server-side calculation of total percentage, letter grade, and GPA points according to university grading policies.
* **Interactive Class QR Code:**
  * Built-in QR code generator in the professor dashboard.
  * Allows instructors to project a QR code on classroom screens for students to scan and quickly access course materials or registration links.

---

### 3. Dean Portal
* **Academic School & College Governance:** Dashboard overview for specific academic schools (e.g., College of Science and Technology, School of Business).
* **Curriculum Management:** Create and maintain courses with official course codes (e.g., `ITE 204`), course titles, and credit allocations.
* **Term-Course Bundling:** Group courses into specific academic terms (`term_courses` bundles) to structure cohort progression.
* **Class Section Scheduling:**
  * Schedule new sections linking course, assigned professor, classroom facility, session shift, days of week, and academic year.
  * Set room capacity limits and monitor student enrollment counts.
* **Faculty Assignment:** Assign professors to specific courses and scheduled class sections.

---

### 4. Administrator Portal
* **Student Verification & Approval Pipeline:**
  * Dedicated queue to review new student registrations.
  * Verifies student ID syntax, name, gender, and school before approving enrollment eligibility.
  * Dispatches automated approval notification emails upon confirmation.
* **User Governance:** Full user provisioning and account management across all roles (`STUDENT`, `PROFESSOR`, `DEAN`, `ADMIN`).
* **Dean School Appointments:** Assign qualified faculty members to lead academic schools and colleges.
* **Security Administration:** Trigger administrative password resets, manage user activation states, and inspect authentication logs.

---

### 5. Security & Authentication
* **Multi-Channel Email OTP Verification:** Powered by [EmailService.java](file:///Users/ditarector/Desktop/ALLOFMYPROJECT/ITE204_UniTRS/src/main/java/com/unitrs/utils/EmailService.java) utilizing the Resend API:
  * **Registration OTP:** Verified email confirmation before account creation.
  * **Login 2FA OTP:** Six-digit one-time password gate for accounts with 2FA enabled.
  * **Password Reset OTP:** Secure verification code for password recovery.
* **Strict Student ID Format Validation:** Regex validation enforcing the university's `YY-YY-YY-YY` standard (e.g., `60-24-04-91`).
* **Cryptographic Password Security:** BCrypt password hashing (work factor 12) via `jBCrypt`.
* **Jakarta Servlet Filters:**
  * [AuthenticationFilter.java](file:///Users/ditarector/Desktop/ALLOFMYPROJECT/ITE204_UniTRS/src/main/java/com/unitrs/filter/AuthenticationFilter.java): Enforces role-based path authorization and redirects unauthenticated requests.
  * [GlobalExceptionFilter.java](file:///Users/ditarector/Desktop/ALLOFMYPROJECT/ITE204_UniTRS/src/main/java/com/unitrs/filter/GlobalExceptionFilter.java): Intercepts uncaught exceptions and routes to standardized error pages.

---

### 6. Official UC Attendance Excel Exporter
Engineered in [AttendanceExcelExporter.java](file:///Users/ditarector/Desktop/ALLOFMYPROJECT/ITE204_UniTRS/src/main/java/com/unitrs/utils/AttendanceExcelExporter.java) using **Apache POI 5.2.5**:

* **Bilingual Institutional Header:** Row 1 with `សាកលវិទ្យាល័យកម្ពុជា` in `Khmer OS Muol Light` (12pt, height 29.45pt); Row 2 with `The University of Cambodia` in `Times New Roman` (11pt bold, height 18pt).
* **Metadata Block:** Structured metadata table for `Room:`, `Instructor:`, `Course Title:`, `Course Code:`, and `Time:` with right-aligned bold labels and left-aligned values.
* **Dynamic Calendar Session Grid:** Calendar months (e.g., `March`, `April`) grouped and merged across session columns, date rows indicating day-of-month, and numbered sessions (`1` through `16+`).
* **Student Record Grid:** Formatted columns for `Nº`, `Name` (in `Times New Roman` 12pt), `Sex` (`M`/`F`), `ID`, session status marks (`P`, `A`, `L`, `E`), and summary totals for **P** (Present), **A** (Absent), **L** (Late), and calculated attendance rate (**%**).
* **Physical Register Sizing:** Minimum 35-row padding with thin gridlines matching official paper rosters.
* **Footer Aggregations:** Summary rows displaying `Total Enrolled: X Students` and gender breakdown (`Male: X   Female: Y`).
* **Print Setup:** Pre-configured for A4 Landscape, `Fit to 1 page wide`, with gridlines enabled for immediate printing.

---

### 7. Progressive Web App (PWA) & Mobile Operation
* **Full PWA Compliance:** Includes [manifest.json](file:///Users/ditarector/Desktop/ALLOFMYPROJECT/ITE204_UniTRS/src/main/webapp/manifest.json), service worker cache ([sw.js](file:///Users/ditarector/Desktop/ALLOFMYPROJECT/ITE204_UniTRS/src/main/webapp/sw.js)), and client lifecycle manager ([pwa.js](file:///Users/ditarector/Desktop/ALLOFMYPROJECT/ITE204_UniTRS/src/main/webapp/static/js/pwa.js)).
* **Home Screen Installation:** Prompts for mobile installation on both iOS Safari and Android Chrome.
* **Offline Fallback:** Standalone [offline.html](file:///Users/ditarector/Desktop/ALLOFMYPROJECT/ITE204_UniTRS/src/main/webapp/offline.html) provides offline status messaging with automatic online reconnection detection.
* **Asset Pipeline:** Multi-resolution icons (`icon-192.png`, `icon-512.png`, `icon-maskable-512.png`, `apple-touch-icon.png`, `favicon.png`).

---

## Grading Scheme (The University of Cambodia Standard)

The grading engine in [GradeCalculator.java](file:///Users/ditarector/Desktop/ALLOFMYPROJECT/ITE204_UniTRS/src/main/java/com/unitrs/utils/GradeCalculator.java) adheres strictly to the University of Cambodia standard:

| Letter Grade | Percentage Range | GPA Points | Academic Standing |
| :---: | :---: | :---: | :--- |
| **A** | 85.0% - 100.0% | **4.00** | Excellent |
| **B+** | 80.0% - 84.9% | **3.50** | Very Good |
| **B** | 70.0% - 79.9% | **3.00** | Good |
| **C+** | 65.0% - 69.9% | **2.50** | Fairly Good |
| **C** | 50.0% - 64.9% | **2.00** | Satisfactory / Pass |
| **D** | 45.0% - 49.9% | **1.50** | Poor |
| **E** | 40.0% - 44.9% | **1.00** | Very Poor / Conditional |
| **F** | 0.0% - 39.9% | **0.00** | Failure |

---

## Default Accounts (Pre-Seeded)

The database includes pre-configured accounts for testing across all four user roles:

| Role | Identifier / Email | Password | Pre-configured Context |
| :--- | :--- | :--- | :--- |
| **Admin** | `admin` | `admin123` | System Administrator / Full Verification Access |
| **Dean** | `dean@unitrs.edu` | `dean123` | Dean of College of Science & Technology (COST) |
| **Professor** | `prof.sok@unitrs.edu` | `prof123` | Assigned to ITE 204, ITE 205 (College of Science & Technology) |
| **Student** | *(Register via UI)* | *(User set)* | Enter ID format `60-24-04-91`, verify OTP, approve in Admin portal |

---

## Database Architecture

The schema in [schema.sql](file:///Users/ditarector/Desktop/ALLOFMYPROJECT/ITE204_UniTRS/src/main/resources/schema.sql) is organized into 10 normalized tables with indexing and views:

```
                      +-------------------+
                      |      schools      |
                      +---------+---------+
                                | 1:N
        +-----------------------+-----------------------+
        |                                               |
+-------v-------+                               +-------v-------+
|     users     |<------------------+           |    courses    |
+-------+-------+                   |           +-------+-------+
        |                           |                   |
        | 1:N                       |                   | 1:N
+-------v-------+           +-------+-------+   +-------v-------+
|  enrollments  |           |class_sections |<--| term_courses  |
+-------+-------+           +-------+-------+   +-------+-------+
        |                           |                   |
        | 1:1                       | 1:N               |
+-------v-------+           +-------v----------+        |
|    grades     |           |attendance_records|        |
+---------------+           +-------+----------+        |
                                    |                   |
                                    | 1:N               |
                            +-------v----------+        |
                            |attendance_entries|        |
                            +------------------+        |
                                                        |
+-------------------+                           +-------v-------+
| otp_verifications |                           |     terms     |
+-------------------+                           +---------------+
```

### Table Definitions:
1. **`schools`**: Academic divisions (College of Science and Technology, School of Business, College of Law, etc.).
2. **`users`**: Unified accounts with `role`, `user_identifier`, `gender`, `is_verified`, `dean_school_id`, `student_school_id`, and `two_factor_enabled`.
3. **`terms`**: Master terms (Term 1 through Term 12).
4. **`courses`**: Course catalog with course codes (`ITE 204`), credit units, and school ownership.
5. **`term_courses`**: Curriculum bundles mapping courses belonging to a specific academic term.
6. **`rooms`**: Physical facilities with floor number and seating capacity.
7. **`class_sections`**: Scheduled classes with term, course, professor, room, shift (`MORNING`, `AFTERNOON`, `EVENING`, `WEEKEND`), days of week, and academic year.
8. **`enrollments`**: Student registrations linking students to class sections.
9. **`attendance_records` & `attendance_entries`**: Daily session attendance headers and per-student status (`PRESENT`, `ABSENT`, `LATE`, `EXCUSED`).
10. **`grades`**: Continuous assessment records per enrollment.
11. **`otp_verifications`**: Ephemeral email OTP codes for registration, 2FA, and password recovery.
12. **`student_schedule_view`**: Optimized SQL view denormalizing enrollments, sections, courses, rooms, and professors for schedule queries.

---

## Technology Stack

| Layer | Technologies |
| :--- | :--- |
| **Language & Platform** | Java 17 LTS (Java 21 compatible), Jakarta EE 10 |
| **Web Container** | Apache Tomcat 11.0.x (with Cargo Maven Plugin embedded runner) |
| **Core APIs** | Jakarta Servlet 6.0, Jakarta JSP 3.1, JSTL 3.0 |
| **Persistence** | Raw JDBC with DAO Pattern, `PreparedStatement`, Connection Pooling |
| **Database** | MySQL 8.0+ / MariaDB |
| **Spreadsheet Engine** | Apache POI 5.2.5 (`poi`, `poi-ooxml`) |
| **Security** | jBCrypt 0.4 (Password Hashing), Email OTP 2FA, Jakarta Servlet Filters |
| **Email Service** | Resend API HTTP Client (`EmailService.java`) |
| **Mobile & PWA** | Web App Manifest, Service Workers, Offline Caching, Touch Icons |
| **Frontend UI** | Bootstrap 5.3, Bootstrap Icons, Sonner Toasts, QR Code Generator (`qrcode.min.js`), Vanilla CSS |
| **Boilerplate Reduction**| Project Lombok 1.18.38 |
| **Testing** | JUnit Jupiter 5.10.2, Surefire Plugin |
| **Build & Deploy** | Maven Wrapper (`mvnw`), Docker Multi-Stage Build, Docker Compose |

---

## Prerequisites & Requirements

Before running the application, ensure the following are installed:

* **Java Development Kit (JDK 17 LTS or JDK 21)**
* **MySQL 8.0+** or **MariaDB**
* **Git**
* (Optional) **Docker & Docker Compose**

Verify Java installation:
```bash
java -version
```

---

## Installation & Running Locally

### 1. Database Setup

#### Step 1: Create Database and User
Log into MySQL and run:
```sql
CREATE DATABASE IF NOT EXISTS unitrs_db;
CREATE USER IF NOT EXISTS 'ums_user'@'localhost' IDENTIFIED BY 'ums_pass123';
GRANT ALL PRIVILEGES ON unitrs_db.* TO 'ums_user'@'localhost';
FLUSH PRIVILEGES;
```

#### Step 2: Import Schema & Seed Data
Execute the schema script to create all tables, views, and seed accounts:

* **macOS / Linux:**
  ```bash
  mysql -u ums_user -pums_pass123 unitrs_db < src/main/resources/schema.sql
  ```
* **Windows (Command Prompt):**
  ```cmd
  mysql -u ums_user -pums_pass123 unitrs_db < src\main\resources\schema.sql
  ```

#### Step 3: Database Credentials Configuration
UniTRS uses [CredentialsLoader.java](file:///Users/ditarector/Desktop/ALLOFMYPROJECT/ITE204_UniTRS/src/main/java/com/unitrs/utils/CredentialsLoader.java) to detect database credentials from:
1. Environment variables (`MYSQLHOST`, `MYSQLPORT`, `MYSQLUSER`, `MYSQLPASSWORD`, `MYSQLDATABASE`, `MYSQL_URL`, or `DB_URL`)
2. Local override file: `src/main/resources/db.local.properties`
3. Default configuration: `src/main/resources/db.properties`

To use custom local credentials without modifying tracked files, create `src/main/resources/db.local.properties`:
```properties
db.url=jdbc:mysql://localhost:3306/unitrs_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC
db.user=your_username
db.password=your_password
```

---

### 2. Run Locally with Embedded Tomcat (Cargo)

The fastest way to run the application in development is using the Cargo Maven plugin:

* **macOS / Linux:**
  ```bash
  ./mvnw cargo:run
  ```
* **Windows:**
  ```cmd
  .\mvnw.cmd cargo:run
  ```

Once Tomcat starts, open your browser and navigate to:
```
http://localhost:8080/ums
```

---

### 3. Alternative: Run via Docker Compose

Launches both MySQL 8 and UniTRS in connected containers:
```bash
docker compose up --build
```
Access the application at:
```
http://localhost:8080/
```

---

### 4. Alternative: Deploy to Standalone Apache Tomcat 11

1. Build the production WAR package:
   ```bash
   ./mvnw clean package
   ```
2. Copy `target/ums.war` to your Tomcat installation's `webapps/` directory.
3. Start Tomcat:
   * **macOS / Linux:** `./bin/catalina.sh run`
   * **Windows:** `.\bin\catalina.bat run`
4. Access at `http://localhost:8080/ums`.

---

## Running Unit Tests

Execute the automated test suite with Maven:
```bash
./mvnw test
```

The test suite validates:
* **`GradeCalculatorTest`**: 4-component assessment math, percentage boundaries, letter grade classifications (`A` through `F`), and GPA point mappings.
* **`ScheduleUtilsTest`**: Day and shift clash resolution between enrolled class sections.
* **`OtpServiceTest`**: OTP generation, expiration tracking, and multi-channel verification logic.

---

## Directory Structure

```
ITE204_UniTRS/
├── Dockerfile                                 # Multi-stage Docker production build
├── docker-compose.yml                         # Containerized web and database setup
├── pom.xml                                    # Maven dependencies & build configuration
├── README.md                                  # System documentation
├── src/
│   ├── main/
│   │   ├── java/com/unitrs/
│   │   │   ├── controller/                    # Jakarta Servlet Request Handlers
│   │   │   │   ├── AdminController.java       # User administration & verification
│   │   │   │   ├── AuthController.java        # Authentication, 2FA, OTP & reset
│   │   │   │   ├── DeanController.java        # Curriculum, bundling & scheduling
│   │   │   │   ├── ProfessorController.java   # Teaching, attendance & grading
│   │   │   │   ├── StudentController.java     # Enrollment, timetable & transcript
│   │   │   │   └── ValidationController.java  # Real-time duplicate & format checks
│   │   │   ├── filter/
│   │   │   │   ├── AuthenticationFilter.java  # Role-based access enforcement
│   │   │   │   └── GlobalExceptionFilter.java # Uniform error handling
│   │   │   ├── model/
│   │   │   │   └── entity/                    # Domain Entities & Enums
│   │   │   ├── repository/                    # JDBC DAO Layer (PreparedStatements)
│   │   │   ├── service/                       # Business Logic Layer
│   │   │   └── utils/
│   │   │       ├── AttendanceExcelExporter.java # UC Attendance Register Exporter
│   │   │       ├── CredentialsLoader.java     # Multi-environment config resolver
│   │   │       ├── DatabaseUtils.java         # Connection management
│   │   │       ├── EmailService.java          # Resend API integration
│   │   │       ├── GradeCalculator.java       # UC letter & GPA calculator
│   │   │       └── ScheduleUtils.java         # Timetable conflict detector
│   │   ├── resources/
│   │   │   ├── db.properties                  # Production database credentials
│   │   │   └── schema.sql                     # Complete DDL, indexes, views, seed data
│   │   └── webapp/
│   │       ├── manifest.json                  # Web App Manifest
│   │       ├── sw.js                          # Service Worker for PWA & caching
│   │       ├── offline.html                   # Offline fallback UI
│   │       ├── static/
│   │       │   ├── css/                       # Stylesheets (auth, sonner, custom)
│   │       │   ├── icons/                     # PWA maskable icons & touch assets
│   │       │   ├── images/                    # 3D avatars & fallbacks
│   │       │   └── js/                        # Client logic, PWA, Sonner, QRCode
│   │       └── WEB-INF/
│   │           ├── web.xml                    # Deployment descriptor & error pages
│   │           └── views/                     # Role-based JSP Views (JSTL 3.0)
│   └── test/
│       └── java/com/unitrs/                   # Automated unit test suite
```

---

## Code Quality Standards

* **Zero Comment Policy:** All Java source files across `src/main/java` strictly adhere to self-documenting code principles with zero in-source comments, validated via automated scanning.
* **SQL Injection Prevention:** All database queries utilize parameterized `PreparedStatement` instances.
* **Defensive Error Handling:** Comprehensive null checks and fallback handling for missing schedules, null dates, and empty rosters across exporters and controllers.

---

## License & Academic Notice

Developed as an academic project for **ITE 204 - Java Enterprise Edition** under the guidance of **Instructor Chum Rasy**. Academic references to The University of Cambodia structures and standards are utilized for educational demonstration and administrative modeling purposes.