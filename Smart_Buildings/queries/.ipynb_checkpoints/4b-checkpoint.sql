DROP VIEW IF EXISTS complete;
CREATE VIEW complete AS

-- BEGIN SOLUTION
WITH missing_readings AS (
SELECT ga.id, 
GENERATE_SERIES(
ga.lag_time + INTERVAL '15 minutes', 
ga.time - INTERVAL '15 minutes', 
INTERVAL '15 minutes'
) AS time, NULL::double precision AS value
FROM gaps ga
)

SELECT id, time, value FROM data 
UNION ALL SELECT id, time, value FROM missing_readings;
-- END SOLUTION

SELECT * FROM complete ORDER BY id, time LIMIT 100;
