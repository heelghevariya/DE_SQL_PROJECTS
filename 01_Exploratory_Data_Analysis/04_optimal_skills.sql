-- Question: what are the most optimal skills for the data engineers in Germany balancing both demand and salary?
-- - Creating a ranking column that combines demand count and median salary to identify the most valuable skills.
-- - why? This approach highlights skills that balance market demand and financial reward. It weights core skills appropriately.

SELECT 
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 1) AS median_salary,
    COUNT(jpf.*) AS demand_count,
    ROUND(LN(COUNT(jpf.*)), 1) AS ln_demand_count,
    ROUND((LN(COUNT(jpf.*)) * MEDIAN(jpf.salary_year_avg))/1_000_000, 2) AS optimal_score
FROM job_postings_fact jpf
INNER JOIN skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_country = 'Germany'
    AND LOWER(job_title_short) LIKE '%data engineer%'
    AND jpf.salary_year_avg IS NOT NULL 
GROUP BY
    sd.skills
HAVING 
    COUNT(sjd.job_id) >= 5
ORDER BY
    optimal_score DESC
LIMIT 20;

-- ┌────────────┬───────────────┬──────────────┬─────────────────┬───────────────┐
-- │   skills   │ median_salary │ demand_count │ ln_demand_count │ optimal_score │
-- │  varchar   │    double     │    int64     │     double      │    double     │
-- ├────────────┼───────────────┼──────────────┼─────────────────┼───────────────┤
-- │ sql        │      147500.0 │           41 │             3.7 │          0.55 │
-- │ python     │      147500.0 │           37 │             3.6 │          0.53 │
-- │ spark      │      147500.0 │           29 │             3.4 │           0.5 │
-- │ aws        │      147500.0 │           27 │             3.3 │          0.49 │
-- │ azure      │      147500.0 │           22 │             3.1 │          0.46 │
-- │ databricks │      147500.0 │           14 │             2.6 │          0.39 │
-- │ airflow    │      147500.0 │           14 │             2.6 │          0.39 │
-- │ gcp        │      147500.0 │           10 │             2.3 │          0.34 │
-- │ git        │      147500.0 │           10 │             2.3 │          0.34 │
-- │ snowflake  │      147500.0 │            9 │             2.2 │          0.32 │
-- │ go         │      147500.0 │            8 │             2.1 │          0.31 │
-- │ kafka      │      147500.0 │            8 │             2.1 │          0.31 │
-- │ sap        │      147500.0 │            8 │             2.1 │          0.31 │
-- │ redshift   │      147500.0 │            7 │             1.9 │          0.29 │
-- │ terraform  │      147500.0 │            7 │             1.9 │          0.29 │
-- │ scala      │      147500.0 │            6 │             1.8 │          0.26 │
-- │ pyspark    │      147500.0 │            6 │             1.8 │          0.26 │
-- │ java       │       98283.0 │           11 │             2.4 │          0.24 │
-- │ bigquery   │      147500.0 │            5 │             1.6 │          0.24 │
-- │ docker     │       89100.0 │            7 │             1.9 │          0.17 │
-- └────────────┴───────────────┴──────────────┴─────────────────┴───────────────┘


-- *)Breakdown:

-->Top tier (highest value): SQL, Python, Spark, AWS, Azure → highest demand + top salaries
-->Mid tier: Databricks, Airflow, GCP, Snowflake → slightly lower demand but still strong pay
-->Lower tier: Java, Docker, BigQuery → either lower salaries or less demand impact.

-- *)Analysis & Insight:

--> The results show that SQL and Python are the most optimal skills, as they combine the highest demand with top salaries, making them essential for data engineers in Germany.

--> A key insight is that median salaries are nearly identical across most top skills, meaning the ranking is mainly influenced by demand. This highlights that widely used, core technologies (SQL, Python, Spark, cloud) provide the greatest overall value.

--> Additionally, modern tools like Databricks, Airflow, and Snowflake rank well despite lower demand, indicating that specialized platform skills enhance competitiveness.