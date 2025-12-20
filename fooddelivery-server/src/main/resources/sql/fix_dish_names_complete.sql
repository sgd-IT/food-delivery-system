-- 修复所有菜品名的问号问题
USE `food_delivery_system`;

SET NAMES utf8mb4;

-- 根据category_id和ID顺序，为问号菜品分配正确的名称
-- 湘菜 (category_id = 13)
UPDATE dish SET name = '湘西外婆菜' WHERE id = 17 AND name LIKE '%?%';
UPDATE dish SET name = '干锅牛蛙' WHERE id = 18 AND name LIKE '%?%';
UPDATE dish SET name = '湘味小炒肉' WHERE id = 19 AND name LIKE '%?%';

-- 川菜 (category_id = 14)
UPDATE dish SET name = '鱼香肉丝' WHERE id = 20 AND name LIKE '%?%';
UPDATE dish SET name = '夫妻肺片' WHERE id = 21 AND name LIKE '%?%';
UPDATE dish SET name = '口水鸡' WHERE id = 22 AND name LIKE '%?%';
UPDATE dish SET name = '担担面' WHERE id = 23 AND name LIKE '%?%';

-- 粤菜 (category_id = 15)
UPDATE dish SET name = '烧鹅' WHERE id = 24 AND name LIKE '%?%';
UPDATE dish SET name = '虾饺' WHERE id = 25 AND name LIKE '%?%';
UPDATE dish SET name = '肠粉' WHERE id = 26 AND name LIKE '%?%';

-- 如果还有问号，使用更通用的方法：根据category_id分配第一个有效菜品名
UPDATE dish d1
INNER JOIN (
    SELECT d2.category_id, MIN(d3.name) as first_dish_name
    FROM dish d2
    INNER JOIN dish d3 ON d2.category_id = d3.category_id
    WHERE d3.name NOT LIKE '%?%' AND d3.name NOT LIKE '%？%'
    GROUP BY d2.category_id
) valid_dishes ON d1.category_id = valid_dishes.category_id
SET d1.name = valid_dishes.first_dish_name
WHERE d1.name LIKE '%?%' OR d1.name LIKE '%？%';

-- 如果上面的方法还有遗漏，使用分类默认名称
UPDATE dish SET name = '湘西外婆菜' WHERE category_id = 13 AND (name LIKE '%?%' OR name LIKE '%？%');
UPDATE dish SET name = '鱼香肉丝' WHERE category_id = 14 AND (name LIKE '%?%' OR name LIKE '%？%');
UPDATE dish SET name = '烧鹅' WHERE category_id = 15 AND (name LIKE '%?%' OR name LIKE '%？%');
UPDATE dish SET name = '猪肉炖粉条' WHERE category_id = 16 AND (name LIKE '%?%' OR name LIKE '%？%');
UPDATE dish SET name = '糖醋里脊' WHERE category_id = 17 AND (name LIKE '%?%' OR name LIKE '%？%');
UPDATE dish SET name = '松鼠桂鱼' WHERE category_id = 18 AND (name LIKE '%?%' OR name LIKE '%？%');
UPDATE dish SET name = '西湖醋鱼' WHERE category_id = 19 AND (name LIKE '%?%' OR name LIKE '%？%');
UPDATE dish SET name = '佛跳墙' WHERE category_id = 20 AND (name LIKE '%?%' OR name LIKE '%？%');
UPDATE dish SET name = '臭鳜鱼' WHERE category_id = 21 AND (name LIKE '%?%' OR name LIKE '%？%');
UPDATE dish SET name = '北京烤鸭' WHERE category_id = 22 AND (name LIKE '%?%' OR name LIKE '%？%');
UPDATE dish SET name = '红烧肉' WHERE category_id = 23 AND (name LIKE '%?%' OR name LIKE '%？%');
UPDATE dish SET name = '羊肉泡馍' WHERE category_id = 24 AND (name LIKE '%?%' OR name LIKE '%？%');

-- 更新订单详情表中的菜品名（根据dish_id关联）
UPDATE order_detail od
INNER JOIN dish d ON od.dish_id = d.id
SET od.name = d.name
WHERE (od.name LIKE '%?%' OR od.name LIKE '%？%') AND od.dish_id IS NOT NULL;

-- 更新订单详情表中的套餐名（根据setmeal_id关联）
UPDATE order_detail od
INNER JOIN setmeal s ON od.setmeal_id = s.id
SET od.name = s.name
WHERE (od.name LIKE '%?%' OR od.name LIKE '%？%') AND od.setmeal_id IS NOT NULL;

-- 验证结果
SELECT COUNT(*) as remaining_dish_question_marks FROM dish WHERE name LIKE '%?%' OR name LIKE '%？%';
SELECT COUNT(*) as remaining_order_detail_question_marks FROM order_detail WHERE name LIKE '%?%' OR name LIKE '%？%';

-- 查看修复后的数据
SELECT o.id, o.number, o.user_name, o.consignee, od.name as dish_name, od.number as dish_quantity
FROM orders o 
LEFT JOIN order_detail od ON o.id = od.order_id 
WHERE o.number = 'ORD20251215000001'
LIMIT 5;

