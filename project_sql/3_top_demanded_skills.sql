/*
Question: What are the most in-demand skills for data analysts?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market, 
    providing insights into the most valuable skills for job seekers.
*/

SELECT
    skills,
    COUNT(*) AS demanded_skills
FROM job_postings_fact    
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere'
GROUP BY skills
ORDER BY demanded_skills DESC
LIMIT 5


/*
Findings:
From the query above, the result further shows that the knowledge of SQL
and excel is most vital and demanded for Data Analyst jobs. 
Python also has appeared to be the most demanded programming language 
for Data Analysts while tableau appears to be the most data visualization tool
followed by power bi.

[
  {
    "skills": "sql",
    "demanded_skills": "7291"
  },
  {
    "skills": "excel",
    "demanded_skills": "4611"
  },
  {
    "skills": "python",
    "demanded_skills": "4330"
  },
  {
    "skills": "tableau",
    "demanded_skills": "3745"
  },
  {
    "skills": "power bi",
    "demanded_skills": "2609"
  }
]

*/