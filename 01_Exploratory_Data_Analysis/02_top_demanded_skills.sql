-- Question : What are the most in-demand skills for student or intern positions roles for Data Engineers in Germany?
-- Identifying the top 10 in-demand skills


SELECT sd.skills,
    COUNT(jpf.*) as Demand_count
FROM job_postings_fact as jpf
INNER JOIN skills_job_dim as jsd
    ON jpf.job_id = jsd.job_id
INNER JOIN skills_dim as sd
    ON jsd.skill_id = sd.skill_id
WHERE jpf.job_country = 'Germany'
    AND LOWER(job_title) LIKE '%data engineer%'
    AND LOWER(job_title) ~ '.*(working|internship|intern|praktikant|praktikum|werk|shk|student).*'
GROUP BY 
    sd.skills
ORDER BY 
    Demand_count DESC
LIMIT 10;

-- ┌─────────┬──────────────┐
-- │ skills  │ Demand_count │
-- │ varchar │    int64     │
-- ├─────────┼──────────────┤  
-- │ python  │          256 │
-- │ sql     │          179 │
-- │ aws     │           66 │
-- │ azure   │           63 │
-- │ java    │           56 │
-- │ r       │           54 │
-- │ git     │           46 │
-- │ github  │           39 │
-- │ docker  │           36 │
-- │ airflow │           35 │
-- └─────────┴──────────────┘

-- Takeaways:
-- For student and intern Data Engineer roles in Germany, Python and SQL are the most sought-after skills, forming the core requirements. Cloud platforms like AWS and Azure are increasingly expected, even for entry-level positions. Additionally, tools for collaboration and workflow management Git, GitHub, Docker, and Airflow are frequently requested, reflecting the importance of reproducible pipelines and teamwork. Gaining proficiency in these areas, alongside Python and SQL, provides a strong foundation for securing student or internship opportunities in data engineering.