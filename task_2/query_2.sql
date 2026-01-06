WITH target_instance AS (
    SELECT ci.id AS ci_id, ci.instance_id, cl.course_code, cl.hp
    FROM course_instance ci
    JOIN course_layout cl ON ci.course_layout_id = cl.id
    WHERE ci.instance_id = '2025-50273'
)
SELECT 
    ti.course_code AS "Course Code",
    ti.instance_id AS "Course Instance ID",
    ti.hp AS HP,
    (p.first_name || ' ' || p.last_name) AS "Teacher's Name",
    jt.job_title AS Designation,
    COALESCE(SUM(CASE WHEN LOWER(ta.activity_name) = 'lecture' THEN epa.planned_hours ELSE 0 END), 0) AS "Lecture Hours",
    COALESCE(SUM(CASE WHEN LOWER(ta.activity_name) = 'tutorial' THEN epa.planned_hours ELSE 0 END), 0) AS "Tutorial Hours",
    COALESCE(SUM(CASE WHEN LOWER(ta.activity_name) = 'lab' THEN epa.planned_hours ELSE 0 END), 0) AS "Lab Hours",
    COALESCE(SUM(CASE WHEN LOWER(ta.activity_name) = 'seminar' THEN epa.planned_hours ELSE 0 END), 0) AS "Seminar Hours",
    COALESCE(SUM(CASE WHEN LOWER(ta.activity_name) LIKE '%other%' THEN epa.planned_hours ELSE 0 END), 0) AS "Other Overhead Hours",
    COALESCE(SUM(CASE WHEN LOWER(ta.activity_name) = 'administration' THEN epa.planned_hours ELSE 0 END), 0) AS "Admin",
    COALESCE(SUM(CASE WHEN LOWER(ta.activity_name) = 'examination' THEN epa.planned_hours ELSE 0 END), 0) AS "Exam",
    ROUND(SUM(epa.planned_hours * COALESCE(ta.factor, 1.0)), 2) AS "Total"
FROM target_instance ti
JOIN planned_activity pa ON pa.course_instance_id = ti.ci_id
JOIN employee_planned_activity epa ON epa.planned_activity_id = pa.id
JOIN employee e ON epa.employee_id = e.id
JOIN person p ON e.person_id = p.id
JOIN job_title jt ON e.job_title_id = jt.id
LEFT JOIN teaching_activity ta ON pa.teaching_activity_id = ta.id
GROUP BY ti.course_code, ti.instance_id, ti.hp, p.first_name, p.last_name, jt.job_title
ORDER BY "Total" DESC;