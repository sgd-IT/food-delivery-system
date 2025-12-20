-- ============================================
-- 快速清理问号数据（修复版 - 避免转义问题）
-- 数据库名: food_delivery_system
-- ============================================

USE food_delivery_system;

SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

-- 清理菜品描述中的问号
-- 步骤1: 如果描述全是问号，设置为空字符串
UPDATE dish 
SET description = '', 
    update_time = NOW()
WHERE description IS NOT NULL 
  AND description != ''
  AND description NOT LIKE '%[^?？]%'
  AND (description LIKE '%?%' OR description LIKE '%？%');

-- 步骤2: 移除描述中的问号字符
UPDATE dish 
SET description = REPLACE(REPLACE(description, '?', ''), '？', ''),
    update_time = NOW()
WHERE description LIKE '%?%' OR description LIKE '%？%';

-- 步骤3: 清理空描述
UPDATE dish 
SET description = '', 
    update_time = NOW()
WHERE TRIM(COALESCE(description, '')) = '';

-- 清理套餐描述中的问号
-- 步骤1: 如果描述全是问号，设置为空字符串
UPDATE setmeal 
SET description = '', 
    update_time = NOW()
WHERE description IS NOT NULL 
  AND description != ''
  AND description NOT LIKE '%[^?？]%'
  AND (description LIKE '%?%' OR description LIKE '%？%');

-- 步骤2: 移除描述中的问号字符
UPDATE setmeal 
SET description = REPLACE(REPLACE(description, '?', ''), '？', ''),
    update_time = NOW()
WHERE description LIKE '%?%' OR description LIKE '%？%';

-- 步骤3: 清理空描述
UPDATE setmeal 
SET description = '', 
    update_time = NOW()
WHERE TRIM(COALESCE(description, '')) = '';

-- 验证清理结果
SELECT '菜品表剩余问号数量' as info, COUNT(*) as count
FROM dish
WHERE description LIKE '%?%' OR description LIKE '%？%';

SELECT '套餐表剩余问号数量' as info, COUNT(*) as count
FROM setmeal
WHERE description LIKE '%?%' OR description LIKE '%？%';

