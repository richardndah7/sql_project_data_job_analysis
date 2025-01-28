# Introduction:
Decoding the Data Analyst Job Market with SQL: This project dives deep into 💰 top salaries, 🔥 in-demand skills, and 📈 where high demand meets high pay by Unveiling the Data Analyst Landscape. This project explores the current job market, analyzing top-paying roles, identifying in-demand skills like SQL, Python, and Tableau, and pinpointing the career paths with the most promising earning potential.

For the SQL queries please check them out on the following link  [CLick here](/project_sql/)

# Background
Driven by a desire to understand the evolving data analyst landscape, this project leverages data gathered during my SQL Course to pinpoint top-paying roles and in-demand skills. The insights gleaned from this analysis can help aspiring data analysts navigate the job market more effectively.

### he questions I wanted to answer through my SQL queries were:
1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?


# Tools and Dataset
This project relied heavily on a suite of essential tools:
* **SQL :** The foundation for all data analysis, enabling me to extract, transform, and analyze job posting data.
* **PostgreSQL :** A robust and efficient database system for storing and managing the job posting data.
* **Visual Studio Code :** My preferred development environment, providing a seamless interface for writing and executing SQL queries, and managing database connections.
* **Git & GitHub :** Essential for version control, allowing me to track changes, collaborate effectively, and share my project with others.

##### Data Integrity :

The foundation of this project is a comprehensive dataset made available by [Luke Barousse](https://www.lukebarousse.com/), a respected data analyst known for his commitment to data quality. This meticulously curated dataset, built over time, provided the perfect springboard for my analysis of the data analyst job market.

# Analysis
My approach involved formulating a series of targeted SQL queries to address key questions about the data analyst job market. This iterative process allowed me to systematically explore the data and uncover valuable insights:

### 1. Top Paying Data Analyst Jobs
```sql
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
--adding a left join to enable adding the names of the companies which is in another table
WHERE         
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_location = 'Anywhere' 
ORDER BY
    salary_year_avg DESC
LIMIT   10
```
**My Findings :**
Analysis of the top ten highest-paying Data Analyst roles revealed a significant salary range. The highest-paying position, offered by Mantys, had an average annual salary of $650,000, while the lowest, an ERM Data Analyst role at Get It Recruit, offered $184,000. This data highlights the substantial earning potential for Data Analysts.

Furthermore, all ten of these top-paying roles were full-time and remote positions.

Finally, the analysis demonstrated a diversity of Data Analyst roles within the top ten, including positions such as Director of Analytics and Principal Data Analyst, indicating a wide range of career paths and specializations available within the field.
 
![Top Paying jobs](<viz_images/Sheet 1.png>)
Bar graph visualizing the salary for the top 10 salaries for data analysts; i created this simple graph from my SQL query results using Tableau

### 2. Skills for Top Paying Jobs
```sql
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
LIMIT 10
```
**My Findings :**
The analysis of job postings reveals the top 5 most sought-after skills for data analysts in 2023: SQL (with 8 occurrences), Python (7 occurrences), Tableau (6 occurrences), R (4 occurrences), and Pandas (3 occurrences).

![Required Skills](<viz_images/Sheet 2.png>)
Bar graph visualizing the top 10 skills required for the top pyaing jobs for data analysts; i created this simple graph from my SQL query results using Tableau

### 3. In-Demand Skills for Data Analysts
```sql
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
LIMIT 10
```
**My Findings :**
The analysis demonstrates that a strong foundation in SQL and Excel is essential for success in the Data Analyst field. Python emerges as the dominant programming language, indicating its crucial role in data manipulation and analysis. Tableau establishes itself as the leading data visualization tool, with Power BI also demonstrating significant demand.
![Demanded Skills](<viz_images/Sheet 3.png>)
Bar graph visualizing the top 10 demanded skills for data analysts; i created this simple graph from my SQL query results using Tableau

### 4. Skills Based on Salary
```sql
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
```
**My Findings :**
The  query above, regardless of location, identified Oracle, Kafka, Linux, Git, and SVN as exceptionally high-paying skills for Data Analysts, with an average annual salary exceeding $400,000.

However, this project's focus shifted to remote work opportunities, revealing a distinct set of top-earning skills. This analysis identified SQL, Python, R, Azure, Databricks, AWS, Pandas, PySpark, Jupyter, and Excel as the top ten most financially rewarding skills for Data Analysts in remote roles.
| Skill name    |  Job related           | Average Salary ($)
|---------------|------------------------|--------------------
| Oracle        | Database Administrator | 400.000.00
| Kafka         | Database Administrator | 400.000.00
| Linux         | Database Administrator | 400.000.00
| Git           | Database Administrator | 400.000.00
| SVN           | Database Administrator | 400.000.00
| Python        | HC Data Analyst,Senior | 375.000.00
| R             | HC Data Analyst,Senior | 375.000.00
| VBA           | HC Data Analyst,Senior | 375.000.00
| Excel         | HC Data Analyst,Senior | 375.000.00
| Tableau       | HC Data Analyst,Senior | 375.000.00
*Table of the average salary for the top 10 paying skills for data analysts*
### 5. Most Optimal Skills to Learn
```sql
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
```
**My Findings :**
The Rise of Cloud-Based Tools:

Skills related to cloud platforms, including Snowflake, Azure, AWS, and BigQuery, are in high demand and often associated with significant salaries, emphasizing the growing importance of cloud computing in the field of Data Analysis.

Programming Languages Remain Paramount:

Programming languages like Python and R continue to dominate, with demand counts reaching 236 and 148 respectively, solidifying their crucial role in data analysis workflows.

Data Visualization: A Critical Component

Tableau and Looker, with demand counts of 230 and 49 and average salaries around $99,288 and $103,795, respectively, highlight the critical importance of data visualization skills for Data Analysts.
| Skill ID | Skills     | Demand Count | Average Salary ($) |
|----------|------------|--------------|-------------------:|
| 8        | go         | 27           |            115,320 |
| 234      | confluence | 11           |            114,210 |
| 97       | hadoop     | 22           |            113,193 |
| 80       | snowflake  | 37           |            112,948 |
| 74       | azure      | 34           |            111,225 |
| 77       | bigquery   | 13           |            109,654 |
| 76       | aws        | 32           |            108,317 |
| 4        | java       | 17           |            106,906 |
| 194      | ssis       | 12           |            106,683 |
| 233      | jira       | 20           |            104,918 |

*Table of the most optimal skills for data analyst sorted by salary*
# Key Takeaways
This journey has significantly expanded my SQL expertise. I've mastered complex query crafting, including intricate joins and efficient use of WITH clauses. I've become proficient in data aggregation techniques, leveraging functions like COUNT() and AVG() to summarize data effectively. Moreover, I've honed my analytical skills, translating real-world questions into actionable SQL queries.
# Conclusion
Summary of Insights

1. High Earning Potential: The analysis revealed a significant salary range for Data Analyst roles, with top earners exceeding $650,000 per year and a minimum of $184,000 for the analyzed positions.

2. Remote Work Dominance: All of the top ten highest-paying Data Analyst roles were found to be both full-time and remote positions.

3. Most In-Demand Skill: SQL reigns supreme as the most sought-after skill in the data analyst job market, making it indispensable for job seekers.

4. Skills with Higher Salaries: Niche skills like SVN and Solidity are associated with significantly higher salaries, highlighting the value of specialized expertise.

5. Optimal Skill for Market Value: SQL emerges as the most valuable skill for data analysts, boasting both high demand and the potential for substantial earning potential.

# Appreciation
[Luke Barousse](https://www.linkedin.com/in/luke-b/)   
 https://www.linkedin.com/in/luke-b/

[Kelly Adams](https://www.kellyjadams.com/)  
https://www.kellyjadams.com/

I would like to express my sincere gratitude to Luke Barousse and Kelly Adams for their contributions to my learning journey. Their exceptional SQL learning course on YouTube has undoubtedly played a significant role in improving my proficiency in this essential skill.

Luke Barousse  I am particularly grateful to Luke Barousse for also making available the dataset used in this project's analysis. His generosity in sharing this valuable resource has been instrumental in my exploration of the data analyst job market.

Thank you for reading!