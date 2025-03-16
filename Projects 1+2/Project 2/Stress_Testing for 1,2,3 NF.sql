use ag_LearningRecDB;

show tables;

-- Stress Testing Table Wise -- 

/* A. COMPLETION RECORDS */

-- 1. Entire table displayed
select * from ag_completion_records;

-- 2. Check Unique Values for a Specific User (Sanity Check)
select * from ag_completion_records where ag_user_id = 5;

-- 3. Ensure ag_RECORD_ID is Unique (Primary Key Check)
SELECT COUNT(*) AS total_records, COUNT(DISTINCT(ag_record_id)) AS unique_records
FROM ag_completion_records;

-- Since both the values are same, primary key is working correctly

-- 4. Confirm PRIMARY KEY Constraint Exists
SHOW KEYS FROM ag_completion_records WHERE Key_name = 'PRIMARY';

-- 5. Check for Duplicate Entries (User & Course Combinations Should Be Unique)
SELECT ag_user_id, ag_course_id, COUNT(*)
FROM ag_completion_records
GROUP BY ag_user_id, ag_course_id
HAVING COUNT(*) > 1;

-- No output displayed, hence no duplicate records present

-- 6. Check for 1st Normal Form Violations (No Multivalued Attributes)
SELECT ag_user_id FROM ag_completion_records WHERE ag_user_id LIKE '%,%';

-- No comma seperated values, hence 1NF present

-- 7. Find Columns Without Constraints (Potentially Uncontrolled Data)
SELECT column_name
FROM information_schema.columns
WHERE table_name = 'ag_completion_records'
AND column_name NOT IN (
    SELECT column_name FROM information_schema.key_column_usage
    WHERE table_name = 'ag_completion_records'
);

-- This reveals that 2 columns in the table could be vulverable in the future, hence we will refine those fields

-- 7.1. Adding Not null constraint to Completion Records

ALTER TABLE ag_completion_records 
MODIFY ag_COMPLETION_DATE DATE NOT NULL;

-- 7.2. Adding check constraint to completion records since the data needs to be within 0 to 100%

ALTER TABLE ag_completion_records 
ADD CONSTRAINT check_progress 
CHECK (ag_PROGRESS_PERCENTAGE BETWEEN 0 AND 100);

-- 8. Foreign Key constraint check

-- 8.1. 
SELECT scr.* 
FROM ag_completion_records scr
LEFT JOIN ag_users su ON scr.ag_user_id = su.ag_user_id
WHERE su.ag_user_id IS NULL;

-- No Output, hence all ag_user_id values in ag_completion_records exist in ag_users

--  8.2. 

SELECT scr.* 
FROM ag_completion_records scr
LEFT JOIN ag_courses sc ON scr.ag_course_id = sc.ag_course_id
WHERE sc.ag_course_id IS NULL;

-- No Output, hence all ag_course_id values in ag_completion_records exist in ag_courses

-- 9. Check for Orphaned Records

-- 9.1
SELECT * FROM ag_completion_records
WHERE ag_user_id NOT IN (SELECT ag_user_id FROM ag_users);

-- Null output, hence no records exist in ag_completion_records with a ag_user_id that does not exist in ag_users

-- 9.2

SELECT * FROM ag_completion_records
WHERE ag_course_id NOT IN (SELECT ag_course_id FROM ag_courses);

-- Null output, hence no records exist with a ag_course_id that does not exist in ag_courses

-- 10. Check for invalid Dates

SELECT * FROM ag_completion_records 
WHERE ag_COMPLETION_DATE > CURDATE();

-- Null output, hence no invalid dates are present

-- 11. Check for Users with More Than One 100% Completed Course

SELECT ag_user_id, COUNT(*) AS completed_courses 
FROM ag_completion_records 
WHERE ag_PROGRESS_PERCENTAGE = 100
GROUP BY ag_user_id
HAVING completed_courses > 1;

-- 12. Check for Users Who Haven't Completed Any Course (0% Progress)

SELECT * FROM ag_completion_records 
WHERE ag_PROGRESS_PERCENTAGE = 0;

-- 13. Indexing for Faster Queries

CREATE INDEX idx_user_id ON ag_completion_records(ag_user_id);
CREATE INDEX idx_course_id ON ag_completion_records(ag_course_id);

-- ------------------------------------------------------------------------------------

-- B. USERS --

-- 1. Entire table displayed
SELECT * FROM ag_users;

-- 2. Check Unique Values for a Specific User (Sanity Check)
SELECT * FROM ag_users WHERE ag_user_id = 5;

-- 3. Ensure ag_USER_ID is Unique (Primary Key Check)
SELECT COUNT(*) AS total_records, COUNT(DISTINCT(ag_user_id)) AS unique_records
FROM ag_users;

-- Since both values are the same, primary key is working correctly

-- 4. Confirm PRIMARY KEY Constraint Exists
SHOW KEYS FROM ag_users WHERE Key_name = 'PRIMARY';

-- 5. Check for Duplicate Email Addresses (Unique Constraint Check)
SELECT ag_user_email, COUNT(*) 
FROM ag_users 
GROUP BY ag_user_email 
HAVING COUNT(*) > 1;

-- No output displayed, hence no duplicate email records present

-- 6. Check for 1st Normal Form Violations (No Multivalued Attributes)
SELECT ag_user_id FROM ag_users WHERE ag_user_first_name LIKE '%,%' OR ag_user_last_name LIKE '%,%';

-- No comma-separated values, hence 1NF present

-- 7. Find Columns Without Constraints (Potentially Uncontrolled Data)
SELECT column_name
FROM information_schema.columns
WHERE table_name = 'ag_users'
AND column_name NOT IN (
    SELECT column_name FROM information_schema.key_column_usage
    WHERE table_name = 'ag_users'
);

-- This reveals that some columns could be vulnerable, refining constraints as needed

-- 7.1. Adding NOT NULL constraint to crucial fields

ALTER TABLE ag_users 
MODIFY ag_user_first_name VARCHAR(50) NOT NULL,
MODIFY ag_user_email VARCHAR(60) NOT NULL,
MODIFY ag_user_last_name VARCHAR(50) NOT NULL;

-- 7.2. Adding CHECK constraint to enforce valid email format (Only syntactic check)
ALTER TABLE ag_users 
ADD CONSTRAINT check_email_format 
CHECK (ag_user_email LIKE '%_@_%._%');

-- 8. Foreign Key constraint check (If this table references another table)

-- No foreign keys in this table, skipping this step

-- 9. Check for Orphaned Records (Not applicable since this is the primary table)

-- 10. Check for Invalid Dates (Future Signup Dates)
SELECT * FROM ag_users 
WHERE ag_USER_signup_date > CURDATE();

-- Null output, hence no invalid signup dates are present

-- 11. Check for Users with No Preferences Listed
SELECT * FROM ag_users WHERE ag_USER_preferences IS NULL OR ag_USER_preferences = '';

-- 12. Indexing for Faster Queries
CREATE INDEX idx_user_email ON ag_users(ag_user_email);

-- ------------------------------------------------------------------------------------

-- C. CATEGORIES --

-- 1. Entire table displayed
SELECT * FROM ag_categories;

-- 2. Check Unique Values for a Specific Category (Sanity Check)
SELECT * FROM ag_categories WHERE ag_CATEGORY_ID = 5;

-- 3. Ensure ag_CATEGORY_ID is Unique (Primary Key Check)
SELECT COUNT(*) AS total_records, COUNT(DISTINCT(ag_CATEGORY_ID)) AS unique_records
FROM ag_categories;

-- Since both values are the same, primary key is working correctly

-- 4. Confirm PRIMARY KEY Constraint Exists
SHOW KEYS FROM ag_categories WHERE Key_name = 'PRIMARY';

-- 5. Check for Duplicate Category Names (Unique Constraint Check)
SELECT ag_CATEGORY_NAME, COUNT(*) 
FROM ag_categories 
GROUP BY ag_CATEGORY_NAME 
HAVING COUNT(*) > 1;

-- No output displayed, hence no duplicate category names present

-- 6. Check for 1st Normal Form Violations (No Multivalued Attributes)
SELECT ag_CATEGORY_ID FROM ag_categories WHERE ag_CATEGORY_NAME LIKE '%,%';

-- No comma-separated values, hence 1NF present

-- 7. Find Columns Without Constraints (Potentially Uncontrolled Data)
SELECT column_name
FROM information_schema.columns
WHERE table_name = 'ag_categories'
AND column_name NOT IN (
    SELECT column_name FROM information_schema.key_column_usage
    WHERE table_name = 'ag_categories'
);

-- This reveals that some columns could be vulnerable, refining constraints as needed

-- Adding NOT NULL constraint to category distribution

ALTER TABLE ag_categories 
MODIFY ag_CATEGORY_DESCRIPTION VARCHAR(100) NOT NULL;

-- 8. Foreign Key constraint check (If this table references another table)

-- No foreign keys in this table, skipping this step

-- 9. Check for Orphaned Records (Not applicable since this is a primary table)

-- 10. Check for Categories Without Descriptions
SELECT * FROM ag_categories WHERE ag_CATEGORY_DESCRIPTION IS NULL OR ag_CATEGORY_DESCRIPTION = '';

-- 11. Indexing for Faster Queries
CREATE INDEX idx_category_name ON ag_categories(ag_CATEGORY_NAME);

-- ------------------------------------------------------------------------------------

-- C. COURSES --

-- 1. Entire table displayed
SELECT * FROM ag_courses;

-- 2. Check Unique Values for a Specific Course (Sanity Check)
SELECT * FROM ag_courses WHERE ag_COURSE_ID = 5;

-- 3. Ensure ag_COURSE_ID is Unique (Primary Key Check)
SELECT COUNT(*) AS total_records, COUNT(DISTINCT(ag_COURSE_ID)) AS unique_records
FROM ag_courses;

-- Since both values are the same, primary key is working correctly

-- 4. Confirm PRIMARY KEY Constraint Exists
SHOW KEYS FROM ag_courses WHERE Key_name = 'PRIMARY';

-- 5. Check for Duplicate Course Names (Unique Constraint Check)
SELECT ag_COURSE_NAME, COUNT(*) 
FROM ag_courses 
GROUP BY ag_COURSE_NAME 
HAVING COUNT(*) > 1;

-- No output displayed, hence no duplicate course names present

-- 6. Check for 1st Normal Form Violations (No Multivalued Attributes)
SELECT ag_COURSE_ID FROM ag_courses WHERE ag_COURSE_NAME LIKE '%,%';

-- No comma-separated values, hence 1NF present

-- 7. Find Columns Without Constraints (Potentially Uncontrolled Data)
SELECT column_name
FROM information_schema.columns
WHERE table_name = 'ag_courses'
AND column_name NOT IN (
    SELECT column_name FROM information_schema.key_column_usage
    WHERE table_name = 'ag_courses'
);

-- This reveals that some columns could be vulnerable, refining constraints as needed

-- 7.1. Adding NOT NULL constraint 

ALTER TABLE ag_courses 
MODIFY ag_COURSE_NAME VARCHAR(255) NOT NULL,
MODIFY ag_COURSE_RATING VARCHAR(255) NOT NULL;

-- 7.2. Ensuring Course Rating is Within Valid Range (0-5)
ALTER TABLE ag_courses 
ADD CONSTRAINT check_course_rating 
CHECK (ag_COURSE_RATING BETWEEN 0 AND 5);

-- 8. Foreign Key constraint check

-- 8.1. Check for courses with non-existent category IDs
SELECT sc.* 
FROM ag_courses sc
LEFT JOIN ag_categories cat ON sc.ag_CATEGORY_ID = cat.ag_CATEGORY_ID
WHERE cat.ag_CATEGORY_ID IS NULL;

-- No output displayed, hence all category IDs in ag_courses exist in ag_categories

-- 9. Check for Orphaned Records

-- 9.1. Ensure every course has a valid category
SELECT * FROM ag_courses
WHERE ag_CATEGORY_ID NOT IN (SELECT ag_CATEGORY_ID FROM ag_categories);

-- Null output, hence no records exist with an invalid category ID

-- 10. Check for Invalid Ratings (Values Outside Allowed Range)
SELECT * FROM ag_courses 
WHERE ag_COURSE_RATING < 0 OR ag_COURSE_RATING > 5;

-- Null output, hence no invalid ratings present

-- 11. Check for Courses Without Categories (NULL Foreign Key Values)
SELECT * FROM ag_courses WHERE ag_CATEGORY_ID IS NULL;

-- 12. Indexing for Faster Queries
CREATE INDEX idx_course_name ON ag_courses(ag_COURSE_NAME);
CREATE INDEX idx_category_id ON ag_courses(ag_CATEGORY_ID);

-- ------------------------------------------------------------------------------------

-- E. REVIEWS --

-- 1. Entire table displayed
SELECT * FROM ag_reviews;

-- 2. Check Unique Values for a Specific Review (Sanity Check)
SELECT * FROM ag_reviews WHERE ag_REVIEW_ID = 5;

-- 3. Ensure ag_REVIEW_ID is Unique (Primary Key Check)
SELECT COUNT(*) AS total_records, COUNT(DISTINCT(ag_REVIEW_ID)) AS unique_records
FROM ag_reviews;

-- Since both values are the same, primary key is working correctly

-- 4. Confirm PRIMARY KEY Constraint Exists
SHOW KEYS FROM ag_reviews WHERE Key_name = 'PRIMARY';

-- 5. Check for Duplicate Reviews (Unique Constraint Check)
SELECT ag_USER_ID, ag_COURSE_ID, COUNT(*) 
FROM ag_reviews 
GROUP BY ag_USER_ID, ag_COURSE_ID
HAVING COUNT(*) > 1;

-- No output displayed, hence no duplicate user-course reviews present

-- 6. Check for 1st Normal Form Violations (No Multivalued Attributes)
SELECT ag_REVIEW_ID FROM ag_reviews WHERE ag_REVIEW LIKE '%,%';

-- No clear voilation of 1NF, still fixing the problem:

-- 6.1

SELECT ag_REVIEW_ID, ag_REVIEW 
FROM ag_reviews 
WHERE ag_REVIEW REGEXP '[0-9]+/[0-9]+'; 

-- The data is now present in 1NF

-- 7. Find Columns Without Constraints (Potentially Uncontrolled Data)
SELECT column_name
FROM information_schema.columns
WHERE table_name = 'ag_reviews'
AND column_name NOT IN (
    SELECT column_name FROM information_schema.key_column_usage
    WHERE table_name = 'ag_reviews'
);

-- This reveals that some columns could be vulnerable, refining constraints as needed

-- 7.1. Adding NOT NULL constraint to crucial fields

ALTER TABLE ag_reviews 
MODIFY ag_REVIEW TEXT NOT NULL,
MODIFY ag_REVIEW_RATING varchar (2) NOT NULL;

-- 7.2. Ensuring Review Rating is Within Valid Range (1-5)
ALTER TABLE ag_reviews 
ADD CONSTRAINT check_review_rating 
CHECK (ag_REVIEW_RATING BETWEEN 1 AND 5);

-- 8. Foreign Key constraint check

-- 8.1. Check for reviews with non-existent user IDs
SELECT sr.* 
FROM ag_reviews sr
LEFT JOIN ag_users su ON sr.ag_USER_ID = su.ag_USER_ID
WHERE su.ag_USER_ID IS NULL;

-- No output displayed, hence all user IDs in ag_reviews exist in ag_users

-- 8.2. Check for reviews with non-existent course IDs
SELECT sr.* 
FROM ag_reviews sr
LEFT JOIN ag_courses sc ON sr.ag_COURSE_ID = sc.ag_COURSE_ID
WHERE sc.ag_COURSE_ID IS NULL;

-- No output displayed, hence all course IDs in ag_reviews exist in ag_courses

-- 9. Check for Orphaned Records

-- 9.1. Ensure every review has a valid user
SELECT * FROM ag_reviews
WHERE ag_USER_ID NOT IN (SELECT ag_USER_ID FROM ag_users);

-- Null output, hence no records exist with an invalid user ID

-- 9.2. Ensure every review has a valid course
SELECT * FROM ag_reviews
WHERE ag_COURSE_ID NOT IN (SELECT ag_COURSE_ID FROM ag_courses);

-- Null output, hence no records exist with an invalid course ID

-- 10. Check for Invalid Ratings (Values Outside Allowed Range)
SELECT * FROM ag_reviews 
WHERE ag_REVIEW_RATING < 1 OR ag_REVIEW_RATING > 5;

-- Null output, hence no invalid ratings present

-- 11. Check for Reviews Without Any Text
SELECT * FROM ag_reviews WHERE ag_REVIEW IS NULL OR ag_REVIEW = '';

-- 12. Indexing for Faster Queries
CREATE INDEX idx_user_id ON ag_reviews(ag_USER_ID);
CREATE INDEX idx_course_id ON ag_reviews(ag_COURSE_ID);

-- ------------------------------------------------------------------------------------

-- F. COURSE OUTLINES --

-- 1. Entire table displayed
SELECT * FROM ag_course_outlines;

-- 2. Check Unique Values for a Specific Outline (Sanity Check)
SELECT * FROM ag_course_outlines WHERE ag_OUTLINE_ID = 5;

-- 3. Ensure ag_OUTLINE_ID is Unique (Primary Key Check)
SELECT COUNT(*) AS total_records, COUNT(DISTINCT(ag_OUTLINE_ID)) AS unique_records
FROM ag_course_outlines;

-- Since both values are the same, primary key is working correctly

-- 4. Confirm PRIMARY KEY Constraint Exists
SHOW KEYS FROM ag_course_outlines WHERE Key_name = 'PRIMARY';

-- 5. Check for Duplicate Outlines (Unique Constraint Check)
SELECT ag_USER_ID, COUNT(*) 
FROM ag_course_outlines 
GROUP BY ag_USER_ID
HAVING COUNT(*) > 1;

-- No output displayed, hence no duplicate outlines for the same user present

-- 6. Check for 1st Normal Form Violations (No Multivalued Attributes)
SELECT ag_OUTLINE_ID FROM ag_course_outlines WHERE ag_COURSE_OUTLINE_CONTENT LIKE '%,%';

-- Rectifying the output and making it into 1NF

-- 6.1. Check
SELECT ag_OUTLINE_ID, ag_COURSE_OUTLINE_CONTENT 
FROM ag_course_outlines 
WHERE ag_COURSE_OUTLINE_CONTENT LIKE '%,%';

-- Since it is expected output (the outline content is supposed to contain CSV values hence, it is no in 1NF form voilation
-- Hence to not complicate the data further, we did not split it into mupliple columns 

-- 7. Find Columns Without Constraints (Potentially Uncontrolled Data)
SELECT column_name
FROM information_schema.columns
WHERE table_name = 'ag_course_outlines'
AND column_name NOT IN (
    SELECT column_name FROM information_schema.key_column_usage
    WHERE table_name = 'ag_course_outlines'
);

-- This reveals that some columns could be vulnerable, refining constraints as needed

-- 7.1. Adding NOT NULL constraint to crucial fields

ALTER TABLE ag_course_outlines 
MODIFY ag_COURSE_OUTLINE_CONTENT TEXT NOT NULL;

-- 8. Foreign Key constraint check

-- 8.1. Check for outlines with non-existent user IDs
SELECT sco.* 
FROM ag_course_outlines sco
LEFT JOIN ag_users su ON sco.ag_USER_ID = su.ag_USER_ID
WHERE su.ag_USER_ID IS NULL;

-- No output displayed, hence all user IDs in ag_course_outlines exist in ag_users

-- 9. Check for Orphaned Records

SELECT * FROM ag_course_outlines
WHERE ag_USER_ID NOT IN (SELECT ag_USER_ID FROM ag_users);

-- Null output, hence no records exist with an invalid user ID

-- 10. Check for Empty Course Outlines
SELECT * FROM ag_course_outlines WHERE ag_COURSE_OUTLINE_CONTENT IS NULL OR ag_COURSE_OUTLINE_CONTENT = '';

-- 11. Indexing for Faster Queries
CREATE INDEX idx_user_id ON ag_course_outlines(ag_USER_ID);

-- ------------------------------------------------------------------------------------

-- G. RECOMMENDATIONS --

-- 1. Entire table displayed
SELECT * FROM ag_recommendations;

-- 2. Check Unique Values for a Specific Recommendation (Sanity Check)
SELECT * FROM ag_recommendations WHERE ag_RECOMMENDATION_ID = 5;

-- 3. Ensure ag_RECOMMENDATION_ID is Unique (Primary Key Check)
SELECT COUNT(*) AS total_records, COUNT(DISTINCT(ag_RECOMMENDATION_ID)) AS unique_records
FROM ag_recommendations;

-- Since both values are the same, primary key is working correctly

-- 4. Confirm PRIMARY KEY Constraint Exists
SHOW KEYS FROM ag_recommendations WHERE Key_name = 'PRIMARY';

-- 5. Check for Duplicate Recommendations (Unique Constraint Check)
SELECT ag_USER_ID, ag_COURSE_ID, COUNT(*) 
FROM ag_recommendations 
GROUP BY ag_USER_ID, ag_COURSE_ID
HAVING COUNT(*) > 1;

-- No output displayed, hence no duplicate recommendations present

-- 6. Check for 1st Normal Form Violations (No Multivalued Attributes)
SELECT ag_RECOMMENDATION_ID FROM ag_recommendations WHERE ag_RECOMMENDATION_LOGIC LIKE '%,%';

-- Multiple values exist, hence exploring further

-- 6.1. check for voilations

SELECT ag_RECOMMENDATION_ID, ag_RECOMMENDATION_LOGIC 
FROM ag_recommendations 
WHERE ag_RECOMMENDATION_LOGIC LIKE '%,%' AND ag_RECOMMENDATION_LOGIC REGEXP '[0-9]+'; 

-- Only 1 record having values, but since it is text data it is supposed to have this comma value, hence no unexpected voilation of 1NF

-- 7. Find Columns Without Constraints (Potentially Uncontrolled Data)
SELECT column_name
FROM information_schema.columns
WHERE table_name = 'ag_recommendations'
AND column_name NOT IN (
    SELECT column_name FROM information_schema.key_column_usage
    WHERE table_name = 'ag_recommendations'
);

-- This reveals that some columns could be vulnerable, refining constraints as needed

-- 7.1. Adding NOT NULL constraint to crucial fields

ALTER TABLE ag_recommendations 
MODIFY ag_RECOMMENDATION_LOGIC TEXT NOT NULL;

-- 8. Foreign Key constraint check

-- 8.1. Check for recommendations with non-existent user IDs
SELECT sr.* 
FROM ag_recommendations sr
LEFT JOIN ag_users su ON sr.ag_USER_ID = su.ag_USER_ID
WHERE su.ag_USER_ID IS NULL;

-- No output displayed, hence all user IDs in ag_recommendations exist in ag_users

-- 8.2. Check for recommendations with non-existent course IDs
SELECT sr.* 
FROM ag_recommendations sr
LEFT JOIN ag_courses sc ON sr.ag_COURSE_ID = sc.ag_COURSE_ID
WHERE sc.ag_COURSE_ID IS NULL;

-- No output displayed, hence all course IDs in ag_recommendations exist in ag_courses

-- 9. Check for Orphaned Records

-- 9.1. Ensure every recommendation has a valid user
SELECT * FROM ag_recommendations
WHERE ag_USER_ID NOT IN (SELECT ag_USER_ID FROM ag_users);

-- Null output, hence no records exist with an invalid user ID

-- 9.2. Ensure every recommendation has a valid course
SELECT * FROM ag_recommendations
WHERE ag_COURSE_ID NOT IN (SELECT ag_COURSE_ID FROM ag_courses);

-- Null output, hence no records exist with an invalid course ID

-- 10. Check for Empty Recommendation Logic
SELECT * FROM ag_recommendations WHERE ag_RECOMMENDATION_LOGIC IS NULL OR ag_RECOMMENDATION_LOGIC = '';

-- 11. Indexing for Faster Queries
CREATE INDEX idx_user_id ON ag_recommendations(ag_USER_ID);
CREATE INDEX idx_course_id ON ag_recommendations(ag_COURSE_ID);

-- ------------------------------------------------------------------------------------

-- H. OUTLINE-BASED RECOMMENDATIONS --

-- 1. Entire table displayed
SELECT * FROM ag_outline_recommendations;

-- 2. Check Unique Values for a Specific Recommendation (Sanity Check)
SELECT * FROM ag_outline_recommendations WHERE ag_RECOMMENDATION_ID = 5;

-- 3. Ensure ag_RECOMMENDATION_ID is Unique (Primary Key Check)
SELECT COUNT(*) AS total_records, COUNT(DISTINCT(ag_RECOMMENDATION_ID)) AS unique_records
FROM ag_outline_recommendations;

-- Since both values are the same, primary key is working correctly

-- 4. Confirm PRIMARY KEY Constraint Exists
SHOW KEYS FROM ag_outline_recommendations WHERE Key_name = 'PRIMARY';

-- 5. Check for Duplicate Outline Recommendations (Unique Constraint Check)
SELECT ag_OUTLINE_ID, ag_COURSE_ID, COUNT(*) 
FROM ag_outline_recommendations 
GROUP BY ag_OUTLINE_ID, ag_COURSE_ID
HAVING COUNT(*) > 1;

-- No output displayed, hence no duplicate recommendations present

-- 6. Check for 1st Normal Form Violations (No Multivalued Attributes)
SELECT ag_RECOMMENDATION_ID FROM ag_outline_recommendations WHERE ag_MATCH_SCORE LIKE '%,%';

-- No comma-separated values in structured format, hence 1NF present

-- 7. Find Columns Without Constraints (Potentially Uncontrolled Data)
SELECT column_name
FROM information_schema.columns
WHERE table_name = 'ag_outline_recommendations'
AND column_name NOT IN (
    SELECT column_name FROM information_schema.key_column_usage
    WHERE table_name = 'ag_outline_recommendations'
);

-- This reveals that some columns could be vulnerable, refining constraints as needed

-- 7.1. Adding CHECK constraint to enforce valid match score range (0-100)
ALTER TABLE ag_outline_recommendations 
ADD CONSTRAINT check_match_score 
CHECK (ag_MATCH_SCORE BETWEEN 0 AND 100);

-- 8. Foreign Key constraint check

-- 8.1. Check for recommendations with non-existent outline IDs
SELECT sor.* 
FROM ag_outline_recommendations sor
LEFT JOIN ag_course_outlines sco ON sor.ag_OUTLINE_ID = sco.ag_OUTLINE_ID
WHERE sco.ag_OUTLINE_ID IS NULL;

-- No output displayed, hence all outline IDs in ag_outline_recommendations exist in ag_course_outlines

-- 8.2. Check for recommendations with non-existent course IDs
SELECT sor.* 
FROM ag_outline_recommendations sor
LEFT JOIN ag_courses sc ON sor.ag_COURSE_ID = sc.ag_COURSE_ID
WHERE sc.ag_COURSE_ID IS NULL;

-- No output displayed, hence all course IDs in ag_outline_recommendations exist in ag_courses

-- 9. Check for Orphaned Records

-- 9.1. Ensure every recommendation has a valid outline
SELECT * FROM ag_outline_recommendations
WHERE ag_OUTLINE_ID NOT IN (SELECT ag_OUTLINE_ID FROM ag_course_outlines);

-- Null output, hence no records exist with an invalid outline ID

-- 9.2. Ensure every recommendation has a valid course
SELECT * FROM ag_outline_recommendations
WHERE ag_COURSE_ID NOT IN (SELECT ag_COURSE_ID FROM ag_courses);

-- Null output, hence no records exist with an invalid course ID

-- 10. Check for Invalid Match Scores (Values Outside Allowed Range)
SELECT * FROM ag_outline_recommendations 
WHERE ag_MATCH_SCORE < 0 OR ag_MATCH_SCORE > 100;

-- Null output, hence no invalid match scores present

-- 11. Indexing for Faster Queries
CREATE INDEX idx_outline_id ON ag_outline_recommendations(ag_OUTLINE_ID);
CREATE INDEX idx_course_id ON ag_outline_recommendations(ag_COURSE_ID);

-- ---------------------------- End of Document ------------------------------------ --
