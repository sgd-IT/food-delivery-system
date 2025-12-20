-- ============================================
-- 快速清理问号数据（简化版）
-- 数据库名: food_delivery_system
-- 说明: 直接清理菜品和套餐描述中的问号，建议先备份数据库
-- ============================================

USE `food_delivery_system`;

-- 设置字符集
SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

-- ============================================
-- 清理菜品描述中的问号
-- ============================================

-- 如果描述全是问号，设置为空字符串（使用TRIM和REPLACE判断）
UPDATE dish 
SET description = '', 
    update_time = NOW()
WHERE TRIM(REPLACE(REPLACE(description, '?', ''), '？', '')) = ''
  AND (description LIKE '%?%' OR description LIKE '%？%');

-- 如果描述包含问号，移除问号字符
UPDATE dish 
SET description = REPLACE(REPLACE(description, '?', ''), '？', ''),
    update_time = NOW()
WHERE description LIKE '%?%' OR description LIKE '%？%';

-- 如果移除问号后描述为空或只有空格，设置为空字符串
UPDATE dish 
SET description = '', 
    update_time = NOW()
WHERE TRIM(description) = '';

-- ============================================
-- 清理套餐描述中的问号
-- ============================================

-- 如果描述全是问号，设置为空字符串（使用TRIM和REPLACE判断）
UPDATE setmeal 
SET description = '', 
    update_time = NOW()
WHERE TRIM(REPLACE(REPLACE(description, '?', ''), '？', '')) = ''
  AND (description LIKE '%?%' OR description LIKE '%？%');

-- 如果描述包含问号，移除问号字符
UPDATE setmeal 
SET description = REPLACE(REPLACE(description, '?', ''), '？', ''),
    update_time = NOW()
WHERE description LIKE '%?%' OR description LIKE '%？%';

-- 如果移除问号后描述为空或只有空格，设置为空字符串
UPDATE setmeal 
SET description = '', 
    update_time = NOW()
WHERE TRIM(description) = '';

-- ============================================
-- 验证清理结果
-- ============================================

-- 检查是否还有问号
SELECT '菜品表剩余问号数量' as info, COUNT(*) as count
FROM dish
WHERE description LIKE '%?%' OR description LIKE '%？%';

SELECT '套餐表剩余问号数量' as info, COUNT(*) as count
FROM setmeal
WHERE description LIKE '%?%' OR description LIKE '%？%';

-- 如果返回的 count 为 0，说明清理成功！

