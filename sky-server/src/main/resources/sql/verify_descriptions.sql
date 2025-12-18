USE sky_take_out;
SET NAMES utf8mb4;

SELECT 
    id,
    name,
    CASE 
        WHEN description IS NULL THEN 'NULL'
        WHEN description = '' THEN 'EMPTY'
        WHEN LENGTH(description) > 0 THEN 'HAS_DESCRIPTION'
        ELSE 'UNKNOWN'
    END as status,
    LENGTH(description) as desc_length,
    description
FROM dish 
WHERE id IN (16,17,18,19,20,21,22,23,24,25,26,32,36,40,44,48,52,56,60)
ORDER BY id;

