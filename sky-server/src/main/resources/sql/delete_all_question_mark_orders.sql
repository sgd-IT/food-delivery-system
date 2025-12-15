-- 彻底删除所有包含问号的订单
USE `sky_take_out`;

-- 删除订单详情（关联删除）
DELETE od FROM order_detail od
INNER JOIN orders o ON od.order_id = o.id
WHERE (o.remark LIKE '%?%' OR o.remark LIKE '%？%' OR o.remark = '???' OR o.remark = '????');

-- 删除订单
DELETE FROM orders 
WHERE remark LIKE '%?%' OR remark LIKE '%？%' OR remark = '???' OR remark = '????';

-- 验证删除结果
SELECT COUNT(*) as remaining_question_mark_orders 
FROM orders 
WHERE remark LIKE '%?%' OR remark LIKE '%？%' OR remark = '???' OR remark = '????';

