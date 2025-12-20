-- 验证所有套餐相关数据的修复结果
USE `food_delivery_system`;

-- 检查套餐表中是否还有问号
SELECT COUNT(*) as setmeal_question_marks
FROM setmeal
WHERE name LIKE '%?%' OR name LIKE '%？%' OR description LIKE '%?%' OR description LIKE '%？%';

-- 检查套餐菜品关系表中是否还有问号
SELECT COUNT(*) as setmeal_dish_question_marks
FROM setmeal_dish
WHERE name LIKE '%?%' OR name LIKE '%？%';

-- 查看所有套餐的完整信息
SELECT s.id, s.name, s.description, COUNT(sd.id) as dish_count
FROM setmeal s
LEFT JOIN setmeal_dish sd ON s.id = sd.setmeal_id
GROUP BY s.id, s.name, s.description
ORDER BY s.id;

-- 查看套餐菜品详情
SELECT sd.id, s.name as setmeal_name, sd.name as dish_name, sd.price, sd.copies
FROM setmeal_dish sd
LEFT JOIN setmeal s ON sd.setmeal_id = s.id
ORDER BY sd.setmeal_id, sd.id
LIMIT 20;

