/*
Question : What are the skills required for these top-paying roles?
*/

WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        c.name AS company_name,
        job_location,
        job_schedule_type,
        job_posted_date,
        salary_year_avg
    FROM 
        job_postings_fact j
    LEFT JOIN company_dim c ON j.company_id = c.company_id
    WHERE 
        job_title_short = 'Data Analyst' AND 
        salary_year_avg IS NOT NULL AND 
        job_location = 'Anywhere'
        
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    tj.*,
    sd.skills
FROM 
    top_paying_jobs tj
INNER JOIN skills_job_dim sjd ON tj.job_id = sjd.job_id
INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
ORDER BY 
    salary_year_avg DESC;