/*
Question : What are the most in-demand skills for my role (Data Analyst)?
*/

SELECT 
    sd.skills,
    COUNT(*) AS skill_count
FROM 
    job_postings_fact jf
INNER JOIN skills_job_dim sjd ON jf.job_id = sjd.job_id
INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE 
    job_title_short = 'Data Analyst' AND
    job_work_from_home = TRUE
GROUP BY
    sd.skills
ORDER BY
    skill_count DESC
LIMIT 5;