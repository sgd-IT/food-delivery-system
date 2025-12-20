-- 直接更新地址字段，修复编码问题
USE `food_delivery_system`;

SET NAMES utf8mb4;

-- 更新所有地址包含问号的订单
UPDATE orders 
SET address = '北京市朝阳区建国路88号'
WHERE address LIKE '%?%' OR address LIKE '%？%' OR address LIKE '%xxx%';

-- 更新所有备注包含问号的订单
UPDATE orders 
SET remark = NULL
WHERE remark LIKE '%?%' OR remark LIKE '%？%' OR remark = '???' OR remark = '????';

-- 验证结果
SELECT COUNT(*) as remaining_question_mark_orders 
FROM orders 
WHERE (remark LIKE '%?%' OR remark LIKE '%？%' OR remark = '???' OR remark = '????')
   OR (address LIKE '%?%' OR address LIKE '%？%' OR address LIKE '%xxx%');

-- 查看更新后的数据
SELECT id, number, address, remark FROM orders ORDER BY id DESC LIMIT 5;

