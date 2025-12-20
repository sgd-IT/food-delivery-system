-- 修复套餐表中的问号问题
USE `food_delivery_system`;

-- 根据价格和分类修复套餐名称
-- 商务套餐 (category_id = 28)
UPDATE setmeal SET name = '商务套餐C' WHERE id = 5 AND category_id = 28 AND price = 108.00;
UPDATE setmeal SET name = '商务套餐D' WHERE id = 6 AND category_id = 28 AND price = 118.00;
UPDATE setmeal SET name = '商务套餐E' WHERE id = 7 AND category_id = 28 AND price = 128.00;

-- 情侣套餐 (category_id = 29)
UPDATE setmeal SET name = '浪漫双人餐' WHERE id = 8 AND category_id = 29 AND price = 188.00;
UPDATE setmeal SET name = '甜蜜套餐' WHERE id = 9 AND category_id = 29 AND price = 158.00;

-- 儿童套餐 (category_id = 30)
UPDATE setmeal SET name = '儿童营养餐' WHERE id = 10 AND category_id = 30 AND price = 42.00;
UPDATE setmeal SET name = '儿童快乐餐' WHERE id = 11 AND category_id = 30 AND price = 35.00;

-- 验证修复结果
SELECT id, category_id, name, price, status
FROM setmeal
WHERE name LIKE '%?%' OR name LIKE '%？%'
ORDER BY category_id, id;

-- 查看所有套餐数据
SELECT id, category_id, name, price, status
FROM setmeal
ORDER BY category_id, id;

-- 更新 order_detail 表中引用这些套餐的名称
UPDATE order_detail od
INNER JOIN setmeal s ON od.setmeal_id = s.id
SET od.name = s.name
WHERE od.setmeal_id IS NOT NULL AND (od.name LIKE '%?%' OR od.name LIKE '%？%');

-- 验证 order_detail 中的套餐名称
SELECT od.id, od.order_id, od.name, od.setmeal_id, s.name as setmeal_name
FROM order_detail od
INNER JOIN setmeal s ON od.setmeal_id = s.id
WHERE od.setmeal_id IS NOT NULL
ORDER BY od.id DESC
LIMIT 10;

