/*
Question: What skills are required for the top-paying data analyst jobs?
- Use the top 10 highest-paying Data Analyst jobs from first query
- Add the specific skills required for these roles
- Why? It provides a detailed look at which high-paying jobs demand certain skills, 
    helping job seekers understand which skills to develop that align with top salaries
*/

WITH top_jobs AS (
    SELECT 
        job_id,
        job_title AS Jobs,
        job_location AS location,
        salary_year_avg AS avg_salary,
        job_schedule_type,
        job_posted_date::DATE AS date,
    name As company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
--adding join to enable adding the names of the companies which is in another table
WHERE         
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_location = 'Anywhere' 
ORDER BY
    salary_year_avg DESC
LIMIT   10
)
SELECT
    top_jobs.* ,
    skills
FROM
    top_jobs
INNER JOIN  skills_job_dim ON top_jobs.job_id = skills_job_dim.job_id
INNER JOIN  skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY avg_salary  DESC

/* Now that we have been able to find the skills lets dig deeper to have a good knowledge
   of the top 5 skills in demand by the top paying Data Analyts jobs with a sub-query count 
*/   

SELECT
    skills,
    COUNT(*) AS skills_count
FROM (
    WITH top_jobs AS (
    SELECT 
        job_id,
        job_title AS Jobs,
        job_location AS location,
        salary_year_avg AS avg_salary,
        job_schedule_type,
        job_posted_date::DATE AS date,
    name As company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
--adding join to enable adding the names of the companies which is in another table
WHERE         
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_location = 'Anywhere' 
ORDER BY
    salary_year_avg DESC
LIMIT   10
)
SELECT
    top_jobs.* ,
    skills
FROM
    top_jobs
INNER JOIN  skills_job_dim ON top_jobs.job_id = skills_job_dim.job_id
INNER JOIN  skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY avg_salary  DESC
) 
GROUP BY skills 
ORDER BY skills_count DESC
LIMIT 5


/*
Findings:
From the last query it is clear that the top 5 most demanded skills for data analysts in 2023, based on job postings are :
SQL with 8 counts
Python with 7 counts
Tableau with 6 counts
Programming with R language with 4 counts
panda with 3 counts.

[
  {
    "skills": "sql",
    "skills_count": "8"
  },
  {
    "skills": "python",
    "skills_count": "7"
  },
  {
    "skills": "tableau",
    "skills_count": "6"
  },
  {
    "skills": "r",
    "skills_count": "4"
  },
  {
    "skills": "pandas",
    "skills_count": "3"
  }
]
*/