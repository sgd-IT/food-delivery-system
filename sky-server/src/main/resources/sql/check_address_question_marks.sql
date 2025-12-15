-- 检查地址字段包含问号的订单
USE `sky_take_out`;

-- 查看地址字段包含问号的订单
SELECT id, number, address, remark, order_time, status
FROM orders 
WHERE address LIKE '%?%' OR address LIKE '%？%' OR address LIKE '%xxx%'
ORDER BY order_time DESC
LIMIT 20;

-- 统计数量
SELECT COUNT(*) as orders_with_question_marks_in_address
FROM orders 
WHERE address LIKE '%?%' OR address LIKE '%？%' OR address LIKE '%xxx%';

