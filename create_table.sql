-- DDL SCRIPT: Creates the 'users' table in PostgreSQL

-- 1. Create the table with the correct data types for the CSV file
CREATE TABLE users (
    user_id INTEGER PRIMARY KEY,
    device_type VARCHAR(50),
    session_date DATE,
    session_duration_sec INTEGER,
    tasks_completed INTEGER,
    user_segment VARCHAR(50),
    -- Corrected from BOOLEAN to INTEGER to accommodate values > 1 in your CSV (like "2")
    dropoff_flag INTEGER,
    task_completion_time_per_task REAL,
    is_high_dropoff_risk BOOLEAN
);

-- 2. Data Import (To be run separately in pgAdmin, as path 'D:\users.csv' is local)

/* -- NOTE: You run these two commands in pgAdmin after creating the table:
   SET datestyle = 'ISO, DMY';
   COPY users FROM 'D:\users.csv' WITH CSV HEADER;
*/