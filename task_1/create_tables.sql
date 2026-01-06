CREATE TABLE course_layout (
    id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
    course_code VARCHAR(500),
    course_name VARCHAR(500),
    min_students INT,
    max_students INT,
    hp DECIMAL(5),
    PRIMARY KEY (id)
);

CREATE TABLE department (
    manager VARCHAR(500),
    id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
    department_name VARCHAR(500) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE job_title (
    id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
    job_title VARCHAR(500) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE person (
    id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
    personal_number VARCHAR(13) NOT NULL,
    first_name VARCHAR(500),
    last_name VARCHAR(500),
    phone_number VARCHAR(20) NOT NULL,
    address VARCHAR(500),
    PRIMARY KEY (id)
);

CREATE TABLE teaching_activity (
    id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
    activity_name VARCHAR(500),
    factor DECIMAL(5,2),
    PRIMARY KEY (id)
);

CREATE TABLE course_instance (
    id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
    instance_id VARCHAR(500) NOT NULL,
    num_students INT,
    study_period VARCHAR(500),
    study_year VARCHAR(500),
    course_layout_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (course_layout_id) REFERENCES course_layout (id)
);

CREATE TABLE employee (
    id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
    employment_id VARCHAR(500) NOT NULL,
    skill_set VARCHAR(500),
    salary DECIMAL(10),
    manager VARCHAR(500),
    person_id INT NOT NULL,
    job_title_id INT NOT NULL,
    department_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (person_id) REFERENCES person (id),
    FOREIGN KEY (job_title_id) REFERENCES job_title (id),
    FOREIGN KEY (department_id) REFERENCES department (id)
);

CREATE TABLE planned_activity (
    id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
    planned_hours DECIMAL(10,2) NOT NULL,
    course_instance_id INT NOT NULL,
    teaching_activity_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (course_instance_id) REFERENCES course_instance (id),
    FOREIGN KEY (teaching_activity_id) REFERENCES teaching_activity (id)
);

CREATE TABLE employee_planned_activity (
    employee_id INT NOT NULL,
    planned_activity_id INT NOT NULL,
    planned_hours DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (employee_id, planned_activity_id),
    FOREIGN KEY (employee_id) REFERENCES employee (id),
    FOREIGN KEY (planned_activity_id) REFERENCES planned_activity (id)
);