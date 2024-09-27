-- online platform
CREATE DATABASE online_platform;
USE online_platform;
CREATE TABLE Students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE Teachers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE Subjects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    description TEXT
);
CREATE TABLE Teacher_Subjects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    teacher_id INT,
    subject_id INT,
    FOREIGN KEY (teacher_id) REFERENCES Teachers(id) ON DELETE CASCADE,
    FOREIGN KEY (subject_id) REFERENCES Subjects(id) ON DELETE CASCADE
);
CREATE TABLE Reviews (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    teacher_id INT,
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
    review_text TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES Students(id) ON DELETE CASCADE, 
    FOREIGN KEY (teacher_id) REFERENCES Teachers(id) ON DELETE CASCADE 
);


INSERT INTO Students (name, email, password) 
VALUES ('Moyze Ahmad', 'moyze@example.com', 'password123'),
('Bilal Khalid', 'bilal@example.com', 'password456'),
('Huzaifa Sohail', 'huzaifa@example.com', 'password789');
select * from students; 

INSERT INTO Teachers (name, email, password) 
VALUES ('Younis Ali', 'younis@example.com', 'teacher123'),
('Farhan Ahmad', 'farhan@example.com', 'teacher456'),
('Shafiq Rehman', 'shafiq@example.com', 'teacher789');
select * from Teachers; 

INSERT INTO Subjects (name, description) 
VALUES ('Mathematics', 'The study of numbers, shapes, and patterns.'),
('Physics', 'The study of matter, energy, and the fundamental forces of nature.'),
('Chemistry', 'The study of substances, their properties, and reactions.'),
('Biology', 'The study of living organisms, their structure, function, growth, and evolution.'),
('Computer Science', 'The study of computers and computational systems.'),
('History', 'The study of past events, particularly in human affairs.'),
('English Literature', 'The study of literature written in the English language, including prose and poetry.');
    
select * from Subjects;

INSERT INTO Teacher_Subjects (teacher_id, subject_id) 
VALUES (1, 1),
(1, 2), 
(2, 3), 
(3, 1), 
(3, 2); 
select * from Teacher_Subjects;

INSERT INTO Reviews (student_id, teacher_id, rating, review_text) 
VALUES(1, 1, 5, 'Excellent teacher! Very knowledgeable and helpful.'), 
(2, 2, 4, 'Good explanations, but could improve on clarity.'), 
(3, 3, 3, 'Average teaching style, could be more engaging.'); 

select * from Reviews;

INSERT INTO Reviews (student_id, teacher_id, rating, review_text) 
VALUES
    (1, 1, 4, 'Great teaching methods, but sometimes moves too fast.'),
    (1, 2, 5, 'Fantastic! Very engaging and supportive.'),
    (2, 1, 3, 'Content is good, but delivery can be improved.'),
    (2, 3, 5, 'Incredible teacher! Makes complex topics easy to understand.'),
    (3, 2, 2, 'Not very interactive; more discussions would help.'),
    (3, 3, 4, 'Very clear explanations, but could include more examples.'),
    (1, 3, 5, 'Best teacher ever! Really cares about students.'),
    (2, 1, 4, 'Solid explanations, and helpful feedback.'),
    (3, 2, 3, 'Average, but can improve with more enthusiasm.');
    
select * from Reviews;

SELECT 
    Teachers.name AS teacher_name, 
	Subjects.name AS subject_name, 
    Reviews.rating AS teacher_rating,
    Reviews.review_text AS review
FROM 
    Teachers
JOIN 
    Teacher_Subjects ON Teachers.id = Teacher_Subjects.teacher_id
JOIN 
    Subjects ON Teacher_Subjects.subject_id = Subjects.id
LEFT JOIN 
    Reviews ON Teachers.id = Reviews.teacher_id
ORDER BY 
    Teachers.name ASC, 
    Reviews.rating DESC;

SELECT 
    Teachers.name AS teacher_name, 
    COUNT(Teacher_Subjects.subject_id) AS subject_count
FROM 
    Teachers 
JOIN 
    Teacher_Subjects ON Teachers.id = Teacher_Subjects.teacher_id
GROUP BY 
    Teachers.id, Teachers.name;
    
SELECT 
    Subjects.name AS subject_name,
    Teachers.name AS teacher_name,
    AVG(Reviews.rating) AS average_rating
FROM 
    Subjects
JOIN 
    Teacher_Subjects ON Subjects.id = Teacher_Subjects.subject_id
JOIN 
    Teachers ON Teacher_Subjects.teacher_id = Teachers.id
LEFT JOIN 
    Reviews ON Teachers.id = Reviews.teacher_id
GROUP BY 
    Subjects.name, Teachers.name;






