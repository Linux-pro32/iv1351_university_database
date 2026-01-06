INSERT INTO job_title (job_title) VALUES 
('Professor'), ('Associate Professor'), ('Lecturer'), ('PhD Student'), ('Teaching Assistant');

INSERT INTO teaching_activity (activity_name, factor) VALUES 
('Lecture', 3.6), ('Lab', 2.4), ('Tutorial', 2.4), ('Seminar', 1.8), 
('Other Overhead', 1.0), ('Examination', 1.0), ('Administration', 1.0);

INSERT INTO department (department_name, manager) VALUES 
('Computer Science', NULL), ('Mathematics', NULL);

INSERT INTO person (personal_number, first_name, last_name, phone_number, address) VALUES 
('19800101-1234', 'Paris', 'Carbone', '070-1234567', 'Stockholm'),
('19750515-5678', 'Leif', 'Lindbäck', '072-9876543', 'Kista'),
('19901020-9012', 'Niharika', 'Gauraha', '073-5551111', 'Stockholm'),
('19950505-3456', 'Brian', 'Nilsson', '076-2223333', 'Solna'),
('20000101-7890', 'Adam', 'Svensson', '070-4445555', 'Kista'),
('19680404-1111', 'Anna', 'Berg', '08-123456', 'Stockholm');

INSERT INTO employee (employment_id, skill_set, salary, manager, job_title_id, department_id, person_id) VALUES 
('500001', 'Databases, Java', 65000, NULL, 2, 1, 1),
('500002', 'Discrete Math, Algorithms', 55000, 1, 3, 2, 2),
('500003', 'Data Storage, ML', 52000, 1, 3, 1, 3),
('500004', 'Programming, Teaching', 35000, 1, 4, 1, 4),
('500005', 'Assistance, Labs', 25000, 3, 5, 1, 5),
('500006', 'Administration', 70000, NULL, 1, 2, 6);

UPDATE department SET manager = '500001' WHERE department_name = 'Computer Science';  -- Paris Carbone
UPDATE department SET manager = '500006' WHERE department_name = 'Mathematics';     -- Anna Berg

INSERT INTO course_layout (course_code, course_name, hp, min_students, max_students) VALUES 
('IV1351', 'Data Storage Paradigms', 7.5, 50, 250),
('IX1500', 'Discrete Mathematics', 7.5, 50, 150),
('ID2214', 'Programming for Data Science', 7.5, 40, 200),
('IV1350', 'Database Technology', 7.5, 30, 180);

INSERT INTO course_instance (instance_id, num_students, study_year, study_period, course_layout_id) VALUES 
('2025-50273', 200, '2025', 'P2', 1),
('2025-50413', 150, '2025', 'P1', 2),
('2025-50341', 120, '2025', 'P2', 3),
('2025-60104', 80, '2025', 'P3', 4),
('2025-60200', 180, '2025', 'P3', 1);

INSERT INTO planned_activity (planned_hours, course_instance_id, teaching_activity_id) VALUES 
(20, 1, 1), (40, 1, 2), (80, 1, 3), (80, 1, 4), (650, 1, 5),
(44, 2, 1), (64, 2, 4), (200, 2, 5),
(30, 3, 1), (40, 3, 3), (150, 3, 5),
(50, 4, 3), (200, 4, 5),
(22, 5, 1), (35, 5, 2), (70, 5, 3), (600, 5, 5);

INSERT INTO employee_planned_activity (employee_id, planned_activity_id, planned_hours) VALUES 
(1, 1, 276), (2, 1, 226), (3, 1, 268), (4, 1, 150),
(3, 6, 473), (3, 9, 140), (3, 12, 199),
(1, 14, 300), (5, 14, 200), (4, 9, 100);