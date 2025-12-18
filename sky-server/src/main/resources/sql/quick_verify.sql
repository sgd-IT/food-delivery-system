USE sky_take_out;
SET NAMES utf8mb4;
SELECT id, category_id, name, price, 
CASE 
    WHEN description LIKE '%?%' OR description LIKE '%？%' THEN 'HAS_QUESTION'
    WHEN LENGTH(description) > 10 THEN 'OK'
    ELSE 'EMPTY'
END as status,
LENGTH(description) as len
FROM dish 
WHERE (category_id = 13 AND price IN (30.00, 32.00, 68.00, 38.00))
   OR (category_id = 14 AND price IN (35.00, 45.00, 42.00, 22.00))
   OR (category_id = 15 AND price IN (88.00, 25.00, 18.00))
   OR (category_id = 17 AND price = 45.00)
   OR (category_id = 18 AND price = 98.00)
   OR (category_id = 19 AND price = 88.00)
   OR (category_id = 20 AND price = 288.00)
   OR (category_id = 21 AND price = 88.00)
   OR (category_id = 22 AND price = 188.00)
   OR (category_id = 23 AND price = 58.00)
   OR (category_id = 24 AND price = 38.00)
ORDER BY category_id, price;


