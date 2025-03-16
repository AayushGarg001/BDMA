-- 'DATABASE CREATION'

-- Creating the Project Database;
CREATE DATABASE IF NOT EXISTS ag_LearningRecDB;

-- Display the Database
SHOW DATABASES;

-- Using the Project Database
USE ag_LearningRecDB;

-- --------------------------------------------------------------------------------------------------------------------

-- 'ADDITION OF TABLES TO THE SCHEMA'

-- Creating the Users Table in the Schema
CREATE TABLE IF NOT EXISTS AG_USERS (
    ag_user_id INT PRIMARY KEY,
    ag_USER_first_name VARCHAR(50) NOT NULL,
    ag_USER_last_name VARCHAR(50),
    ag_USER_email VARCHAR(60) UNIQUE NOT NULL,
    ag_USER_preferences VARCHAR(100),
    ag_USER_signup_date DATE
);

-- Displaying the Users Table
SELECT * FROM AG_USERS;

-- Creating the Categories Table
CREATE TABLE IF NOT EXISTS AG_CATEGORIES (
    AG_CATEGORY_ID INT PRIMARY KEY,
    AG_CATEGORY_name VARCHAR(50) NOT NULL UNIQUE,
    AG_CATEGORY_DESCRIPTION TEXT
);

-- Displaying the Categories Table
SELECT * FROM AG_CATEGORIES;

-- Creating the Courses Table
CREATE TABLE IF NOT EXISTS AG_COURSES (
    AG_COURSE_ID INT PRIMARY KEY,
    AG_COURSE_NAME VARCHAR(255) NOT NULL,
    AG_CATEGORY_ID INT,
    AG_COURSE_RATING DECIMAL(3,2) CHECK (AG_COURSE_RATING BETWEEN 0 AND 5),  
    FOREIGN KEY (AG_CATEGORY_ID) REFERENCES AG_CATEGORIES(AG_CATEGORY_ID) ON DELETE SET NULL
);

-- Displaying the Courses Table
SELECT * FROM AG_COURSES;

-- CREATE TABLE FOR REVIEWS
CREATE TABLE IF NOT EXISTS AG_REVIEWS (
    AG_REVIEW_ID INT PRIMARY KEY,
    AG_USER_ID INT,
    AG_COURSE_ID INT,
    AG_REVIEW_RATING INT CHECK (AG_REVIEW_RATING BETWEEN 1 AND 5),
    AG_REVIEW TEXT,
    FOREIGN KEY (AG_USER_ID) REFERENCES AG_USERS(ag_user_id) ON DELETE CASCADE,
    FOREIGN KEY (AG_COURSE_ID) REFERENCES AG_COURSES(AG_COURSE_ID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS AG_COMPLETION_RECORDS (
    AG_RECORD_ID INT PRIMARY KEY,
    AG_USER_ID INT,
    AG_COURSE_ID INT,
    AG_COMPLETION_DATE DATE,
    AG_PROGRESS_PERCENTAGE DECIMAL(5,2) CHECK (AG_PROGRESS_PERCENTAGE BETWEEN 0 AND 100),
    FOREIGN KEY (AG_USER_ID) REFERENCES AG_USERS(ag_user_id) ON DELETE CASCADE,
    FOREIGN KEY (AG_COURSE_ID) REFERENCES AG_COURSES(AG_COURSE_ID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS AG_COURSE_OUTLINES (
    AG_OUTLINE_ID INT PRIMARY KEY,
    AG_USER_ID INT,
    AG_COURSE_OUTLINE_CONTENT TEXT NOT NULL,
    FOREIGN KEY (AG_USER_ID) REFERENCES AG_USERS(ag_user_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS AG_RECOMMENDATIONS (
    AG_RECOMMENDATION_ID INT PRIMARY KEY,
    AG_USER_ID INT,
    AG_COURSE_ID INT,
    AG_RECOMMENDATION_LOGIC TEXT NOT NULL,
    FOREIGN KEY (AG_USER_ID) REFERENCES AG_USERS(ag_user_id) ON DELETE CASCADE,
    FOREIGN KEY (AG_COURSE_ID) REFERENCES AG_COURSES(AG_COURSE_ID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS AG_OUTLINE_RECOMMENDATIONS (
    AG_RECOMMENDATION_ID INT PRIMARY KEY AUTO_INCREMENT,
    AG_OUTLINE_ID INT,
    AG_COURSE_ID INT,
    AG_MATCH_SCORE DECIMAL(5,2) CHECK (AG_MATCH_SCORE BETWEEN 0 AND 100),  -- match score as a percentage
    FOREIGN KEY (AG_OUTLINE_ID) REFERENCES AG_COURSE_OUTLINES(AG_OUTLINE_ID) ON DELETE CASCADE,
    FOREIGN KEY (AG_COURSE_ID) REFERENCES AG_COURSES(AG_COURSE_ID) ON DELETE CASCADE
);

-- show tables;

-- --------------------------------------------------------------------------------------------------------------------

-- ADDING DUMMY DATA TO TABLES

-- DATA FOR USERS TABLE - 25 ENTRIES

INSERT INTO AG_USERS (ag_user_id, ag_USER_first_name, ag_USER_last_name, ag_USER_email, AG_USER_preferences, AG_USER_signup_date) VALUES
(1, 'Aarav', 'Sharma', 'aarav.sharma@gmail.com', 'Data Science, Machine Learning', '2024-01-10'),
(2, 'Ishita', 'Patel', 'ishita.patel@gmail.com', 'Cloud Computing, Python', '2024-01-12'),
(3, 'Rohan', 'Kumar', 'rohan.kumar@gmail.com', 'AI, JavaScript', '2024-01-05'),
(4, 'Priya', 'Gupta', 'priya.gupta@gmail.com', 'Data Analysis, SQL', '2024-01-03'),
(5, 'Vikram', 'Reddy', 'vikram.reddy@gmail.com', 'Blockchain, Cryptography', '2024-01-08'),
(6, 'Neha', 'Singh', 'neha.singh@gmail.com', 'Web Development, Python', '2024-01-06'),
(7, 'Amit', 'Yadav', 'amit.yadav@gmail.com', 'Digital Marketing, SEO', '2024-01-07'),
(8, 'Sanya', 'Verma', 'sanya.verma@gmail.com', 'Big Data, Python', '2024-01-11'),
(9, 'Karan', 'Bhatia', 'karan.bhatia@gmail.com', 'Full Stack Development, Java', '2024-01-09'),
(10, 'Anjali', 'Desai', 'anjali.desai@gmail.com', 'Mobile App Development, Swift', '2024-01-02'),
(11, 'Yash', 'Mehra', 'yash.mehra@gmail.com', 'Artificial Intelligence, Deep Learning', '2024-01-01'),
(12, 'Reena', 'Patel', 'reena.patel@gmail.com', 'Data Science, R', '2024-01-13'),
(13, 'Aakash', 'Khan', 'aakash.khan@gmail.com', 'Cloud Computing, Networking', '2024-01-14'),
(14, 'Tanya', 'Shukla', 'tanya.shukla@gmail.com', 'DevOps, AWS', '2024-01-04'),
(15, 'Vikrant', 'Singh', 'vikrant.singh@gmail.com', 'Cyber Security, Python', '2024-01-15'),
(16, 'Siddhi', 'Patel', 'siddhi.patel@gmail.com', 'Data Analysis, Machine Learning', '2024-01-17'),
(17, 'Rajesh', 'Yadav', 'rajesh.yadav@gmail.com', 'Digital Marketing, SEM', '2024-01-18'),
(18, 'Shruti', 'Nair', 'shruti.nair@gmail.com', 'Web Development, React', '2024-01-19'),
(19, 'Hritik', 'Verma', 'hritik.verma@gmail.com', 'Python, Data Science', '2024-01-20'),
(20, 'Kavya', 'Chopra', 'kavya.chopra@gmail.com', 'Game Development, Unity', '2024-01-21'),
(21, 'Radhika', 'Joshi', 'radhika.joshi@gmail.com', 'Artificial Intelligence, NLP', '2024-01-22'),
(22, 'Kunal', 'Gupta', 'kunal.gupta@gmail.com', 'Cloud Solutions, DevOps', '2024-01-23'),
(23, 'Ankit', 'Sharma', 'ankit.sharma@gmail.com', 'Blockchain, Smart Contracts', '2024-01-24'),
(24, 'Riya', 'Bansal', 'riya.bansal@gmail.com', 'Data Science, ML Algorithms', '2024-01-25'),
(25, 'Harsh', 'Tiwari', 'harsh.tiwari@gmail.com', 'Full Stack, Angular', '2024-01-26');

-- DISPLAYING THE TABLE
SELECT * FROM AG_USERS;


-- DATA FOR CATEGORIES TABLE
INSERT INTO AG_CATEGORIES (AG_CATEGORY_ID, AG_CATEGORY_name, AG_CATEGORY_DESCRIPTION) VALUES
(1, 'Data Science', 'Courses related to data analysis, machine learning, and data visualization.'),
(2, 'Web Development', 'Courses focused on building and deploying web applications using various frameworks.'),
(3, 'Mobile App Development', 'Courses on creating mobile applications for iOS and Android platforms.'),
(4, 'Cloud Computing', 'Courses about cloud platforms, services, and cloud architecture.'),
(5, 'Artificial Intelligence', 'Courses focusing on AI concepts, algorithms, and applications.'),
(6, 'Digital Marketing', 'Courses on digital marketing strategies, SEO, and social media marketing.'),
(7, 'Blockchain', 'Courses that explore blockchain technology and cryptocurrency.'),
(8, 'Cybersecurity', 'Courses on protecting networks and systems from cyber attacks and security threats.'),
(9, 'Game Development', 'Courses for creating interactive games using various tools and game engines.'),
(10, 'DevOps', 'Courses related to software development and IT operations, focusing on automation and collaboration.'),
(11, 'Business Analytics', 'Courses on data analytics for business decision-making and strategy.'),
(12, 'Database Management', 'Courses on managing, organizing, and analyzing data using database systems.'),
(13, 'UI/UX Design', 'Courses on designing intuitive and user-friendly interfaces and user experiences.'),
(14, 'Software Engineering', 'Courses on software development practices and engineering principles.'),
(15, 'Networking', 'Courses on computer networks, protocols, and communication systems.'),
(16, 'Machine Learning', 'Courses focused on algorithms and techniques for machine learning applications.'),
(17, 'Data Visualization', 'Courses on techniques and tools to visualize complex data and trends.'),
(18, 'Natural Language Processing', 'Courses on developing systems that can understand and process human languages.'),
(19, 'Ethical Hacking', 'Courses that teach ethical hacking practices to find vulnerabilities in systems.'),
(20, 'Cloud Security', 'Courses about securing cloud environments and data.'),
(21, 'Big Data', 'Courses related to handling and analyzing large volumes of data in real-time.'),
(22, 'IoT (Internet of Things)', 'Courses on creating applications and systems for connected devices.'),
(23, 'Python Programming', 'Courses teaching Python programming for various applications, including data science.'),
(24, 'Business Intelligence', 'Courses on analyzing business data for informed decision-making and strategy.'),
(25, 'Agile Methodology', 'Courses on Agile project management and development practices.');

-- DISPLAYING THE TABLE
SELECT * FROM AG_CATEGORIES;

-- DATA FOR COURSES TABLE
INSERT INTO AG_COURSES (AG_COURSE_ID, AG_COURSE_NAME, AG_CATEGORY_ID, AG_COURSE_RATING) VALUES
(1, 'Data Science with Python', 1, 4.5),
(2, 'Web Development Bootcamp', 2, 4.7),
(3, 'Android App Development', 3, 4.2),
(4, 'Introduction to Cloud Computing', 4, 4.6),
(5, 'AI for Beginners', 5, 4.4),
(6, 'Digital Marketing Strategies', 6, 4.3),
(7, 'Blockchain Basics', 7, 4.1),
(8, 'Cybersecurity Fundamentals', 8, 4.8),
(9, 'Game Development with Unity', 9, 4.5),
(10, 'DevOps for Beginners', 10, 4.0),
(11, 'Business Analytics with Excel', 11, 4.7),
(12, 'Database Management Systems', 12, 4.6),
(13, 'UI/UX Design Essentials', 13, 4.3),
(14, 'Software Engineering Principles', 14, 4.6),
(15, 'Computer Networks Basics', 15, 4.2),
(16, 'Machine Learning A-Z', 16, 4.9),
(17, 'Data Visualization with Tableau', 17, 4.7),
(18, 'Natural Language Processing with Python', 18, 4.8),
(19, 'Ethical Hacking from Scratch', 19, 4.4),
(20, 'Cloud Security Essentials', 20, 4.5),
(21, 'Big Data Analytics', 21, 4.3),
(22, 'IoT Development for Beginners', 22, 4.2),
(23, 'Python for Data Science', 23, 4.9),
(24, 'Business Intelligence with Power BI', 24, 4.6),
(25, 'Agile Project Management', 25, 4.1);


-- DATA FOR REVIEWS TABLE
INSERT INTO AG_REVIEWS (AG_REVIEW_ID, AG_USER_ID, AG_COURSE_ID, AG_REVIEW_RATING, AG_REVIEW) VALUES
(1, 1, 1, 5, 'Excellent course on data science. The content was clear and easy to follow.'),
(2, 2, 2, 4, 'Great web development course. The projects were really helpful, but I expected more depth.'),
(3, 3, 3, 3, 'Good course for beginners, but could use more advanced material for experienced developers.'),
(4, 4, 4, 4, 'The cloud computing concepts were well explained, but more real-world examples would be helpful.'),
(5, 5, 5, 5, 'Amazing AI course! The hands-on projects were excellent and really helped in understanding the concepts.'),
(6, 6, 6, 4, 'Very informative digital marketing course. Learned a lot about SEO and social media marketing.'),
(7, 7, 7, 3, 'Blockchain concepts were explained well, but the course lacks practical application examples.'),
(8, 8, 8, 5, 'Fantastic cybersecurity course! It covered a wide range of topics and was very engaging.'),
(9, 9, 9, 4, 'Great game development course. Unity was explained well, but some topics were rushed.'),
(10, 10, 10, 3, 'Decent DevOps course, but it could have more hands-on exercises to practice the tools.'),
(11, 11, 11, 5, 'Amazing business analytics course. The instructor explained complex concepts very clearly using Excel.'),
(12, 12, 12, 4, 'Good overview of database management systems. Would like more focus on SQL and practical examples.'),
(13, 13, 13, 4, 'Great UI/UX design course, although it lacked some information on wireframing tools.'),
(14, 14, 14, 5, 'Excellent software engineering principles course. The approach to problem-solving was very useful.'),
(15, 15, 15, 3, 'The networking basics course was okay, but I expected more detailed information on protocols.'),
(16, 16, 16, 5, 'This machine learning course is one of the best I’ve taken. Very thorough and well-paced.'),
(17, 17, 17, 4, 'The data visualization course was very useful, but the Tableau software tutorial could have been more detailed.'),
(18, 18, 18, 5, 'Loved the NLP course. It was well-structured and gave me a good understanding of text analysis.'),
(19, 19, 19, 4, 'The ethical hacking course was informative, but the hands-on labs were a bit basic.'),
(20, 20, 20, 5, 'Cloud security concepts were explained very well. I feel much more confident in securing cloud environments now.'),
(21, 21, 21, 3, 'Big data analytics course was decent but lacked practical exercises with tools like Hadoop or Spark.'),
(22, 22, 22, 4, 'Good IoT course, though I think it could have more examples of real-world IoT applications.'),
(23, 23, 23, 5, 'Fantastic Python for data science course. It’s helped me a lot with my projects.'),
(24, 24, 24, 4, 'The business intelligence course was great. Power BI is an excellent tool, and the instructor was very clear.'),
(25, 25, 25, 3, 'The Agile project management course was fine, but it could have gone into more detail on Scrum methodology.');

-- DATA FOR COMPLETION_RECORDS

INSERT INTO AG_COMPLETION_RECORDS (AG_RECORD_ID, AG_USER_ID, AG_COURSE_ID, AG_COMPLETION_DATE, AG_PROGRESS_PERCENTAGE) VALUES
(1, 1, 1, '2024-01-15', 100.00),
(2, 2, 2, '2024-01-10', 95.00),
(3, 3, 3, '2024-01-12', 80.00),
(4, 4, 4, '2024-01-05', 100.00),
(5, 5, 5, '2024-01-18', 90.00),
(6, 6, 6, '2024-01-13', 85.00),
(7, 7, 7, '2024-01-09', 75.00),
(8, 8, 8, '2024-01-11', 100.00),
(9, 9, 9, '2024-01-14', 95.00),
(10, 10, 10, '2024-01-07', 50.00),
(11, 11, 11, '2024-01-16', 100.00),
(12, 12, 12, '2024-01-06', 80.00),
(13, 13, 13, '2024-01-17', 90.00),
(14, 14, 14, '2024-01-19', 100.00),
(15, 15, 15, '2024-01-02', 60.00),
(16, 16, 16, '2024-01-20', 100.00),
(17, 17, 17, '2024-01-03', 70.00),
(18, 18, 18, '2024-01-08', 85.00),
(19, 19, 19, '2024-01-04', 90.00),
(20, 20, 20, '2024-01-21', 100.00),
(21, 21, 21, '2024-01-15', 100.00),
(22, 22, 22, '2024-01-09', 50.00),
(23, 23, 23, '2024-01-06', 100.00),
(24, 24, 24, '2024-01-18', 80.00),
(25, 25, 25, '2024-01-05', 60.00);

-- DATA FOR COURSE OUTLINES

INSERT INTO AG_COURSE_OUTLINES (AG_OUTLINE_ID, AG_USER_ID, AG_COURSE_OUTLINE_CONTENT) VALUES
(1, 1, 'Introduction to Data Science, Python for Data Science, Data Wrangling, Machine Learning Algorithms, Data Visualization'),
(2, 2, 'HTML, CSS, JavaScript, Responsive Web Design, Frontend Development, Backend Development, Databases'),
(3, 3, 'Java Basics, Android App Development, Android Studio, Firebase Integration, UI/UX Design for Apps'),
(4, 4, 'Cloud Computing Concepts, AWS, Azure, GCP, Cloud Security, Cloud Storage Solutions, Serverless Architecture'),
(5, 5, 'AI Basics, Neural Networks, Deep Learning, Natural Language Processing, Computer Vision, AI Ethics'),
(6, 6, 'SEO, Social Media Marketing, Google Ads, Content Marketing, Email Marketing, Analytics, Digital Advertising'),
(7, 7, 'Blockchain Basics, Ethereum, Smart Contracts, Cryptocurrency, Decentralized Apps, Security in Blockchain'),
(8, 8, 'Network Security, Ethical Hacking, Penetration Testing, Firewalls, Cryptography, Malware Analysis, Cybersecurity Tools'),
(9, 9, 'Game Development Basics, Unity, C# Programming, Physics Engine, Game Design, 2D and 3D Game Development'),
(10, 10, 'DevOps Concepts, Continuous Integration, Continuous Delivery, Docker, Kubernetes, Jenkins, AWS Lambda'),
(11, 11, 'Excel for Data Analysis, Pivot Tables, Functions and Formulas, Data Visualization in Excel, Excel Macros'),
(12, 12, 'SQL Basics, Database Design, Normalization, Indexing, SQL Queries, Stored Procedures, Transactions'),
(13, 13, 'UI Design, UX Principles, Figma, Adobe XD, Wireframing, Prototyping, User Testing'),
(14, 14, 'Software Development Life Cycle, Agile Methodologies, Scrum, Test-Driven Development, Continuous Integration'),
(15, 15, 'Computer Networks, OSI Model, TCP/IP, Network Protocols, Routers and Switches, Network Configuration'),
(16, 16, 'Supervised Learning, Unsupervised Learning, Decision Trees, Logistic Regression, K-Means Clustering, Neural Networks'),
(17, 17, 'Data Visualization, Tableau Basics, Data Cleaning in Tableau, Creating Dashboards, Advanced Tableau Features'),
(18, 18, 'Text Preprocessing, Sentiment Analysis, Word2Vec, Named Entity Recognition, Text Classification, Text Mining'),
(19, 19, 'Ethical Hacking Basics, Information Gathering, Vulnerability Analysis, Exploitation, Post-Exploitation Techniques'),
(20, 20, 'Cloud Security, Identity and Access Management, Cloud Data Encryption, Disaster Recovery, Cloud Security Compliance'),
(21, 21, 'Big Data Concepts, Hadoop, Spark, MapReduce, Data Lakes, Real-time Data Processing, Machine Learning with Big Data'),
(22, 22, 'IoT Basics, IoT Devices, Sensor Networks, IoT Architecture, Smart Home Automation, Data Collection and Analysis'),
(23, 23, 'Python for Data Science, NumPy, Pandas, Data Analysis, Data Cleaning, Data Visualization, Machine Learning with Python'),
(24, 24, 'Power BI Basics, Data Visualization, Creating Reports, Power BI Dashboards, Data Modeling in Power BI'),
(25, 25, 'Agile Methodologies, Scrum Framework, Product Backlog, Sprint Planning, User Stories, Agile Estimation');


-- DATA FOR RECOMMENDATIONS TABLE

INSERT INTO AG_RECOMMENDATIONS (AG_RECOMMENDATION_ID, AG_USER_ID, AG_COURSE_ID, AG_RECOMMENDATION_LOGIC) VALUES
(1, 1, 1, 'Based on your interest in data science and machine learning, we recommend starting with Python for Data Science and Machine Learning Algorithms.'),
(2, 2, 2, 'Since you have experience in web development, we suggest enhancing your skills with advanced CSS techniques and JavaScript frameworks.'),
(3, 3, 3, 'Given your interest in mobile development, we recommend learning Android App Development with a focus on Firebase integration.'),
(4, 4, 4, 'You are interested in cloud technologies, so we recommend AWS and Azure fundamentals, followed by serverless architecture.'),
(5, 5, 5, 'As you are working on AI-related projects, we recommend diving deeper into Neural Networks and Natural Language Processing.'),
(6, 6, 6, 'For your digital marketing needs, we recommend learning SEO techniques and Google Ads for effective online campaigns.'),
(7, 7, 7, 'Considering your interest in cryptocurrencies, we suggest exploring blockchain basics and smart contract development with Ethereum.'),
(8, 8, 8, 'Since you are looking into cybersecurity, we recommend starting with Ethical Hacking basics and network security protocols.'),
(9, 9, 9, 'You are interested in game development, so we suggest learning Unity game engine and C# programming for creating engaging 2D and 3D games.'),
(10, 10, 10, 'As you’re exploring DevOps, we recommend mastering continuous integration with Jenkins and container orchestration with Kubernetes.'),
(11, 11, 11, 'To enhance your data analysis skills, we recommend learning advanced Excel techniques like pivot tables and macros.'),
(12, 12, 12, 'For improving your database management skills, we suggest diving into SQL queries and database design principles.'),
(13, 13, 13, 'Given your interest in UI/UX, we recommend learning UI design principles and prototyping with Figma and Adobe XD.'),
(14, 14, 14, 'Since you’re new to software development, we suggest starting with agile methodologies and understanding the software development life cycle.'),
(15, 15, 15, 'As you’re interested in networking, we recommend learning about TCP/IP, network protocols, and routers for network configuration.'),
(16, 16, 16, 'Considering your focus on machine learning, we recommend learning supervised and unsupervised learning algorithms like decision trees and K-means clustering.'),
(17, 17, 17, 'For your data visualization needs, we recommend learning Tableau and creating dashboards with advanced features.'),
(18, 18, 18, 'Since you’re exploring NLP, we suggest learning text preprocessing, sentiment analysis, and named entity recognition techniques.'),
(19, 19, 19, 'To enhance your knowledge in ethical hacking, we recommend learning vulnerability analysis and post-exploitation techniques.'),
(20, 20, 20, 'For strengthening your cloud security knowledge, we recommend focusing on cloud data encryption and identity and access management.'),
(21, 21, 21, 'You’re working with large datasets, so we recommend learning Hadoop and Spark for real-time big data processing.'),
(22, 22, 22, 'To explore IoT, we recommend learning about sensor networks, IoT architecture, and building smart home automation systems.'),
(23, 23, 23, 'You’re interested in Python for data science, so we recommend exploring NumPy, Pandas, and machine learning algorithms with Python.'),
(24, 24, 24, 'For your data visualization needs, we recommend learning Power BI basics and creating interactive reports and dashboards.'),
(25, 25, 25, 'Since you’re interested in agile project management, we recommend studying Scrum frameworks and user stories for efficient project execution.');


-- DATA FOR OUTLINE BASED RECOMMENDATIONS TABLE

INSERT INTO AG_OUTLINE_RECOMMENDATIONS (AG_OUTLINE_ID, AG_COURSE_ID, AG_MATCH_SCORE) VALUES
(1, 1, 85.50),
(2, 2, 92.30),
(3, 3, 78.90),
(4, 4, 88.10),
(5, 5, 80.40),
(6, 6, 75.60),
(7, 7, 90.00),
(8, 8, 87.20),
(9, 9, 82.50),
(10, 10, 93.00),
(11, 11, 86.40),
(12, 12, 84.70),
(13, 13, 89.10),
(14, 14, 77.80),
(15, 15, 91.50),
(16, 16, 79.90),
(17, 17, 83.60),
(18, 18, 81.40),
(19, 19, 95.10),
(20, 20, 92.80),
(21, 21, 94.30),
(22, 22, 80.00),
(23, 23, 78.20),
(24, 24, 85.80),
(25, 25, 82.00);

-- --------------------------------------------------------------------------------------------------------------------

