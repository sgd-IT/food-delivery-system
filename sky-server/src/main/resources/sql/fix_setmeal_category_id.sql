-- ============================================
-- 修复套餐表的category_id
-- 将错误的category_id (13, 14, 15) 更新为正确的套餐分类ID (28, 29, 30)
-- ============================================

USE `sky_take_out`;

-- 更新商务套餐的category_id: 13 -> 28
UPDATE `setmeal` SET `category_id` = 28 WHERE `category_id` = 13;

-- 更新情侣套餐的category_id: 14 -> 29
UPDATE `setmeal` SET `category_id` = 29 WHERE `category_id` = 14;

-- 更新儿童套餐的category_id: 15 -> 30
UPDATE `setmeal` SET `category_id` = 30 WHERE `category_id` = 15;

-- 验证更新结果
SELECT 
    s.id as setmeal_id,
    s.name as setmeal_name,
    s.category_id,
    c.name as category_name,
    c.type as category_type
FROM setmeal s 
LEFT JOIN category c ON c.id = s.category_id
ORDER BY s.id;

