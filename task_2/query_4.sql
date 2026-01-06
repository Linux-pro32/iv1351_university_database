WITH teacher_period_counts AS (
    SELECT 
        e.employment_id,
        (p.first_name || ' ' || p.last_name) AS teacher_name,
        ci.study_period AS period,
        COUNT(DISTINCT ci.id) AS num_courses
    FROM employee e
    JOIN person p ON e.person_id = p.id
    JOIN employee_planned_activity epa ON epa.employee_id = e.id
    JOIN planned_activity pa ON epa.planned_activity_id = pa.id
    JOIN course_instance ci ON pa.course_instance_id = ci.id
    WHERE ci.study_year = '2025'
    GROUP BY e.employment_id, teacher_name, ci.study_period
)
SELECT 
    employment_id AS "Employment ID",
    teacher_name AS "Teacher's Name",
    period AS "Period",
    num_courses AS "No of courses"
FROM teacher_period_counts
WHERE num_courses > 0
ORDER BY "Period", num_courses DESC;
