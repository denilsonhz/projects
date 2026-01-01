DROP VIEW IF EXISTS labeled_data;
CREATE VIEW labeled_data AS

-- BEGIN SOLUTION
WITH sensor_median AS(SELECT id, PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY value) AS median 
FROM data GROUP BY id), 

abs_differences AS (SELECT
d.time,
d.id,
d.value,
m.median,
ABS(d.value - m.median) AS abs_diff
FROM data d
JOIN sensor_median m ON m.id=d.id
),

sensor_mad AS (
SELECT id, PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY abs_diff) AS mad
FROM abs_differences
GROUP BY id
) 

SELECT d.time, d.id, d.value, sm.median, smad.mad,
CASE 
    WHEN smad.mad = 0 THEN FALSE
    WHEN ABS(d.value - sm.median) > 3 * 1.4826 * smad.mad THEN TRUE
    ELSE FALSE
    END AS is_outlier
FROM data d
JOIN sensor_median sm ON sm.id=d.id
JOIN sensor_mad smad ON smad.id=d.id;

-- END SOLUTION

(SELECT * FROM labeled_data WHERE is_outlier ORDER BY time, id LIMIT 50)
UNION ALL
(SELECT * FROM labeled_data WHERE NOT is_outlier ORDER BY time, id LIMIT 50);
