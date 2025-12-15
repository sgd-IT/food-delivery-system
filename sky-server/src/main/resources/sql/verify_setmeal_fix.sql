-- 验证套餐修复结果
USE `sky_take_out`;

-- 检查是否还有问号
SELECT COUNT(*) as remaining_question_marks
FROM setmeal
WHERE name LIKE '%?%' OR name LIKE '%？%';

-- 查看所有套餐
SELECT id, category_id, name, price, status
FROM setmeal
ORDER BY category_id, id;

-- 检查 order_detail 中是否还有问号
SELECT COUNT(*) as order_detail_question_marks
FROM order_detail
WHERE name LIKE '%?%' OR name LIKE '%？%';

