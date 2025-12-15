-- 检查套餐菜品关系表中的问号问题
USE `sky_take_out`;

-- 查看所有套餐菜品关系数据
SELECT sd.id, sd.setmeal_id, sd.dish_id, sd.name, sd.price, sd.copies, s.name as setmeal_name
FROM setmeal_dish sd
LEFT JOIN setmeal s ON sd.setmeal_id = s.id
ORDER BY sd.setmeal_id, sd.id;

-- 检查有问号的套餐菜品
SELECT sd.id, sd.setmeal_id, sd.dish_id, sd.name, s.name as setmeal_name, d.name as dish_name
FROM setmeal_dish sd
LEFT JOIN setmeal s ON sd.setmeal_id = s.id
LEFT JOIN dish d ON sd.dish_id = d.id
WHERE sd.name LIKE '%?%' OR sd.name LIKE '%？%'
ORDER BY sd.setmeal_id, sd.id;

