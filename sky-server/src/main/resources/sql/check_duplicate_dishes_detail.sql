-- 详细检查重复的菜品数据
USE `sky_take_out`;

-- 查看所有"地三鲜"的详细信息
SELECT id, name, category_id, price, status, image, description, create_time
FROM dish
WHERE name = '地三鲜'
ORDER BY id;

-- 检查这些菜品是否被使用（在订单或套餐中）
SELECT 
    d.id,
    d.name,
    d.price,
    COUNT(DISTINCT od.id) as order_detail_count,
    COUNT(DISTINCT sd.id) as setmeal_dish_count
FROM dish d
LEFT JOIN order_detail od ON d.id = od.dish_id
LEFT JOIN setmeal_dish sd ON d.id = sd.dish_id
WHERE d.name = '地三鲜'
GROUP BY d.id, d.name, d.price;

-- 查看所有重复菜品及其使用情况
SELECT 
    d.name,
    d.category_id,
    COUNT(DISTINCT d.id) as dish_count,
    GROUP_CONCAT(DISTINCT d.id ORDER BY d.id) as dish_ids,
    GROUP_CONCAT(DISTINCT d.price ORDER BY d.price) as prices,
    COUNT(DISTINCT od.id) as total_order_details,
    COUNT(DISTINCT sd.id) as total_setmeal_dishes
FROM dish d
LEFT JOIN order_detail od ON d.id = od.dish_id
LEFT JOIN setmeal_dish sd ON d.id = sd.dish_id
GROUP BY d.name, d.category_id
HAVING dish_count > 1
ORDER BY dish_count DESC, d.name;

