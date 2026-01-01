DROP VIEW IF EXISTS backward;
CREATE VIEW backward AS
-- BEGIN SOLUTION
SELECT id,
    time,
value,
run,
run_start,
next_val,
       CASE WHEN value IS NOT NULL THEN value
            ELSE coalesce_agg(next_val) OVER (PARTITION BY id, run ORDER BY time DESC)
        END AS run_end,
        -1 + (RANK() OVER (PARTITION BY id, run ORDER BY time)) AS run_rank,
       count(*) OVER (PARTITION BY id, run) AS run_size
  FROM forward;
-- END SOLUTION

SELECT * FROM backward WHERE run_size > 2 ORDER BY id, run, run_rank LIMIT 100;
