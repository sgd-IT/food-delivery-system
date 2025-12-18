-- 根据分类ID和价格更新菜品描述
USE sky_take_out;
SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

-- category_id=13 的菜品
UPDATE dish SET description = '青椒与红椒的完美搭配，色彩鲜艳，口感爽脆，微辣开胃', update_time = NOW() WHERE category_id = 13 AND price = 30.00;
UPDATE dish SET description = '湘西特色家常菜，选用优质外婆菜，口感鲜香，下饭神器', update_time = NOW() WHERE category_id = 13 AND price = 32.00;
UPDATE dish SET description = '干锅系列经典菜品，牛蛙肉质鲜嫩，配以多种香料，香辣过瘾', update_time = NOW() WHERE category_id = 13 AND price = 68.00;
UPDATE dish SET description = '湖南经典小炒，猪肉鲜嫩，配以青椒，香辣下饭', update_time = NOW() WHERE category_id = 13 AND price = 38.00;

-- category_id=14 的菜品
UPDATE dish SET description = '经典川菜，肉丝鲜嫩，配以木耳、胡萝卜丝，酸甜微辣，口感丰富', update_time = NOW() WHERE category_id = 14 AND price = 35.00;
UPDATE dish SET description = '四川传统名菜，牛肉和牛杂配以特制调料，麻辣鲜香，回味无穷', update_time = NOW() WHERE category_id = 14 AND price = 45.00;
UPDATE dish SET description = '四川特色凉菜，鸡肉鲜嫩，配以特制调料，麻辣鲜香，开胃爽口', update_time = NOW() WHERE category_id = 14 AND price = 42.00;
UPDATE dish SET description = '四川传统面食，面条劲道，配以肉末和特制调料，麻辣鲜香', update_time = NOW() WHERE category_id = 14 AND price = 22.00;

-- category_id=15 的菜品
UPDATE dish SET description = '广东名菜，烧鹅皮脆肉嫩，色泽金黄，配以特制蘸料，香味浓郁', update_time = NOW() WHERE category_id = 15 AND price = 88.00;
UPDATE dish SET description = '广式早茶经典，虾饺皮薄馅大，虾肉鲜嫩Q弹，口感鲜美', update_time = NOW() WHERE category_id = 15 AND price = 25.00;
UPDATE dish SET description = '广东特色小吃，肠粉滑嫩，配以特制酱汁，口感丰富，营养美味', update_time = NOW() WHERE category_id = 15 AND price = 18.00;

-- category_id=17 的菜品
UPDATE dish SET description = '经典江浙菜，里脊肉外酥内嫩，配以糖醋汁，酸甜可口，老少皆宜', update_time = NOW() WHERE category_id = 17 AND price = 45.00;

-- category_id=18 的菜品
UPDATE dish SET description = '江苏名菜，桂鱼造型美观，外酥内嫩，配以糖醋汁，酸甜可口', update_time = NOW() WHERE category_id = 18 AND price = 98.00;

-- category_id=19 的菜品
UPDATE dish SET description = '浙江名菜，鱼肉鲜嫩，配以特制醋汁，酸甜适中，口感清爽', update_time = NOW() WHERE category_id = 19 AND price = 88.00;

-- category_id=20 的菜品
UPDATE dish SET description = '福建名菜，选用多种珍贵食材，文火慢炖，汤汁浓郁，营养丰富', update_time = NOW() WHERE category_id = 20 AND price = 288.00;

-- category_id=21 的菜品
UPDATE dish SET description = '安徽名菜，鳜鱼经过特殊腌制，肉质紧实，香味独特，回味悠长', update_time = NOW() WHERE category_id = 21 AND price = 88.00;

-- category_id=22 的菜品
UPDATE dish SET description = '北京名菜，烤鸭皮脆肉嫩，色泽红亮，配以薄饼和甜面酱，经典美味', update_time = NOW() WHERE category_id = 22 AND price = 188.00;

-- category_id=23 的菜品
UPDATE dish SET description = '经典家常菜，五花肉肥而不腻，色泽红亮，入口即化，香味浓郁', update_time = NOW() WHERE category_id = 23 AND price = 58.00;

-- category_id=24 的菜品
UPDATE dish SET description = '陕西特色小吃，羊肉鲜嫩，配以泡馍，汤汁浓郁，营养丰富', update_time = NOW() WHERE category_id = 24 AND price = 38.00;

-- 验证更新结果
SELECT id, category_id, name, price, LEFT(description, 40) as description_preview 
FROM dish 
WHERE (category_id = 13 AND price IN (30.00, 32.00, 68.00, 38.00))
   OR (category_id = 14 AND price IN (35.00, 45.00, 42.00, 22.00))
   OR (category_id = 15 AND price IN (88.00, 25.00, 18.00))
   OR (category_id = 17 AND price = 45.00)
   OR (category_id = 18 AND price = 98.00)
   OR (category_id = 19 AND price = 88.00)
   OR (category_id = 20 AND price = 288.00)
   OR (category_id = 21 AND price = 88.00)
   OR (category_id = 22 AND price = 188.00)
   OR (category_id = 23 AND price = 58.00)
   OR (category_id = 24 AND price = 38.00)
ORDER BY category_id, price;


