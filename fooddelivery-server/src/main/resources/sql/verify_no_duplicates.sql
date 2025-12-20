-- 验证是否还有重复的菜品
USE `food_delivery_system`;

-- 检查是否还有重复的菜品名称
SELECT name, COUNT(*) as count, GROUP_CONCAT(id ORDER BY id) as ids
FROM dish
GROUP BY name
HAVING count > 1
ORDER BY count DESC;

-- 如果还有重复，查看详细信息
SELECT 
    d.id,
    d.name,
    d.price,
    d.description,
    d.create_time,
    (SELECT COUNT(*) FROM order_detail WHERE dish_id = d.id) as order_count,
    (SELECT COUNT(*) FROM setmeal_dish WHERE dish_id = d.id) as setmeal_count
FROM dish d
WHERE d.name IN (
    SELECT name 
    FROM dish 
    GROUP BY name 
    HAVING COUNT(*) > 1
)
ORDER BY d.name, d.id;

