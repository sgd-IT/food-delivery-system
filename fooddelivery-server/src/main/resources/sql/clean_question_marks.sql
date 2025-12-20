-- ============================================
-- 清理数据库中的问号数据
-- 数据库名: food_delivery_system
-- 说明: 此脚本用于清理菜品和套餐描述中的问号占位符
-- ============================================

USE `food_delivery_system`;

-- 设置字符集
SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

-- ============================================
-- 第一步：检查包含问号的数据（执行清理前先查看）
-- ============================================

-- 检查菜品表中包含问号的描述
SELECT 
    'dish' as table_name,
    id, 
    name, 
    description,
    CASE 
        WHEN description IS NULL THEN 'NULL'
        WHEN description = '' THEN 'EMPTY'
        WHEN description REGEXP '^[?？]+$' THEN 'ALL_QUESTION_MARKS'
        WHEN description LIKE '%?%' OR description LIKE '%？%' THEN 'HAS_QUESTION_MARKS'
        ELSE 'OK'
    END as description_status
FROM dish
WHERE description LIKE '%?%' OR description LIKE '%？%' OR description IS NULL OR description = ''
ORDER BY id;

-- 检查套餐表中包含问号的描述
SELECT 
    'setmeal' as table_name,
    id, 
    name, 
    description,
    CASE 
        WHEN description IS NULL THEN 'NULL'
        WHEN description = '' THEN 'EMPTY'
        WHEN description REGEXP '^[?？]+$' THEN 'ALL_QUESTION_MARKS'
        WHEN description LIKE '%?%' OR description LIKE '%？%' THEN 'HAS_QUESTION_MARKS'
        ELSE 'OK'
    END as description_status
FROM setmeal
WHERE description LIKE '%?%' OR description LIKE '%？%' OR description IS NULL OR description = ''
ORDER BY id;

-- ============================================
-- 第二步：清理菜品描述中的问号
-- ============================================

-- 1. 如果描述全是问号（包括中文和英文问号），设置为空字符串
UPDATE dish 
SET description = '', 
    update_time = NOW()
WHERE description REGEXP '^[?？]+$';

-- 2. 如果描述包含问号但不是全问号，移除问号字符
-- 注意：这里只处理全是问号的情况，如果描述中混有问号和其他字符，保留其他字符
UPDATE dish 
SET description = REPLACE(REPLACE(description, '?', ''), '？', ''),
    update_time = NOW()
WHERE (description LIKE '%?%' OR description LIKE '%？%')
  AND description NOT REGEXP '^[?？]+$'
  AND LENGTH(REPLACE(REPLACE(description, '?', ''), '？', '')) > 0;

-- 3. 如果移除问号后描述为空，设置为空字符串
UPDATE dish 
SET description = '', 
    update_time = NOW()
WHERE (description LIKE '%?%' OR description LIKE '%？%')
  AND LENGTH(TRIM(REPLACE(REPLACE(description, '?', ''), '？', ''))) = 0;

-- ============================================
-- 第三步：清理套餐描述中的问号
-- ============================================

-- 1. 如果描述全是问号（包括中文和英文问号），设置为空字符串
UPDATE setmeal 
SET description = '', 
    update_time = NOW()
WHERE description REGEXP '^[?？]+$';

-- 2. 如果描述包含问号但不是全问号，移除问号字符
UPDATE setmeal 
SET description = REPLACE(REPLACE(description, '?', ''), '？', ''),
    update_time = NOW()
WHERE (description LIKE '%?%' OR description LIKE '%？%')
  AND description NOT REGEXP '^[?？]+$'
  AND LENGTH(REPLACE(REPLACE(description, '?', ''), '？', '')) > 0;

-- 3. 如果移除问号后描述为空，设置为空字符串
UPDATE setmeal 
SET description = '', 
    update_time = NOW()
WHERE (description LIKE '%?%' OR description LIKE '%？%')
  AND LENGTH(TRIM(REPLACE(REPLACE(description, '?', ''), '？', ''))) = 0;

-- ============================================
-- 第四步：验证清理结果
-- ============================================

-- 验证菜品表：应该没有问号了
SELECT 
    'dish_after_clean' as table_name,
    COUNT(*) as total_count,
    SUM(CASE WHEN description LIKE '%?%' OR description LIKE '%？%' THEN 1 ELSE 0 END) as has_question_marks,
    SUM(CASE WHEN description IS NULL OR description = '' THEN 1 ELSE 0 END) as empty_descriptions,
    SUM(CASE WHEN description IS NOT NULL AND description != '' AND description NOT LIKE '%?%' AND description NOT LIKE '%？%' THEN 1 ELSE 0 END) as valid_descriptions
FROM dish;

-- 验证套餐表：应该没有问号了
SELECT 
    'setmeal_after_clean' as table_name,
    COUNT(*) as total_count,
    SUM(CASE WHEN description LIKE '%?%' OR description LIKE '%？%' THEN 1 ELSE 0 END) as has_question_marks,
    SUM(CASE WHEN description IS NULL OR description = '' THEN 1 ELSE 0 END) as empty_descriptions,
    SUM(CASE WHEN description IS NOT NULL AND description != '' AND description NOT LIKE '%?%' AND description NOT LIKE '%？%' THEN 1 ELSE 0 END) as valid_descriptions
FROM setmeal;

-- 如果还有问号，显示详细信息
SELECT 
    'dish_remaining_issues' as table_name,
    id, 
    name, 
    description
FROM dish
WHERE description LIKE '%?%' OR description LIKE '%？%'
ORDER BY id;

SELECT 
    'setmeal_remaining_issues' as table_name,
    id, 
    name, 
    description
FROM setmeal
WHERE description LIKE '%?%' OR description LIKE '%？%'
ORDER BY id;

-- ============================================
-- 清理完成提示
-- ============================================
-- 执行完成后，请检查验证结果
-- 如果 has_question_marks 为 0，说明清理成功
-- 如果还有问号，请手动检查并修复

