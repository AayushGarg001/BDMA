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
