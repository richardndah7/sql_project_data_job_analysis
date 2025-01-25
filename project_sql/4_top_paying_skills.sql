/*
Answer: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Analysts and 
    helps identify the most financially rewarding skills to acquire or improve
*/

SELECT
    skills AS skill_name,
    job_title AS job_related,
    salary_year_avg AS avg_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL --AND
    --job_location = 'Anywhere'
ORDER BY
    avg_salary DESC 
LIMIT 10

/*
Findings:
Results from query above shows that going by the quetion which stipulates
"regardless of location", oracle , kafka, linux, git and svn stands 
out as exceptional rewarding skills for Data Analyst with a $400.000 average
yearly salary.
However the main focus of my project is on remote work which provides
an entirely different result that shows that sql, python, r, azure, databricks,
aws, pandas, pyspark, jupiter and excel are top ten most financially rewarding skills
*/