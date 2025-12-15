-- 检查重复的菜品
USE `sky_take_out`;

-- 查看所有"地三鲜"菜品
SELECT id, name, category_id, price, status, create_time
FROM dish
WHERE name = '地三鲜'
ORDER BY id;

-- 统计每个菜品名称的数量
SELECT name, COUNT(*) as count, GROUP_CONCAT(id) as ids, GROUP_CONCAT(price) as prices
FROM dish
GROUP BY name
HAVING count > 1
ORDER BY count DESC;

-- 查看所有菜品，按名称和价格分组
SELECT name, category_id, price, COUNT(*) as count
FROM dish
GROUP BY name, category_id, price
HAVING count > 1
ORDER BY name;

