USE food_delivery_system;
SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

UPDATE dish SET description = '青椒与红椒的完美搭配，色彩鲜艳，口感爽脆，微辣开胃', update_time = NOW() WHERE id = 16;
UPDATE dish SET description = '湘西特色家常菜，选用优质外婆菜，口感鲜香，下饭神器', update_time = NOW() WHERE id = 17 AND (description IS NULL OR description = '');
UPDATE dish SET description = '干锅系列经典菜品，牛蛙肉质鲜嫩，配以多种香料，香辣过瘾', update_time = NOW() WHERE id = 18 AND (description IS NULL OR description = '');
UPDATE dish SET description = '湖南经典小炒，猪肉鲜嫩，配以青椒，香辣下饭', update_time = NOW() WHERE id = 19 AND (description IS NULL OR description = '');
UPDATE dish SET description = '经典川菜，肉丝鲜嫩，配以木耳、胡萝卜丝，酸甜微辣，口感丰富', update_time = NOW() WHERE id = 20 AND (description IS NULL OR description = '');
UPDATE dish SET description = '四川传统名菜，牛肉和牛杂配以特制调料，麻辣鲜香，回味无穷', update_time = NOW() WHERE id = 21 AND (description IS NULL OR description = '');
UPDATE dish SET description = '四川特色凉菜，鸡肉鲜嫩，配以特制调料，麻辣鲜香，开胃爽口', update_time = NOW() WHERE id = 22 AND (description IS NULL OR description = '');
UPDATE dish SET description = '四川传统面食，面条劲道，配以肉末和特制调料，麻辣鲜香', update_time = NOW() WHERE id = 23 AND (description IS NULL OR description = '');
UPDATE dish SET description = '广东名菜，烧鹅皮脆肉嫩，色泽金黄，配以特制蘸料，香味浓郁', update_time = NOW() WHERE id = 24 AND (description IS NULL OR description = '');
UPDATE dish SET description = '广式早茶经典，虾饺皮薄馅大，虾肉鲜嫩Q弹，口感鲜美', update_time = NOW() WHERE id = 25 AND (description IS NULL OR description = '');
UPDATE dish SET description = '广东特色小吃，肠粉滑嫩，配以特制酱汁，口感丰富，营养美味', update_time = NOW() WHERE id = 26 AND (description IS NULL OR description = '');
UPDATE dish SET description = '经典江浙菜，里脊肉外酥内嫩，配以糖醋汁，酸甜可口，老少皆宜', update_time = NOW() WHERE id = 32 AND (description IS NULL OR description = '');
UPDATE dish SET description = '江苏名菜，桂鱼造型美观，外酥内嫩，配以糖醋汁，酸甜可口', update_time = NOW() WHERE id = 36 AND (description IS NULL OR description = '');
UPDATE dish SET description = '浙江名菜，鱼肉鲜嫩，配以特制醋汁，酸甜适中，口感清爽', update_time = NOW() WHERE id = 40 AND (description IS NULL OR description = '');
UPDATE dish SET description = '福建名菜，选用多种珍贵食材，文火慢炖，汤汁浓郁，营养丰富', update_time = NOW() WHERE id = 44 AND (description IS NULL OR description = '');
UPDATE dish SET description = '安徽名菜，鳜鱼经过特殊腌制，肉质紧实，香味独特，回味悠长', update_time = NOW() WHERE id = 48 AND (description IS NULL OR description = '');
UPDATE dish SET description = '北京名菜，烤鸭皮脆肉嫩，色泽红亮，配以薄饼和甜面酱，经典美味', update_time = NOW() WHERE id = 52 AND (description IS NULL OR description = '');
UPDATE dish SET description = '经典家常菜，五花肉肥而不腻，色泽红亮，入口即化，香味浓郁', update_time = NOW() WHERE id = 56 AND (description IS NULL OR description = '');
UPDATE dish SET description = '陕西特色小吃，羊肉鲜嫩，配以泡馍，汤汁浓郁，营养丰富', update_time = NOW() WHERE id = 60 AND (description IS NULL OR description = '');

SELECT id, name, LEFT(description, 50) as description FROM dish WHERE id IN (16,17,18,19,20,21,22,23,24,25,26,32,36,40,44,48,52,56,60) ORDER BY id;

