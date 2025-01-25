/*
Question: What are the top-paying data analyst jobs?
- Identify the top 10 highest-paying Data Analyst roles that are available remotely
- Focuses on job postings with specified salaries (remove nulls)
- BONUS: Include company names of top 10 roles
- Why? Highlight the top-paying opportunities for Data Analysts, offering insights into employment options and location flexibility.
*/

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

/* Findings
1. The most paying job opening is for the role of Data Analyst which was posted by
the company Mantys for an average yearly Salary of $650,000 while the 
least opening  on the scale of top ten was posted for an ERM Data analyst
role by Get It Recruit - Information Technology company for an
average yearly salary of $184,000. This points out a salary range for
Data analyst roles on a top ten scale of $184,000 to $650,000 which
shows significant average yearly earnings for Data Analysts.

2. The top ten most paying Data Analyst roles are all full time jobs and fully remote.

3. There is diversity of roles for Data Analysts in the different openings posted by the companies
eg. Director of Analytics, Principal Data Analyst, ERM Data Analyst etc.

*/