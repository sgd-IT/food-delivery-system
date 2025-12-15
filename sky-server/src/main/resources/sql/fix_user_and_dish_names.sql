-- 修复用户名和菜品名的问号问题
USE `sky_take_out`;

SET NAMES utf8mb4;

-- 1. 更新订单表中的用户名和收货人
UPDATE orders 
SET user_name = '张三',
    consignee = '张三'
WHERE user_name LIKE '%?%' OR user_name LIKE '%？%' 
   OR consignee LIKE '%?%' OR consignee LIKE '%？%';

-- 2. 更新订单详情表中的菜品名
-- 先查看需要更新的订单详情
UPDATE order_detail od
INNER JOIN orders o ON od.order_id = o.id
SET od.name = (
    SELECT COALESCE(d.name, s.name, '未知菜品')
    FROM (
        SELECT dish_id, setmeal_id FROM order_detail WHERE id = od.id
    ) temp
    LEFT JOIN dish d ON temp.dish_id = d.id
    LEFT JOIN setmeal s ON temp.setmeal_id = s.id
    LIMIT 1
)
WHERE od.name LIKE '%?%' OR od.name LIKE '%？%';

-- 如果上面的更新方式有问题，使用更简单的方式：根据dish_id或setmeal_id更新
UPDATE order_detail od
INNER JOIN dish d ON od.dish_id = d.id
SET od.name = d.name
WHERE (od.name LIKE '%?%' OR od.name LIKE '%？%') AND od.dish_id IS NOT NULL;

UPDATE order_detail od
INNER JOIN setmeal s ON od.setmeal_id = s.id
SET od.name = s.name
WHERE (od.name LIKE '%?%' OR od.name LIKE '%？%') AND od.setmeal_id IS NOT NULL;

-- 验证结果
SELECT o.id, o.number, o.user_name, o.consignee, od.name as dish_name, od.number as dish_quantity
FROM orders o 
LEFT JOIN order_detail od ON o.id = od.order_id 
WHERE o.number = 'ORD20251215000001'
LIMIT 5;

-- 统计还有多少问号数据
SELECT 
    (SELECT COUNT(*) FROM orders WHERE user_name LIKE '%?%' OR user_name LIKE '%？%' OR consignee LIKE '%?%' OR consignee LIKE '%？%') as orders_with_question_marks,
    (SELECT COUNT(*) FROM order_detail WHERE name LIKE '%?%' OR name LIKE '%？%') as order_details_with_question_marks;

