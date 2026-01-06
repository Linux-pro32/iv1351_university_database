SELECT 
    cl.course_code AS "Course Code",
    ci.instance_id AS "Course Instance ID",
    cl.hp AS HP,
    ci.study_period AS Period,
    (p.first_name || ' ' || p.last_name) AS "Teacher's Name",
    COALESCE(SUM(CASE WHEN LOWER(ta.activity_name) = 'lecture' THEN epa.planned_hours ELSE 0 END), 0) AS "Lecture Hours",
    COALESCE(SUM(CASE WHEN LOWER(ta.activity_name) = 'tutorial' THEN epa.planned_hours ELSE 0 END), 0) AS "Tutorial Hours",
    COALESCE(SUM(CASE WHEN LOWER(ta.activity_name) = 'lab' THEN epa.planned_hours ELSE 0 END), 0) AS "Lab Hours",
    COALESCE(SUM(CASE WHEN LOWER(ta.activity_name) = 'seminar' THEN epa.planned_hours ELSE 0 END), 0) AS "Seminar Hours",
    COALESCE(SUM(CASE WHEN LOWER(ta.activity_name) LIKE '%other%' THEN epa.planned_hours ELSE 0 END), 0) AS "Other Overhead Hours",
    COALESCE(SUM(CASE WHEN LOWER(ta.activity_name) = 'administration' THEN epa.planned_hours ELSE 0 END), 0) AS "Admin",
    COALESCE(SUM(CASE WHEN LOWER(ta.activity_name) = 'examination' THEN epa.planned_hours ELSE 0 END), 0) AS "Exam",
    ROUND(SUM(epa.planned_hours * COALESCE(ta.factor, 1.0)), 2) AS "Total"
FROM course_instance ci
JOIN course_layout cl ON ci.course_layout_id = cl.id
JOIN planned_activity pa ON pa.course_instance_id = ci.id
JOIN employee_planned_activity epa ON epa.planned_activity_id = pa.id
JOIN employee e ON epa.employee_id = e.id
JOIN person p ON e.person_id = p.id
LEFT JOIN teaching_activity ta ON pa.teaching_activity_id = ta.id
WHERE ci.study_year = '2025'
GROUP BY cl.course_code, ci.instance_id, cl.hp, ci.study_period, p.first_name, p.last_name
ORDER BY "Teacher's Name", "Total" DESC
LIMIT 1;