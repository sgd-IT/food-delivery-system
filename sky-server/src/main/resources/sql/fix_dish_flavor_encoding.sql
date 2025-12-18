-- ============================================
-- 修复dish_flavor表name和value字段的编码问题
-- 数据库名: sky_take_out
-- 说明: 根据菜品类型设置合理的口味配置
-- ============================================

USE `sky_take_out`;

-- 设置字符集
SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

-- ============================================
-- 第一步：删除所有乱码的口味数据
-- ============================================

-- 删除所有name或value包含问号的记录
DELETE FROM dish_flavor 
WHERE name LIKE '%?%' OR name LIKE '%？%' 
   OR value LIKE '%?%' OR value LIKE '%？%';

-- ============================================
-- 第二步：根据菜品类型重新插入合理的口味配置
-- ============================================

-- 1. 剁椒鱼头 (dish_id=1) - 湘菜，需要辣度配置
INSERT INTO dish_flavor (dish_id, name, value) VALUES
(1, '辣度', '["不辣","微辣","中辣","重辣"]'),
(1, '忌口', '["不要葱","不要蒜","不要香菜"]');

-- 2. 口味虾 (dish_id=2) - 湘菜，需要辣度配置
INSERT INTO dish_flavor (dish_id, name, value) VALUES
(2, '辣度', '["不辣","微辣","中辣","重辣"]'),
(2, '忌口', '["不要葱","不要蒜","不要香菜"]');

-- 3. 麻婆豆腐 (dish_id=5) - 川菜，需要辣度配置
INSERT INTO dish_flavor (dish_id, name, value) VALUES
(5, '辣度', '["不辣","微辣","中辣","重辣"]'),
(5, '忌口', '["不要葱","不要蒜","不要香菜"]');

-- 4. 水煮鱼 (dish_id=7) - 川菜，需要辣度配置
INSERT INTO dish_flavor (dish_id, name, value) VALUES
(7, '辣度', '["不辣","微辣","中辣","重辣"]'),
(7, '忌口', '["不要葱","不要蒜","不要香菜","不要鱼刺"]');

-- ============================================
-- 第三步：验证修复结果
-- ============================================

-- 检查是否还有包含问号的口味数据
SELECT 
    COUNT(*) as question_mark_count
FROM dish_flavor
WHERE name LIKE '%?%' OR name LIKE '%？%' 
   OR value LIKE '%?%' OR value LIKE '%？%';

-- 查看修复后的口味数据
SELECT 
    df.id,
    df.dish_id,
    d.name as dish_name,
    df.name as flavor_name,
    df.value as flavor_value
FROM dish_flavor df
LEFT JOIN dish d ON df.dish_id = d.id
ORDER BY df.dish_id, df.id;

-- 统计信息
SELECT 
    COUNT(*) as total_flavors,
    COUNT(DISTINCT dish_id) as dishes_with_flavors,
    SUM(CASE WHEN name LIKE '%?%' OR name LIKE '%？%' OR value LIKE '%?%' OR value LIKE '%？%' THEN 1 ELSE 0 END) as question_mark_count
FROM dish_flavor;

