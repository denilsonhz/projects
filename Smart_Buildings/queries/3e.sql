-- BEGIN SOLUTION
SELECT rem.building_name, rem.address, rem.location, uc_loc.loc_name AS clean_location 
FROM real_estate_metadata rem
JOIN LATERAL (SELECT uc.loc_name 
              FROM uc_locations uc
              ORDER BY word_similarity(rem.location, uc.loc_name) DESC LIMIT 1)
AS uc_loc ON TRUE;
-- END SOLUTION