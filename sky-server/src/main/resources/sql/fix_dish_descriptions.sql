-- 修复菜品描述中的问号问题
USE `sky_take_out`;

-- 设置字符集
SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

-- 检查包含问号的菜品描述
SELECT id, name, description
FROM dish
WHERE description LIKE '%?%' OR description LIKE '%？%'
ORDER BY id;

-- 根据菜品名称和常见描述修复菜品描述
-- 注意：这里需要根据实际的菜品数据来更新，以下是一些示例

-- 示例1：如果菜品名称包含"烤鸭"，描述可能是关于烤鸭的
UPDATE dish 
SET description = '经典北京烤鸭，皮脆肉嫩，配以薄饼和甜面酱'
WHERE name LIKE '%烤鸭%' AND (description LIKE '%?%' OR description LIKE '%？%' OR description IS NULL);

-- 示例2：如果菜品名称包含"鱼头"，描述可能是关于鱼头的
UPDATE dish 
SET description = '新鲜鱼头配以剁椒，香辣可口'
WHERE name LIKE '%鱼头%' AND (description LIKE '%?%' OR description LIKE '%？%' OR description IS NULL);

-- 示例3：如果菜品名称包含"沙拉"或"poke"，描述可能是关于沙拉的
UPDATE dish 
SET description = '新鲜蔬菜配以精选肉类，营养丰富，口感清爽'
WHERE (name LIKE '%沙拉%' OR name LIKE '%poke%' OR name LIKE '%Poke%') 
  AND (description LIKE '%?%' OR description LIKE '%？%' OR description IS NULL);

-- 通用修复：如果描述全是问号，设置为空字符串（用户可以后续编辑）
UPDATE dish 
SET description = ''
WHERE description = '?????????' OR description = '????????' OR description = '???????';

-- 验证修复结果
SELECT id, name, description
FROM dish
WHERE description LIKE '%?%' OR description LIKE '%？%'
ORDER BY id;

-- 查看所有菜品的描述情况
SELECT id, name, description,
       CASE 
         WHEN description IS NULL THEN 'NULL'
         WHEN description = '' THEN 'EMPTY'
         WHEN description LIKE '%?%' OR description LIKE '%？%' THEN 'HAS_QUESTION_MARK'
         ELSE 'OK'
       END as description_status
FROM dish
ORDER BY id;

