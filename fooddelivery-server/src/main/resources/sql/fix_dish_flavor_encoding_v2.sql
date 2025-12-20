-- ============================================
-- 修复dish_flavor表name和value字段的编码问题
-- 数据库名: food_delivery_system
-- 说明: 使用SET NAMES确保编码正确
-- ============================================

USE `food_delivery_system`;

-- 设置字符集
SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

-- ============================================
-- 第一步：删除所有乱码的口味数据
-- ============================================

DELETE FROM dish_flavor 
WHERE name LIKE '%?%' OR name LIKE '%？%' 
   OR value LIKE '%?%' OR value LIKE '%？%';

-- ============================================
-- 第二步：插入正确的口味数据
-- ============================================

-- dish_id=1: 剁椒鱼头
INSERT INTO dish_flavor (dish_id, name, value) VALUES
(1, 0xE8BEA3E5BAA6, 0x5B22E4B88DE8BEA3222C22E5BEAEE8BEA3222C22E4B8ADE8BEA3222C22E9878DE8BEA3225D),
(1, 0xE5BF8CE58FA3, 0x5B22E4B88DE8A681E891B1222C22E4B88DE8A681E8929C222C22E4B88DE8A681E9A699E88F9C225D);

-- dish_id=2: 口味虾
INSERT INTO dish_flavor (dish_id, name, value) VALUES
(2, 0xE8BEA3E5BAA6, 0x5B22E4B88DE8BEA3222C22E5BEAEE8BEA3222C22E4B8ADE8BEA3222C22E9878DE8BEA3225D),
(2, 0xE5BF8CE58FA3, 0x5B22E4B88DE8A681E891B1222C22E4B88DE8A681E8929C222C22E4B88DE8A681E9A699E88F9C225D);

-- dish_id=5: 麻婆豆腐
INSERT INTO dish_flavor (dish_id, name, value) VALUES
(5, 0xE8BEA3E5BAA6, 0x5B22E4B88DE8BEA3222C22E5BEAEE8BEA3222C22E4B8ADE8BEA3222C22E9878DE8BEA3225D),
(5, 0xE5BF8CE58FA3, 0x5B22E4B88DE8A681E891B1222C22E4B88DE8A681E8929C222C22E4B88DE8A681E9A699E88F9C225D);

-- dish_id=7: 水煮鱼
INSERT INTO dish_flavor (dish_id, name, value) VALUES
(7, 0xE8BEA3E5BAA6, 0x5B22E4B88DE8BEA3222C22E5BEAEE8BEA3222C22E4B8ADE8BEA3222C22E9878DE8BEA3225D),
(7, 0xE5BF8CE58FA3, 0x5B22E4B88DE8A681E891B1222C22E4B88DE8A681E8929C222C22E4B88DE8A681E9A699E88F9C222C22E4B88DE8A681E9B1BCE588BA225D);

-- ============================================
-- 第三步：验证修复结果
-- ============================================

SELECT 
    COUNT(*) as question_mark_count
FROM dish_flavor
WHERE name LIKE '%?%' OR name LIKE '%？%' 
   OR value LIKE '%?%' OR value LIKE '%？%';

SELECT 
    df.id,
    df.dish_id,
    d.name as dish_name,
    df.name as flavor_name,
    df.value as flavor_value
FROM dish_flavor df
LEFT JOIN dish d ON df.dish_id = d.id
ORDER BY df.dish_id, df.id;

