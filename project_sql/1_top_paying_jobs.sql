/*
Question : What are the top paying jobs for my role (Data Analyst)?
*/

SELECT
    job_id,
    job_title,
    c.name AS company_name,
    job_location,
    job_schedule_type,
    job_posted_date,
    salary_year_avg
FROM job_postings_fact j
LEFT JOIN company_dim c
ON j.company_id = c.company_id
WHERE job_title_short = 'Data Analyst' AND 
    salary_year_avg IS NOT NULL AND 
    job_location = 'Anywhere'
ORDER BY
    salary_year_avg DESC
LIMIT 10;


