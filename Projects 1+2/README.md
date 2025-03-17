# 🚀 Learning Recommendation System

## Project Overview
This project is a database-driven **Learning Recommendation System** designed to provide personalized course recommendations to users. The system leverages user preferences, past course completions, and user-provided course outlines to generate tailored learning suggestions. The goal is to enhance the online learning experience by recommending the most relevant courses based on individual learning patterns. 

This is a course project under **Prof. Amarnath Mitra** for the subject **Big Data Management and Analytics**.

---

## 🏗️ Database Schema
The system is built using a **relational database model** with well-normalized tables to ensure efficiency and integrity. The key components include:

- **`ag_USERS`** → Maintains user details and preferences.
- **`ag_CATEGORIES`** → Defines course categories for better classification.
- **`ag_COURSES`** → Stores course details and ratings.
- **`ag_REVIEWS`** → Captures user feedback on courses.
- **`ag_COMPLETION_RECORDS`** → Tracks course progress and completion percentages.
- **`ag_COURSE_OUTLINES`** → Allows users to submit course outlines for personalized recommendations.
- **`ag_RECOMMENDATIONS`** → Stores system-generated course recommendations based on user history.
- **`ag_OUTLINE_RECOMMENDATIONS`** → Suggests courses based on course outlines submitted by users.

---

## 📊 Entity-Relationship Diagram (ERD)
A visual representation of the database structure is provided in the **ERD_LRS.pdf** file.

---

## 🔍 Key Functionalities
- **Personalized Learning Pathways** – Users receive tailored course suggestions based on their preferences and past interactions.
- **Course Reviews & Ratings** – Collects user feedback to refine recommendations.
- **Progress Tracking** – Monitors learning engagement and completion trends.
- **Outline-Based Recommendations** – Generates course suggestions based on user-submitted outlines.
- **Data Consistency & Integrity** – Implements foreign key constraints, indexing, and validation checks to maintain data quality.

---

## 🏛️ Database Implementation
### 1️⃣ Prerequisites
- **MySQL** (or a compatible database system)
- **A SQL client** (e.g., MySQL Workbench, DBeaver)
- **Git** (for version control, if needed)

### 2️⃣ Database Setup & Execution
1. **Schema Creation**: Execute `Database_LRS.sql` to set up the database.
2. **Data Population**: Insert sample data using `Dummy_Data.sql` (if applicable).
3. **Validation & Testing**: Run `Stress_Testing.sql` to verify constraints, normalization, and data integrity.

---

## 🔎 Data Integrity & Stress Testing
The system undergoes rigorous stress testing to ensure:
- **Primary Key Enforcement** – No duplicate primary keys exist.
- **Foreign Key Validations** – Ensures referential integrity across tables.
- **Normalization Compliance** – Data follows **1NF, 2NF, and 3NF**.
- **Performance Optimization** – Uses indexing to enhance query efficiency.
- **Data Consistency Checks** – Identifies missing or inconsistent records.

For detailed validation, please take a look at the `Stress_Testing.sql` file.

---

## 📂 Project Structure
```
📦 Online-Learning-Recommendation-System
│── 📜 README.md             # Project Report
│── 📜 Database_LRS.sql      # SQL script for creating tables
│── 📜 Stress_Testing.sql    # SQL queries for validation & testing
│── 📜 ERD_LRS.pdf           # ERD Diagram
```

---

## 🎯 Future Scope
- **API Development** – Extend the database with a REST API for dynamic interaction.
- **Machine Learning Integration** – Implement AI-based recommendation models.
- **User Dashboard** – Develop a front-end interface for user interaction.
- **Advanced Query Optimization** – Further enhance indexing and data retrieval speed.

---

## 📬 Author
👤 **Aayush Garg**
