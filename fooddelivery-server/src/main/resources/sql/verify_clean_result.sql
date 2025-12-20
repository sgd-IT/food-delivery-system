-- 验证清理结果
USE food_delivery_system;

SELECT '菜品表总数' as info, COUNT(*) as total FROM dish;
SELECT '套餐表总数' as info, COUNT(*) as total FROM setmeal;

SELECT '菜品表剩余问号数量' as info, COUNT(*) as count
FROM dish
WHERE description LIKE '%?%' OR description LIKE '%？%';

SELECT '套餐表剩余问号数量' as info, COUNT(*) as count
FROM setmeal
WHERE description LIKE '%?%' OR description LIKE '%？%';

-- 显示一些示例数据
SELECT '菜品示例数据' as info, id, name, LEFT(description, 50) as description_preview
FROM dish
LIMIT 5;

SELECT '套餐示例数据' as info, id, name, LEFT(description, 50) as description_preview
FROM setmeal
LIMIT 5;

