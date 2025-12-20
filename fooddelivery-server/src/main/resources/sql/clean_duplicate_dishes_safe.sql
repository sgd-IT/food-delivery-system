-- 安全清理重复的菜品数据（只删除未被使用的）
USE `food_delivery_system`;

-- 北京烤鸭：ID 52 在订单中有使用，保留；删除未被使用的 53, 54, 55
DELETE FROM dish 
WHERE id IN (53, 54, 55) 
AND name = '北京烤鸭'
AND id NOT IN (
    SELECT DISTINCT dish_id FROM order_detail WHERE dish_id IN (53, 54, 55)
);

-- 验证清理结果
SELECT name, COUNT(*) as count
FROM dish
GROUP BY name
HAVING count > 1
ORDER BY count DESC;

-- 查看所有重复菜品及其使用情况
SELECT 
    d.name,
    d.category_id,
    COUNT(DISTINCT d.id) as dish_count,
    GROUP_CONCAT(DISTINCT d.id ORDER BY d.id) as dish_ids,
    GROUP_CONCAT(DISTINCT d.price ORDER BY d.price) as prices
FROM dish d
LEFT JOIN order_detail od ON d.id = od.dish_id
LEFT JOIN setmeal_dish sd ON d.id = sd.dish_id
GROUP BY d.name, d.category_id
HAVING dish_count > 1
ORDER BY dish_count DESC, d.name;

-- 查看剩余的"地三鲜"
SELECT id, name, price, description, create_time
FROM dish
WHERE name = '地三鲜'
ORDER BY id;

