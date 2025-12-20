-- ============================================
-- 修复dish表description字段的编码问题
-- 数据库名: food_delivery_system
-- 说明: 统一修复所有乱码的description字段，根据菜品名称添加合适的描述
-- ============================================

USE `food_delivery_system`;

-- 设置字符集
SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

-- ============================================
-- 第一步：修复所有包含问号的description字段
-- ============================================

-- 根据用户提供的数据，修复每个菜品的描述

-- 2. 口味虾
UPDATE dish 
SET description = '湖南经典菜品，新鲜大虾配以特制调料，香辣鲜美，口感Q弹',
    update_time = NOW()
WHERE id = 2 AND name = '口味虾' AND (description LIKE '%?%' OR description LIKE '%？%');

-- 8. 回锅肉
UPDATE dish 
SET description = '四川经典菜品，肥瘦相间的五花肉，配以青椒和豆瓣酱，香辣下饭',
    update_time = NOW()
WHERE id = 8 AND name = '回锅肉' AND (description LIKE '%?%' OR description LIKE '%？%');

-- 10. 叉烧包
UPDATE dish 
SET description = '广式经典点心，外皮松软，内馅香甜，叉烧肉香浓郁',
    update_time = NOW()
WHERE id = 10 AND name = '叉烧包' AND (description LIKE '%?%' OR description LIKE '%？%');

-- 16. 青椒炒红椒
UPDATE dish 
SET description = '青椒与红椒的完美搭配，色彩鲜艳，口感爽脆，微辣开胃',
    update_time = NOW()
WHERE id = 16 AND name = '青椒炒红椒' AND (description LIKE '%?%' OR description LIKE '%？%');

-- 17. 湘西外婆菜
UPDATE dish 
SET description = '湘西特色家常菜，选用优质外婆菜，口感鲜香，下饭神器',
    update_time = NOW()
WHERE id = 17 AND name = '湘西外婆菜' AND (description LIKE '%?%' OR description LIKE '%？%');

-- 18. 干锅牛蛙
UPDATE dish 
SET description = '干锅系列经典菜品，牛蛙肉质鲜嫩，配以多种香料，香辣过瘾',
    update_time = NOW()
WHERE id = 18 AND name = '干锅牛蛙' AND (description LIKE '%?%' OR description LIKE '%？%');

-- 19. 湘味小炒肉
UPDATE dish 
SET description = '湖南经典小炒，猪肉鲜嫩，配以青椒，香辣下饭',
    update_time = NOW()
WHERE id = 19 AND name = '湘味小炒肉' AND (description LIKE '%?%' OR description LIKE '%？%');

-- 20. 鱼香肉丝
UPDATE dish 
SET description = '经典川菜，肉丝鲜嫩，配以木耳、胡萝卜丝，酸甜微辣，口感丰富',
    update_time = NOW()
WHERE id = 20 AND name = '鱼香肉丝' AND (description LIKE '%?%' OR description LIKE '%？%');

-- 21. 夫妻肺片
UPDATE dish 
SET description = '四川传统名菜，牛肉和牛杂配以特制调料，麻辣鲜香，回味无穷',
    update_time = NOW()
WHERE id = 21 AND name = '夫妻肺片' AND (description LIKE '%?%' OR description LIKE '%？%');

-- 22. 口水鸡
UPDATE dish 
SET description = '四川特色凉菜，鸡肉鲜嫩，配以特制调料，麻辣鲜香，开胃爽口',
    update_time = NOW()
WHERE id = 22 AND name = '口水鸡' AND (description LIKE '%?%' OR description LIKE '%？%');

-- 23. 担担面
UPDATE dish 
SET description = '四川经典面食，面条劲道，配以肉末和特制调料，麻辣鲜香',
    update_time = NOW()
WHERE id = 23 AND name = '担担面' AND (description LIKE '%?%' OR description LIKE '%？%');

-- 24. 烧鹅
UPDATE dish 
SET description = '广式经典烧腊，鹅肉外皮酥脆，肉质鲜嫩，配以特制酱汁，香味浓郁',
    update_time = NOW()
WHERE id = 24 AND name = '烧鹅' AND (description LIKE '%?%' OR description LIKE '%？%');

-- 25. 虾饺
UPDATE dish 
SET description = '广式经典点心，外皮透明Q弹，内馅鲜虾饱满，鲜美可口',
    update_time = NOW()
WHERE id = 25 AND name = '虾饺' AND (description LIKE '%?%' OR description LIKE '%？%');

-- 26. 肠粉
UPDATE dish 
SET description = '广式经典小吃，米浆制成，口感嫩滑，配以特制酱汁，鲜美爽口',
    update_time = NOW()
WHERE id = 26 AND name = '肠粉' AND (description LIKE '%?%' OR description LIKE '%？%');

-- 32. 糖醋里脊
UPDATE dish 
SET description = '经典家常菜，里脊肉外酥内嫩，配以糖醋汁，酸甜可口，老少皆宜',
    update_time = NOW()
WHERE id = 32 AND name = '糖醋里脊' AND (description LIKE '%?%' OR description LIKE '%？%');

-- 36. 松鼠桂鱼
UPDATE dish 
SET description = '苏帮菜经典，桂鱼造型美观，外酥内嫩，配以糖醋汁，酸甜可口',
    update_time = NOW()
WHERE id = 36 AND name = '松鼠桂鱼' AND (description LIKE '%?%' OR description LIKE '%？%');

-- 40. 西湖醋鱼
UPDATE dish 
SET description = '杭州名菜，选用新鲜草鱼，配以特制醋汁，酸甜鲜嫩，口感独特',
    update_time = NOW()
WHERE id = 40 AND name = '西湖醋鱼' AND (description LIKE '%?%' OR description LIKE '%？%');

-- 44. 佛跳墙
UPDATE dish 
SET description = '福建名菜，选用多种珍贵食材，慢火炖制，汤汁浓郁，营养丰富',
    update_time = NOW()
WHERE id = 44 AND name = '佛跳墙' AND (description LIKE '%?%' OR description LIKE '%？%');

-- 48. 臭鳜鱼
UPDATE dish 
SET description = '徽菜经典，鳜鱼经过特殊腌制，闻起来臭吃起来香，肉质鲜嫩',
    update_time = NOW()
WHERE id = 48 AND name = '臭鳜鱼' AND (description LIKE '%?%' OR description LIKE '%？%');

-- 52. 北京烤鸭
UPDATE dish 
SET description = '北京名菜，鸭皮酥脆，鸭肉鲜嫩，配以薄饼、甜面酱和葱丝，香味浓郁',
    update_time = NOW()
WHERE id = 52 AND name = '北京烤鸭' AND (description LIKE '%?%' OR description LIKE '%？%');

-- 56. 红烧肉
UPDATE dish 
SET description = '经典家常菜，五花肉肥而不腻，入口即化，配以特制红烧汁，香甜可口',
    update_time = NOW()
WHERE id = 56 AND name = '红烧肉' AND (description LIKE '%?%' OR description LIKE '%？%');

-- 60. 羊肉泡馍
UPDATE dish 
SET description = '陕西名小吃，羊肉鲜嫩，汤汁浓郁，配以掰碎的馍，香味四溢',
    update_time = NOW()
WHERE id = 60 AND name = '羊肉泡馍' AND (description LIKE '%?%' OR description LIKE '%？%');

-- ============================================
-- 第二步：处理所有全是问号的description字段（通用处理）
-- ============================================

-- 如果描述全是问号，设置为空字符串（避免显示乱码）
UPDATE dish 
SET description = '', 
    update_time = NOW()
WHERE description REGEXP '^[?？]+$';

-- ============================================
-- 第三步：验证修复结果
-- ============================================

-- 检查是否还有包含问号的描述
SELECT 
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

-- 查看修复后的数据总数
SELECT 
    COUNT(*) as total_dishes,
    SUM(CASE WHEN description IS NULL OR description = '' THEN 1 ELSE 0 END) as empty_descriptions,
    SUM(CASE WHEN description LIKE '%?%' OR description LIKE '%？%' THEN 1 ELSE 0 END) as question_mark_descriptions,
    SUM(CASE WHEN description IS NOT NULL AND description != '' AND description NOT LIKE '%?%' AND description NOT LIKE '%？%' THEN 1 ELSE 0 END) as normal_descriptions
FROM dish;

