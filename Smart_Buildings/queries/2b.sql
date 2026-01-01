DROP VIEW IF EXISTS cleaned_data;
CREATE VIEW cleaned_data AS

-- BEGIN SOLUTION
SELECT
time,
id,
value,
median,
mad,
is_outlier,
CASE 
    WHEN mad = 0 THEN 
           value
    WHEN value < median - 3 * 1.4826 * mad THEN 
           median - 3 * 1.4826 * mad
    WHEN value > median + 3 * 1.4826 * mad THEN 
           median + 3 * 1.4826 * mad
    ELSE 
           value
END AS clean_value
FROM labeled_data;

-- END SOLUTION

(SELECT * FROM cleaned_data WHERE is_outlier ORDER BY time, id LIMIT 50)
UNION ALL
(SELECT * FROM cleaned_data WHERE NOT is_outlier ORDER BY time, id LIMIT 50);
