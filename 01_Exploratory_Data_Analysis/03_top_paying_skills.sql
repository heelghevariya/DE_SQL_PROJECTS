-- Question: What are the highest paying skills for data engineering roles in Germany?
-- - Calculating median salary for each skill required for Data Engineer roles.
-- - Including skills frequency to identify both salary and demand.
-- - why? it will help identify which skills command the highest compensation while also showing how common those skills are, providing a more complete picture for skill development priorities.


SELECT sd.skills,
    MEDIAN(jpf.salary_year_avg) AS median_salary,
    COUNT(jpf.*) as Demand_count
FROM job_postings_fact as jpf
INNER JOIN skills_job_dim as jsd
    ON jpf.job_id = jsd.job_id
INNER JOIN skills_dim as sd
    ON jsd.skill_id = sd.skill_id
WHERE jpf.job_country = 'Germany'
    AND LOWER(job_title) LIKE '%data engineer%'
GROUP BY 
    sd.skills
HAVING 
    COUNT(jpf.*) > 10
    AND MEDIAN(jpf.salary_year_avg) IS NOT NULL
ORDER BY 
    median_salary  DESC
LIMIT 30;

-- ┌──────────────┬───────────────┬──────────────┐
-- │    skills    │ median_salary │ Demand_count │
-- │   varchar    │    double     │    int64     │
-- ├──────────────┼───────────────┼──────────────┤
-- │ excel        │      185000.0 │          359 │
-- │ unify        │      166250.0 │           20 │
-- │ swift        │      159500.0 │           31 │
-- │ graphql      │      153500.0 │           76 │
-- │ fastapi      │      153500.0 │          142 │
-- │ tableau      │      150500.0 │          976 │
-- │ databricks   │      147500.0 │         1926 │
-- │ python       │      147500.0 │         8149 │
-- │ snowflake    │      147500.0 │         1693 │
-- │ bigquery     │      147500.0 │          675 │
-- │ power bi     │      147500.0 │         1234 │
-- │ terraform    │      147500.0 │         1214 │
-- │ airflow      │      147500.0 │         2029 │
-- │ spark        │      147500.0 │         3178 │
-- │ gdpr         │      147500.0 │          140 │
-- │ dynamodb     │      147500.0 │           91 │
-- │ scikit-learn │      147500.0 │          110 │
-- │ sql          │      147500.0 │         7199 │
-- │ mysql        │      147500.0 │          492 │
-- │ slack        │      147500.0 │           31 │
-- │ azure        │      147500.0 │         4554 │
-- │ cassandra    │      147500.0 │          201 │
-- │ redshift     │      147500.0 │          844 │
-- │ hadoop       │      147500.0 │         1308 │
-- │ sap          │      147500.0 │          785 │
-- │ looker       │      147500.0 │          326 │
-- │ aws          │      147500.0 │         3868 │
-- │ julia        │      147500.0 │           87 │
-- │ matplotlib   │      147500.0 │           34 │
-- │ git          │      147500.0 │         1496 │
-- └──────────────┴───────────────┴──────────────┘

-- *Insights:-

-- -> Most core data engineering skills (Python, SQL, Spark, AWS, Azure, Databricks) have a similar median salary (~147,500), indicating they are baseline requirements.
-- -> High-demand skills (Python, SQL, AWS, Azure) do not necessarily lead to higher pay despite large job counts.
-- -> A few niche skills (Excel, Unify, Swift, GraphQL, FastAPI) show higher median salaries, but with much lower demand.
-- -> Data visualization tools (Tableau, Power BI) show both strong demand and competitive salaries.
-- Salary differences across skills are relatively small, suggesting limited pay variation based purely on individual skills.

-- *Conclusion:-

-- -> Core technical skills are essential for employability but not strong salary differentiators.
-- -> Niche or less common skills may offer higher pay but fewer opportunities.
-- -> The market favors a combination of high-demand foundational skills with selective specialized tools for better earning potential.