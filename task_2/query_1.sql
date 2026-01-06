SELECT 
    cl.course_code AS "Course Code",
    ci.instance_id AS "Course Instance ID",
    cl.hp AS HP,
    ci.study_period AS Period,
    ci.num_students AS "# Students",
    COALESCE(SUM(CASE WHEN LOWER(ta.activity_name) = 'lecture' THEN pa.planned_hours ELSE 0 END), 0) AS "Lecture Hours",
    COALESCE(SUM(CASE WHEN LOWER(ta.activity_name) = 'tutorial' THEN pa.planned_hours ELSE 0 END), 0) AS "Tutorial Hours",
    COALESCE(SUM(CASE WHEN LOWER(ta.activity_name) = 'lab' THEN pa.planned_hours ELSE 0 END), 0) AS "Lab Hours",
    COALESCE(SUM(CASE WHEN LOWER(ta.activity_name) = 'seminar' THEN pa.planned_hours ELSE 0 END), 0) AS "Seminar Hours",
    COALESCE(SUM(CASE WHEN LOWER(ta.activity_name) LIKE '%other%' THEN pa.planned_hours ELSE 0 END), 0) AS "Other Overhead Hours",
    COALESCE(SUM(CASE WHEN LOWER(ta.activity_name) = 'administration' THEN pa.planned_hours ELSE 0 END), 0) AS "Admin",
    COALESCE(SUM(CASE WHEN LOWER(ta.activity_name) = 'examination' THEN pa.planned_hours ELSE 0 END), 0) AS "Exam",
    ROUND(SUM(pa.planned_hours * COALESCE(ta.factor, 1.0)), 2) AS "Total Hours"
FROM course_instance ci
JOIN course_layout cl ON ci.course_layout_id = cl.id
LEFT JOIN planned_activity pa ON pa.course_instance_id = ci.id
LEFT JOIN teaching_activity ta ON pa.teaching_activity_id = ta.id
WHERE ci.study_year = '2025'
GROUP BY cl.course_code, ci.instance_id, cl.hp, ci.study_period, ci.num_students
ORDER BY cl.course_code, ci.instance_id;