/*
Answer: What are the most optimal skills to learn (aka it’s in high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries), 
    offering strategic insights for career development in data analysis
*/

WITH skills_demand AS (
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(*) AS demanded_skills
FROM job_postings_fact    
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
GROUP BY skills_dim.skill_id
), average_salary AS (
SELECT
    skills_job_dim.skill_id,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_location = 'Anywhere'
GROUP BY skills_job_dim.skill_id    
)
SELECT
skills_demand.skill_id,
skills_demand.skills,
demanded_skills,
avg_salary
FROM skills_demand
INNER JOIN average_salary on skills_demand.skill_id = average_salary.skill_id
WHERE demanded_skills > 10
ORDER BY
    avg_salary DESC
LIMIT 25    

/*
Findings:
The importance of cloud base tools :
Skills specialized cloud based tools such as Snowflake, Azure, AWS, and BigQuery are widely demanded and
comes with significant salaries which shows a strong importance of cloud plartforms in Data Analysis

Programming skills remains a prioty demand:
Programming tools such as Python and R stand out for recording the highest demand counts with 236 and 148 respectively.

Visualization:
Tableau and Looker, with demand counts of 230 and 49 respectively, and average salaries around $99,288 and $103,795, 
highlight the critical role of data visualization in Data Analysis.


Thank you for your time 

Appreciations:

Luke Barousse https://www.linkedin.com/in/luke-b/
Kelly Adams   https://www.kellyjadams.com/

For putting together a wonderful sql learning course on youtube to help improve proficiency for so many people out there.
Most Luke also for putting together the dataset that was used for this analysis in this project.
*/