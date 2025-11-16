-- DML SCRIPT: Analytical queries for the 'users' table

-- 1. Overall Summary Statistics
-- Calculates the total number of unique users, average session duration, and average tasks completed.
SELECT
    COUNT(DISTINCT user_id) AS total_unique_users,
    ROUND(AVG(session_duration_sec)::NUMERIC, 2) AS avg_session_duration_sec,
    ROUND(AVG(tasks_completed)::NUMERIC, 2) AS avg_tasks_completed,
    SUM(tasks_completed) AS total_tasks_completed
FROM
    users;

--------------------------------------------------------------------------------
    
-- 2. Performance by Device Type
-- Aggregates metrics to compare behavior across different device types (Android, iOS, Web).
SELECT
    device_type,
    COUNT(DISTINCT user_id) AS total_users,
    ROUND(AVG(session_duration_sec)::NUMERIC, 2) AS avg_session_duration_sec,
    ROUND(AVG(tasks_completed)::NUMERIC, 2) AS avg_tasks_completed_per_session
FROM
    users
GROUP BY
    device_type
ORDER BY
    total_users DESC;
    
--------------------------------------------------------------------------------

-- 3. Drop-off Risk Rate by User Segment
-- Calculates the percentage of sessions marked as 'high drop-off risk' within each user segment.
SELECT
    user_segment,
    COUNT(user_id) AS total_sessions,
    SUM(CASE WHEN is_high_dropoff_risk = TRUE THEN 1 ELSE 0 END) AS high_risk_sessions,
    ROUND(
        (SUM(CASE WHEN is_high_dropoff_risk = TRUE THEN 1 ELSE 0 END) * 100.0) / COUNT(user_id), 
        2
    ) AS high_risk_rate_percent
FROM
    users
GROUP BY
    user_segment
ORDER BY
    high_risk_rate_percent DESC;
    
--------------------------------------------------------------------------------

-- 4. Daily Task Completion Trend (Time Series)
-- Tracks daily activity, ordering by date to show trends over time.
SELECT
    session_date,
    COUNT(user_id) AS total_sessions,
    SUM(tasks_completed) AS total_tasks_completed_daily
FROM
    users
GROUP BY
    session_date
ORDER BY
    session_date ASC;

--------------------------------------------------------------------------------

-- 5. Analysis of Drop-off Stages
-- Analyzes the average time spent per task for sessions, grouped by the specific integer drop-off stage.
SELECT
    dropoff_flag,
    COUNT(user_id) AS num_sessions,
    ROUND(AVG(task_completion_time_per_task)::NUMERIC, 2) AS avg_task_time_at_stage
FROM
    users
GROUP BY
    dropoff_flag
ORDER BY
    dropoff_flag ASC;