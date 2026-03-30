-- 1) To check the period for which job postings are available for Germany.
SELECT
    MIN(job_posted_date) AS first_posted_date,
    MAX(job_posted_date) AS last_posted_date
FROM job_postings_fact
WHERE job_country = 'Germany';
-- ┌─────────────────────┬─────────────────────┐
-- │  first_posted_date  │  last_posted_date   │
-- │      timestamp      │      timestamp      │
-- ├─────────────────────┼─────────────────────┤
-- │ 2023-01-01 00:37:45 │ 2025-06-29 06:06:44 │
-- └─────────────────────┴─────────────────────┘

--2) To check the total number of job postings available for Germany.
SELECT COUNT(*) AS total
                        FROM job_postings_fact
                        WHERE job_country = 'Germany' ;
-- ┌───────┐
-- │ total │
-- │ int64 │
-- ├───────┤
-- │ 51857 │
-- └───────┘

-- 3) To check the total number of job postings available in Germany with the title containing "Data Engineer" for Intern or working student positions.
SELECT COUNT(*) AS total
FROM job_postings_fact
WHERE job_country = 'Germany' 
    AND LOWER(job_title) LIKE '%data engineer%'
    AND LOWER(job_title) ~ '.*(working|internship|intern|praktikant|praktikum|werk|shk|student).*';

-- ┌───────┐
-- │ total │
-- │ int64 │
-- ├───────┤
-- │   396 │
-- └───────┘
 
SELECT job_title, 
    job_location, 
    job_posted_date
FROM job_postings_fact as jpf
WHERE job_country = 'Germany' 
    AND LOWER(job_title) LIKE '%data engineer%'
    AND LOWER(job_title) ~ '.*(working|internship|intern|praktikant|praktikum|werk|shk|student).*'
ORDER BY job_posted_date DESC
LIMIT 10;


  
