/*
Question : What are the most optimal skills to learn?
- Optimal : High Demand and High Paying
*/

WITH skill_demand AS (
    SELECT
        sd.skill_id,
        sd.skills,
        COUNT(*) AS skill_count
    FROM 
        job_postings_fact jf
    INNER JOIN skills_job_dim sjd ON jf.job_id = sjd.job_id
    INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
    WHERE 
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_work_from_home = TRUE
    GROUP BY
        sd.skill_id
), top_paying_skills AS (
    SELECT 
        sd.skill_id,
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
        sd.skill_id
)

SELECT 
    sd.skill_id,
    sd.skills,
    sd.skill_count,
    tps.avg_salary
FROM 
    skill_demand sd
INNER JOIN top_paying_skills tps
ON sd.skill_id = tps.skill_id
WHERE
    sd.skill_count > 10
ORDER BY
    tps.avg_salary DESC,
    sd.skill_count DESC;

--rewriting query more concisely

SELECT
    sd.skill_id,
    sd.skills,
    COUNT(sjd.job_id) AS skill_count,
    ROUND(AVG(jf.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact jf 
INNER JOIN skills_job_dim sjd ON jf.job_id = sjd.job_id
INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE 
    job_title_short = 'Data Analyst' AND 
    salary_year_avg IS NOT NULL AND 
    job_work_from_home = TRUE
GROUP BY 
    sd.skill_id
HAVING COUNT(sjd.job_id) > 10
ORDER BY
    avg_salary DESC,
    skill_count DESC;


