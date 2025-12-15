-- 检查包含问号的订单详情
USE `sky_take_out`;

-- 查看包含问号的订单的备注字段内容
SELECT id, number, remark, order_time 
FROM orders 
WHERE remark LIKE '%?%' OR remark LIKE '%？%' 
LIMIT 10;

