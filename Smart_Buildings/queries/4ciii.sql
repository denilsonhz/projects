DROP VIEW IF EXISTS likely_data;
CREATE VIEW likely_data AS
-- BEGIN SOLUTION
SELECT *, 
       run_start + (run_rank)*((run_end-run_start)/(run_size))
         AS interpolated
  FROM backward;
-- END SOLUTION

SELECT * FROM likely_data WHERE run_size > 2 ORDER BY id, time LIMIT 100;
