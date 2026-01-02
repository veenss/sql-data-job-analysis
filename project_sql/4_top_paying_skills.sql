/*
Question : What are the top skills based on salary for my role (Data Analyst)?
*/

SELECT 
    sd.skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM 
    job_postings_fact jf
INNER JOIN skills_job_dim sjd ON jf.job_id = sjd.job_id
INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE 
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_work_from_home = TRUE
GROUP BY
    sd.skills
ORDER BY
    avg_salary DESC
LIMIT 25;