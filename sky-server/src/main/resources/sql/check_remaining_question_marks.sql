-- 检查剩余的包含问号的订单详情
USE `sky_take_out`;

-- 查看包含问号的订单（备注或地址）
SELECT id, number, address, remark, order_time, status
FROM orders 
WHERE (remark LIKE '%?%' OR remark LIKE '%？%' OR remark = '???' OR remark = '????')
   OR (address LIKE '%?%' OR address LIKE '%？%' OR address LIKE '%xxx%')
ORDER BY order_time DESC
LIMIT 10;

