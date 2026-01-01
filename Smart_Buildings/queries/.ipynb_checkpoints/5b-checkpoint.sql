-- BEGIN SOLUTION
SELECT NOT EXISTS (
 SELECT 1
    FROM(
      SELECT subject, COUNT(DISTINCT object) AS parent_count
      FROM transitive_subClassOf
      GROUP BY subject
    ) AS per_subject
    WHERE parent_count > 1
) AS is_tree;
-- END SOLUTION
