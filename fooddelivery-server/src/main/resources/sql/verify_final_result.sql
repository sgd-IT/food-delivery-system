-- 验证最终结果
USE `food_delivery_system`;

-- 1. 检查是否还有包含问号的订单
SELECT COUNT(*) as remaining_question_mark_orders 
FROM orders 
WHERE remark LIKE '%?%' OR remark LIKE '%？%' OR remark = '???' OR remark = '????';

-- 2. 查看最新插入的订单数量（最近50小时内的订单）
SELECT COUNT(*) as new_orders_count 
FROM orders 
WHERE order_time >= DATE_SUB(NOW(), INTERVAL 50 HOUR);

-- 3. 查看订单总数
SELECT COUNT(*) as total_orders FROM orders;

-- 4. 查看最新10条订单
SELECT id, number, status, amount, remark, order_time 
FROM orders 
ORDER BY order_time DESC 
LIMIT 10;

