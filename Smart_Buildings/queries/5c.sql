-- BEGIN STARTER CODE
-- WITH sensor_children AS (
--     SELECT ______
--     FROM ______
--     WHERE object = ______
--         AND predicate = ______
-- )
-- SELECT ______, ______
-- FROM metadata AS md
-- INNER JOIN mapping AS map ON ______
-- INNER JOIN transitive_subClassOf AS t ON ______
-- INNER JOIN sensor_children AS sc ON ______
-- GROUP BY ______
-- ORDER BY ______;
-- END STARTER CODE

-- BEGIN SOLUTION 
WITH sensor_children AS (
    SELECT subject
    FROM ontology
    WHERE object = 'https://brickschema.org/schema/Brick#Sensor'
      AND predicate = 'http://www.w3.org/2000/01/rdf-schema#subClassOf'
)
SELECT sc.subject AS sensor_child,
       COUNT(DISTINCT md.id) AS count
FROM metadata AS md
INNER JOIN mapping AS map 
    ON md.class = map.rawname
INNER JOIN transitive_subClassOf AS t 
    ON t.subject = map.brickclass
INNER JOIN sensor_children AS sc
    ON t.object = sc.subject
GROUP BY sc.subject
ORDER BY sc.subject;
-- END SOLUTION
