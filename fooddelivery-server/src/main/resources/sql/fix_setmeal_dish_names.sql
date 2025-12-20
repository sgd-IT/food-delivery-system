-- 修复套餐菜品关系表中的问号问题
USE `food_delivery_system`;

-- 根据 dish_id 更新 setmeal_dish 表中的 name 字段
UPDATE setmeal_dish sd
INNER JOIN dish d ON sd.dish_id = d.id
SET sd.name = d.name
WHERE sd.name LIKE '%?%' OR sd.name LIKE '%？%';

-- 验证修复结果
SELECT sd.id, sd.setmeal_id, sd.dish_id, sd.name, d.name as dish_name, sd.price, sd.copies
FROM setmeal_dish sd
LEFT JOIN dish d ON sd.dish_id = d.id
WHERE sd.name LIKE '%?%' OR sd.name LIKE '%？%'
ORDER BY sd.setmeal_id, sd.id;

-- 查看所有修复后的数据
SELECT sd.id, sd.setmeal_id, sd.dish_id, sd.name, sd.price, sd.copies, s.name as setmeal_name
FROM setmeal_dish sd
LEFT JOIN setmeal s ON sd.setmeal_id = s.id
ORDER BY sd.setmeal_id, sd.id;

-- 检查套餐描述是否有问号
SELECT id, name, description
FROM setmeal
WHERE description LIKE '%?%' OR description LIKE '%？%'
ORDER BY id;

