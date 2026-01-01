-- BEGIN SOLUTION
WITH distinct_bsm AS (
SELECT DISTINCT building
FROM buildings_site_mapping
)

SELECT bsm.building,JSON_AGG(rem) AS json_agg
FROM distinct_bsm bsm
JOIN real_estate_metadata rem 
ON bsm.building = rem.building_name
GROUP BY bsm.building
HAVING COUNT(*) > 1
ORDER BY bsm.building ASC;
-- END SOLUTION
