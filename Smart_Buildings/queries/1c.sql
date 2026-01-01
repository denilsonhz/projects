-- BEGIN SOLUTION
WITH distinct_rem AS (
SELECT DISTINCT building_name
FROM real_estate_metadata
)

SELECT rem.building_name, JSON_AGG(bsm) AS json_agg
FROM distinct_rem rem
JOIN buildings_site_mapping bsm
ON bsm.building = rem.building_name
GROUP BY rem.building_name
HAVING COUNT(*) > 1
ORDER BY rem.building_name ASC;
-- END SOLUTION
