CREATE DATABASE IF NOT EXISTS jobs_mart;
SHOW DATABASES;

SELECT * 
FROM INFORMATION_SCHEMA.SCHEMATA;

USE jobs_mart;

CREATE SCHEMA IF NOT EXISTS staging;

DROP TABLE IF EXISTS staging.preferred_roles;

CREATE TABLE IF NOT EXISTS staging.preferred_roles(
    role_id INTEGER PRIMARY KEY,
    role_name VARCHAR
);

SELECT * 
FROM INFORMATION_SCHEMA.TABLES
WHERE table_catalog = 'jobs_mart';

AlTER TABLE staging.preferred_roles
ADD COLUMN preferred_role BOOLEAN;

INSERT INTO staging.preferred_roles(role_id, role_name)
VALUES 
    (1, 'Data Engineer'),
    (2, 'Seinor Data Engineer'),
    (3, 'Software Engineer');

UPDATE staging.preferred_roles
SET preferred_role = 'TRUE'
WHERE role_id != 3;

UPDATE staging.preferred_roles
SET preferred_role = 'FALSE'
WHERE role_id == 3;

ALTER TABLE staging.preferred_roles
RENAME TO priority_roles;

ALTER TABLE staging.priority_roles
RENAME COLUMN  preferred_role TO priority_lvl;

SELECT * FROM staging.priority_roles;

ALTER TABLE staging.priority_roles
ALTER COLUMN priority_lvl TYPE INTEGER;

UPDATE staging.priority_roles
SET priority_lvl = 2
WHERE role_id == 3;