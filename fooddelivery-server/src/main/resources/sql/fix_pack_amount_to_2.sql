-- 将打包费固定为2元
USE `food_delivery_system`;

-- 更新所有订单的打包费为2元（如果为0或NULL）
UPDATE orders 
SET pack_amount = 2
WHERE pack_amount = 0 OR pack_amount IS NULL;

-- 验证结果
SELECT 
    COUNT(*) as total_orders,
    COUNT(CASE WHEN pack_amount = 2 THEN 1 END) as orders_with_pack_amount_2,
    COUNT(CASE WHEN pack_amount != 2 AND pack_amount IS NOT NULL THEN 1 END) as orders_with_other_pack_amount
FROM orders;

-- 查看示例数据
SELECT id, number, amount, pack_amount, order_time 
FROM orders 
ORDER BY order_time DESC 
LIMIT 10;

