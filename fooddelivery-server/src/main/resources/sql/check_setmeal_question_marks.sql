-- 检查套餐表中的问号问题
USE `food_delivery_system`;

-- 查看所有套餐数据
SELECT id, category_id, name, price, status, create_time
FROM setmeal
ORDER BY category_id, id;

-- 检查有问号的套餐
SELECT id, category_id, name, price, status
FROM setmeal
WHERE name LIKE '%?%' OR name LIKE '%？%'
ORDER BY category_id, id;

-- 统计各分类的套餐数量
SELECT 
    c.name as category_name,
    COUNT(s.id) as setmeal_count
FROM category c
LEFT JOIN setmeal s ON c.id = s.category_id
WHERE c.type = 2
GROUP BY c.id, c.name
ORDER BY c.id;

