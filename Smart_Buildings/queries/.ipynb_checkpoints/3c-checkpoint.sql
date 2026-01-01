-- BEGIN SOLUTION
WITH class_units AS(
    SELECT class, COUNT(DISTINCT units) AS units
FROM metadata
    GROUP BY class
)

SELECT 1 = ALL (SELECT units FROM class_units) AS are_units_consistent;

-- END SOLUTION
