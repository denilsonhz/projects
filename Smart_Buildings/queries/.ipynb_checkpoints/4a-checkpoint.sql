DROP VIEW IF EXISTS gaps;
CREATE VIEW gaps AS

-- BEGIN SOLUTION
WITH readings AS (
    SELECT id, DATE_TRUNC('minute', time) AS minute_time, value,
        LAG(DATE_TRUNC('minute', time)) OVER (PARTITION BY id ORDER BY time) AS lag_minute_time,
        LAG(value) OVER (PARTITION BY id ORDER BY time) AS lag_value
    FROM data
)

SELECT id, minute_time AS time, value, lag_minute_time AS lag_time, lag_value, (minute_time - lag_minute_time) AS time_diff
FROM readings
WHERE (minute_time - lag_minute_time) >= INTERVAL '30 minutes';

-- END SOLUTION

SELECT * FROM gaps ORDER BY id, time;
