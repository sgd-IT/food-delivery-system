-- ============================================
-- 添加更多测试数据：菜品、套餐、订�?
-- 数据库名: sky_take_out
-- ============================================

USE `sky_take_out`;

-- ============================================
-- 1. 添加更多菜品数据（每个分类都有，总共�?0条）
-- ============================================

-- 湘菜 (category_id = 13)
INSERT INTO `dish` (`name`, `category_id`, `price`, `image`, `description`, `status`, `create_time`, `update_time`, `create_user`, `update_user`) VALUES
('湘西外婆�?, 13, 32.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '家常味道，下饭神�?, 1, NOW(), NOW(), 1, 1),
('干锅牛蛙', 13, 68.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '香辣下饭，口感丰�?, 1, NOW(), NOW(), 1, 1),
('湘味小炒�?, 13, 38.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '经典湘菜，香辣可�?, 1, NOW(), NOW(), 1, 1);

-- 川菜 (category_id = 14)
INSERT INTO `dish` (`name`, `category_id`, `price`, `image`, `description`, `status`, `create_time`, `update_time`, `create_user`, `update_user`) VALUES
('鱼香肉丝', 14, 35.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '酸甜微辣，经典川�?, 1, NOW(), NOW(), 1, 1),
('夫妻肺片', 14, 45.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '麻辣鲜香，下酒好�?, 1, NOW(), NOW(), 1, 1),
('口水�?, 14, 42.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '麻辣鲜香，开胃下�?, 1, NOW(), NOW(), 1, 1),
('担担�?, 14, 22.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '麻辣鲜香，经典面�?, 1, NOW(), NOW(), 1, 1);

-- 粤菜 (category_id = 15)
INSERT INTO `dish` (`name`, `category_id`, `price`, `image`, `description`, `status`, `create_time`, `update_time`, `create_user`, `update_user`) VALUES
('烧鹅', 15, 88.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '皮脆肉嫩，经典粤�?, 1, NOW(), NOW(), 1, 1),
('虾饺', 15, 25.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '晶莹剔透，鲜美可口', 1, NOW(), NOW(), 1, 1),
('肠粉', 15, 18.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '滑嫩爽口，经典点�?, 1, NOW(), NOW(), 1, 1),
('叉烧', 15, 58.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '香甜可口，经典粤�?, 1, NOW(), NOW(), 1, 1);

-- 东北�?(category_id = 16)
INSERT INTO `dish` (`name`, `category_id`, `price`, `image`, `description`, `status`, `create_time`, `update_time`, `create_user`, `update_user`) VALUES
('猪肉炖粉�?, 16, 42.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '家常美味，温暖下�?, 1, NOW(), NOW(), 1, 1),
('酸菜白肉', 16, 38.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '酸爽开胃，经典东北�?, 1, NOW(), NOW(), 1, 1),
('东北乱炖', 16, 48.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '营养丰富，温暖下�?, 1, NOW(), NOW(), 1, 1),
('酱骨�?, 16, 52.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '酱香浓郁，肉质鲜�?, 1, NOW(), NOW(), 1, 1);

-- 鲁菜 (category_id = 17)
INSERT INTO `dish` (`name`, `category_id`, `price`, `image`, `description`, `status`, `create_time`, `update_time`, `create_user`, `update_user`) VALUES
('糖醋里脊', 17, 45.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '酸甜可口，外酥内�?, 1, NOW(), NOW(), 1, 1),
('九转大肠', 17, 58.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '经典鲁菜，口感丰�?, 1, NOW(), NOW(), 1, 1),
('葱烧海参', 17, 128.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '营养丰富，鲜美可�?, 1, NOW(), NOW(), 1, 1),
('德州扒鸡', 17, 68.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '香嫩脱骨，经典鲁�?, 1, NOW(), NOW(), 1, 1);

-- 苏菜 (category_id = 18)
INSERT INTO `dish` (`name`, `category_id`, `price`, `image`, `description`, `status`, `create_time`, `update_time`, `create_user`, `update_user`) VALUES
('松鼠桂鱼', 18, 98.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '造型美观，酸甜可�?, 1, NOW(), NOW(), 1, 1),
('清炖狮子�?, 18, 68.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '鲜嫩多汁，入口即�?, 1, NOW(), NOW(), 1, 1),
('蟹粉小笼�?, 18, 35.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '汤汁丰富，鲜美可�?, 1, NOW(), NOW(), 1, 1),
('盐水�?, 18, 58.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '清淡鲜美，经典苏�?, 1, NOW(), NOW(), 1, 1);

-- 浙菜 (category_id = 19)
INSERT INTO `dish` (`name`, `category_id`, `price`, `image`, `description`, `status`, `create_time`, `update_time`, `create_user`, `update_user`) VALUES
('西湖醋鱼', 19, 88.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '酸甜鲜嫩，经典浙�?, 1, NOW(), NOW(), 1, 1),
('东坡�?, 19, 68.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '肥而不腻，入口即化', 1, NOW(), NOW(), 1, 1),
('龙井虾仁', 19, 98.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '清香淡雅，鲜美可�?, 1, NOW(), NOW(), 1, 1),
('叫花�?, 19, 78.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '香嫩多汁，传统名�?, 1, NOW(), NOW(), 1, 1);

-- 闽菜 (category_id = 20)
INSERT INTO `dish` (`name`, `category_id`, `price`, `image`, `description`, `status`, `create_time`, `update_time`, `create_user`, `update_user`) VALUES
('佛跳�?, 20, 288.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '营养丰富，鲜美无�?, 1, NOW(), NOW(), 1, 1),
('荔枝�?, 20, 48.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '酸甜可口，造型美观', 1, NOW(), NOW(), 1, 1),
('海蛎�?, 20, 38.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '鲜香可口，经典闽�?, 1, NOW(), NOW(), 1, 1),
('沙县扁肉', 20, 15.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '皮薄馅大，鲜美可�?, 1, NOW(), NOW(), 1, 1);

-- 徽菜 (category_id = 21)
INSERT INTO `dish` (`name`, `category_id`, `price`, `image`, `description`, `status`, `create_time`, `update_time`, `create_user`, `update_user`) VALUES
('臭鳜�?, 21, 88.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '闻着臭吃着香，经典徽菜', 1, NOW(), NOW(), 1, 1),
('毛豆�?, 21, 28.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '外酥内嫩，特色徽�?, 1, NOW(), NOW(), 1, 1),
('黄山炖鸽', 21, 68.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '营养丰富，滋补养�?, 1, NOW(), NOW(), 1, 1),
('徽州圆子', 21, 38.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '软糯香甜，传统名�?, 1, NOW(), NOW(), 1, 1);

-- 京菜 (category_id = 22)
INSERT INTO `dish` (`name`, `category_id`, `price`, `image`, `description`, `status`, `create_time`, `update_time`, `create_user`, `update_user`) VALUES
('北京烤鸭', 22, 188.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '皮脆肉嫩，经典京�?, 1, NOW(), NOW(), 1, 1),
('京酱肉丝', 22, 45.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '酱香浓郁，下饭好�?, 1, NOW(), NOW(), 1, 1),
('炸酱�?, 22, 25.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '经典面食，老北京味�?, 1, NOW(), NOW(), 1, 1),
('驴打�?, 22, 18.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '软糯香甜，传统点�?, 1, NOW(), NOW(), 1, 1);

-- 上海�?(category_id = 23)
INSERT INTO `dish` (`name`, `category_id`, `price`, `image`, `description`, `status`, `create_time`, `update_time`, `create_user`, `update_user`) VALUES
('红烧�?, 23, 58.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '浓油赤酱，经典本帮菜', 1, NOW(), NOW(), 1, 1),
('小笼�?, 23, 28.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '汤汁丰富，鲜美可�?, 1, NOW(), NOW(), 1, 1),
('糖醋排骨', 23, 45.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '酸甜可口，老少皆宜', 1, NOW(), NOW(), 1, 1),
('生煎�?, 23, 22.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '底部酥脆，汤汁丰�?, 1, NOW(), NOW(), 1, 1);

-- 西北�?(category_id = 24)
INSERT INTO `dish` (`name`, `category_id`, `price`, `image`, `description`, `status`, `create_time`, `update_time`, `create_user`, `update_user`) VALUES
('羊肉泡馍', 24, 38.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '汤浓肉烂，经典西北菜', 1, NOW(), NOW(), 1, 1),
('手抓羊肉', 24, 88.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '原汁原味，鲜嫩可�?, 1, NOW(), NOW(), 1, 1),
('兰州拉面', 24, 22.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '汤清面劲，经典面�?, 1, NOW(), NOW(), 1, 1),
('大盘�?, 24, 68.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '香辣下饭，分量十�?, 1, NOW(), NOW(), 1, 1);

-- ============================================
-- 2. 添加更多套餐数据
-- ============================================

-- 商务套餐 (category_id = 28)
INSERT INTO `setmeal` (`category_id`, `name`, `price`, `status`, `description`, `image`, `create_time`, `update_time`, `create_user`, `update_user`) VALUES
(28, '商务套餐C', 108.00, 1, '包含：北京烤�?京酱肉丝+时蔬+米饭+�?, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', NOW(), NOW(), 1, 1),
(28, '商务套餐D', 118.00, 1, '包含：烧�?白切�?时蔬+米饭+�?, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', NOW(), NOW(), 1, 1),
(28, '商务套餐E', 128.00, 1, '包含：松鼠桂�?清炖狮子�?时蔬+米饭+�?, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', NOW(), NOW(), 1, 1);

-- 情侣套餐 (category_id = 29)
INSERT INTO `setmeal` (`category_id`, `name`, `price`, `status`, `description`, `image`, `create_time`, `update_time`, `create_user`, `update_user`) VALUES
(29, '浪漫双人�?, 188.00, 1, '包含：松鼠桂�?龙井虾仁+时蔬+米饭+�?甜品', 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', NOW(), NOW(), 1, 1),
(29, '甜蜜套餐', 158.00, 1, '包含：糖醋里�?鱼香肉丝+时蔬+米饭+�?甜品', 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', NOW(), NOW(), 1, 1);

-- 儿童套餐 (category_id = 30)
INSERT INTO `setmeal` (`category_id`, `name`, `price`, `status`, `description`, `image`, `create_time`, `update_time`, `create_user`, `update_user`) VALUES
(30, '儿童营养�?, 42.00, 1, '包含：蒸�?小份糖醋里脊+时蔬+米饭+果汁', 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', NOW(), NOW(), 1, 1),
(30, '儿童快乐�?, 35.00, 1, '包含：小笼包+蒸蛋+时蔬+米饭+果汁', 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', NOW(), NOW(), 1, 1);

-- ============================================
-- 3. 添加套餐菜品关系数据（使用子查询获取实际ID�?
-- ============================================

-- 商务套餐C
INSERT INTO `setmeal_dish` (`setmeal_id`, `dish_id`, `name`, `price`, `copies`) 
SELECT (SELECT id FROM setmeal WHERE name = '商务套餐C' LIMIT 1), id, name, price, 1 
FROM dish WHERE name = '北京烤鸭' LIMIT 1;

INSERT INTO `setmeal_dish` (`setmeal_id`, `dish_id`, `name`, `price`, `copies`) 
SELECT (SELECT id FROM setmeal WHERE name = '商务套餐C' LIMIT 1), id, name, price, 1 
FROM dish WHERE name = '京酱肉丝' LIMIT 1;

-- 商务套餐D
INSERT INTO `setmeal_dish` (`setmeal_id`, `dish_id`, `name`, `price`, `copies`) 
SELECT (SELECT id FROM setmeal WHERE name = '商务套餐D' LIMIT 1), id, name, price, 1 
FROM dish WHERE name = '烧鹅' LIMIT 1;

INSERT INTO `setmeal_dish` (`setmeal_id`, `dish_id`, `name`, `price`, `copies`) 
SELECT (SELECT id FROM setmeal WHERE name = '商务套餐D' LIMIT 1), id, name, price, 1 
FROM dish WHERE name = '白切�? AND category_id = 15 LIMIT 1;

-- 商务套餐E
INSERT INTO `setmeal_dish` (`setmeal_id`, `dish_id`, `name`, `price`, `copies`) 
SELECT (SELECT id FROM setmeal WHERE name = '商务套餐E' LIMIT 1), id, name, price, 1 
FROM dish WHERE name = '松鼠桂鱼' LIMIT 1;

INSERT INTO `setmeal_dish` (`setmeal_id`, `dish_id`, `name`, `price`, `copies`) 
SELECT (SELECT id FROM setmeal WHERE name = '商务套餐E' LIMIT 1), id, name, price, 1 
FROM dish WHERE name = '清炖狮子�? LIMIT 1;

-- 浪漫双人�?
INSERT INTO `setmeal_dish` (`setmeal_id`, `dish_id`, `name`, `price`, `copies`) 
SELECT (SELECT id FROM setmeal WHERE name = '浪漫双人�? LIMIT 1), id, name, price, 1 
FROM dish WHERE name = '松鼠桂鱼' LIMIT 1;

INSERT INTO `setmeal_dish` (`setmeal_id`, `dish_id`, `name`, `price`, `copies`) 
SELECT (SELECT id FROM setmeal WHERE name = '浪漫双人�? LIMIT 1), id, name, price, 1 
FROM dish WHERE name = '龙井虾仁' LIMIT 1;

-- 甜蜜套餐
INSERT INTO `setmeal_dish` (`setmeal_id`, `dish_id`, `name`, `price`, `copies`) 
SELECT (SELECT id FROM setmeal WHERE name = '甜蜜套餐' LIMIT 1), id, name, price, 1 
FROM dish WHERE name = '糖醋里脊' LIMIT 1;

INSERT INTO `setmeal_dish` (`setmeal_id`, `dish_id`, `name`, `price`, `copies`) 
SELECT (SELECT id FROM setmeal WHERE name = '甜蜜套餐' LIMIT 1), id, name, price, 1 
FROM dish WHERE name = '鱼香肉丝' LIMIT 1;

-- 儿童营养�?
INSERT INTO `setmeal_dish` (`setmeal_id`, `dish_id`, `name`, `price`, `copies`) 
SELECT (SELECT id FROM setmeal WHERE name = '儿童营养�? LIMIT 1), id, name, price, 1 
FROM dish WHERE name = '糖醋里脊' LIMIT 1;

-- 儿童快乐�?
INSERT INTO `setmeal_dish` (`setmeal_id`, `dish_id`, `name`, `price`, `copies`) 
SELECT (SELECT id FROM setmeal WHERE name = '儿童快乐�? LIMIT 1), id, name, price, 1 
FROM dish WHERE name = '小笼�? LIMIT 1;

-- ============================================
-- 4. 添加订单数据（约50条订单）
-- ============================================
-- 注意：需要先有用户数据和地址数据，这里假设user_id=1, address_book_id=1

-- 插入50条订单数据（直接使用INSERT语句�?
INSERT INTO `orders` (`number`, `status`, `user_id`, `address_book_id`, `order_time`, `checkout_time`, `pay_method`, `pay_status`, `amount`, `remark`, `phone`, `address`, `user_name`, `consignee`, `order_type`) VALUES
(CONCAT('ORD', DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 1 HOUR), '%Y%m%d'), '000001'), 5, 1, 1, DATE_SUB(NOW(), INTERVAL 1 HOUR), DATE_SUB(NOW(), INTERVAL 1 HOUR), 1, 1, 126.00, '不要�?, '13800138001', '北京市朝阳区xxx街道xxx�?, '张三', '张三', 2),
(CONCAT('ORD', DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 2 HOUR), '%Y%m%d'), '000002'), 5, 1, 1, DATE_SUB(NOW(), INTERVAL 2 HOUR), DATE_SUB(NOW(), INTERVAL 2 HOUR), 1, 1, 88.00, NULL, '13800138001', '北京市朝阳区xxx街道xxx�?, '张三', '张三', 2),
(CONCAT('ORD', DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 3 HOUR), '%Y%m%d'), '000003'), 5, 1, 1, DATE_SUB(NOW(), INTERVAL 3 HOUR), DATE_SUB(NOW(), INTERVAL 3 HOUR), 2, 1, 168.00, '快点�?, '13800138001', '北京市朝阳区xxx街道xxx�?, '张三', '张三', 2),
(CONCAT('ORD', DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 4 HOUR), '%Y%m%d'), '000004'), 5, 1, 1, DATE_SUB(NOW(), INTERVAL 4 HOUR), DATE_SUB(NOW(), INTERVAL 4 HOUR), 1, 1, 98.00, NULL, '13800138001', '北京市朝阳区xxx街道xxx�?, '张三', '张三', 2),
(CONCAT('ORD', DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 5 HOUR), '%Y%m%d'), '000005'), 5, 1, 1, DATE_SUB(NOW(), INTERVAL 5 HOUR), DATE_SUB(NOW(), INTERVAL 5 HOUR), 2, 1, 156.00, '多放点菜', '13800138001', '北京市朝阳区xxx街道xxx�?, '张三', '张三', 2),
(CONCAT('ORD', DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 6 HOUR), '%Y%m%d'), '000006'), 5, 1, 1, DATE_SUB(NOW(), INTERVAL 6 HOUR), DATE_SUB(NOW(), INTERVAL 6 HOUR), 1, 1, 145.00, NULL, '13800138001', '北京市朝阳区xxx街道xxx�?, '张三', '张三', 2),
(CONCAT('ORD', DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 7 HOUR), '%Y%m%d'), '000007'), 5, 1, 1, DATE_SUB(NOW(), INTERVAL 7 HOUR), DATE_SUB(NOW(), INTERVAL 7 HOUR), 2, 1, 132.00, '不要�?, '13800138001', '北京市朝阳区xxx街道xxx�?, '张三', '张三', 2),
(CONCAT('ORD', DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 8 HOUR), '%Y%m%d'), '000008'), 5, 1, 1, DATE_SUB(NOW(), INTERVAL 8 HOUR), DATE_SUB(NOW(), INTERVAL 8 HOUR), 1, 1, 178.00, '快点�?, '13800138001', '北京市朝阳区xxx街道xxx�?, '张三', '张三', 2),
(CONCAT('ORD', DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 9 HOUR), '%Y%m%d'), '000009'), 5, 1, 1, DATE_SUB(NOW(), INTERVAL 9 HOUR), DATE_SUB(NOW(), INTERVAL 9 HOUR), 2, 1, 112.00, NULL, '13800138001', '北京市朝阳区xxx街道xxx�?, '张三', '张三', 2),
(CONCAT('ORD', DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 10 HOUR), '%Y%m%d'), '000010'), 5, 1, 1, DATE_SUB(NOW(), INTERVAL 10 HOUR), DATE_SUB(NOW(), INTERVAL 10 HOUR), 1, 1, 198.00, '多放点菜', '13800138001', '北京市朝阳区xxx街道xxx�?, '张三', '张三', 2),
(CONCAT('ORD', DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 11 HOUR), '%Y%m%d'), '000011'), 4, 1, 1, DATE_SUB(NOW(), INTERVAL 11 HOUR), DATE_SUB(NOW(), INTERVAL 11 HOUR), 2, 1, 165.00, NULL, '13800138001', '北京市朝阳区xxx街道xxx�?, '张三', '张三', 2),
(CONCAT('ORD', DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 12 HOUR), '%Y%m%d'), '000012'), 4, 1, 1, DATE_SUB(NOW(), INTERVAL 12 HOUR), DATE_SUB(NOW(), INTERVAL 12 HOUR), 1, 1, 142.00, '不要�?, '13800138001', '北京市朝阳区xxx街道xxx�?, '张三', '张三', 2),
(CONCAT('ORD', DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 13 HOUR), '%Y%m%d'), '000013'), 4, 1, 1, DATE_SUB(NOW(), INTERVAL 13 HOUR), DATE_SUB(NOW(), INTERVAL 13 HOUR), 2, 1, 188.00, '快点�?, '13800138001', '北京市朝阳区xxx街道xxx�?, '张三', '张三', 2),
(CONCAT('ORD', DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 14 HOUR), '%Y%m%d'), '000014'), 4, 1, 1, DATE_SUB(NOW(), INTERVAL 14 HOUR), DATE_SUB(NOW(), INTERVAL 14 HOUR), 1, 1, 125.00, NULL, '13800138001', '北京市朝阳区xxx街道xxx�?, '张三', '张三', 2),
(CONCAT('ORD', DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 15 HOUR), '%Y%m%d'), '000015'), 4, 1, 1, DATE_SUB(NOW(), INTERVAL 15 HOUR), DATE_SUB(NOW(), INTERVAL 15 HOUR), 2, 1, 155.00, '多放点菜', '13800138001', '北京市朝阳区xxx街道xxx�?, '张三', '张三', 2),
(CONCAT('ORD', DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 16 HOUR), '%Y%m%d'), '000016'), 4, 1, 1, DATE_SUB(NOW(), INTERVAL 16 HOUR), DATE_SUB(NOW(), INTERVAL 16 HOUR), 1, 1, 138.00, NULL, '13800138001', '北京市朝阳区xxx街道xxx�?, '张三', '张三', 2),
(CONCAT('ORD', DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 17 HOUR), '%Y%m%d'), '000017'), 4, 1, 1, DATE_SUB(NOW(), INTERVAL 17 HOUR), DATE_SUB(NOW(), INTERVAL 17 HOUR), 2, 1, 172.00, '不要�?, '13800138001', '北京市朝阳区xxx街道xxx�?, '张三', '张三', 2),
(CONCAT('ORD', DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 18 HOUR), '%Y%m%d'), '000018'), 4, 1, 1, DATE_SUB(NOW(), INTERVAL 18 HOUR), DATE_SUB(NOW(), INTERVAL 18 HOUR), 1, 1, 148.00, '快点�?, '13800138001', '北京市朝阳区xxx街道xxx�?, '张三', '张三', 2),
(CONCAT('ORD', DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 19 HOUR), '%Y%m%d'), '000019'), 4, 1, 1, DATE_SUB(NOW(), INTERVAL 19 HOUR), DATE_SUB(NOW(), INTERVAL 19 HOUR), 2, 1, 162.00, NULL, '13800138001', '北京市朝阳区xxx街道xxx�?, '张三', '张三', 2),
(CONCAT('ORD', DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 20 HOUR), '%Y%m%d'), '000020'), 4, 1, 1, DATE_SUB(NOW(), INTERVAL 20 HOUR), DATE_SUB(NOW(), INTERVAL 20 HOUR), 1, 1, 135.00, '多放点菜', '13800138001', '北京市朝阳区xxx街道xxx�?, '张三', '张三', 2),
(CONCAT('ORD', DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 21 HOUR), '%Y%m%d'), '000021'), 3, 1, 1, DATE_SUB(NOW(), INTERVAL 21 HOUR), DATE_SUB(NOW(), INTERVAL 21 HOUR), 2, 1, 185.00, NULL, '13800138001', '北京市朝阳区xxx街道xxx�?, '张三', '张三', 2),
(CONCAT('ORD', DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 22 HOUR), '%Y%m%d'), '000022'), 3, 1, 1, DATE_SUB(NOW(), INTERVAL 22 HOUR), DATE_SUB(NOW(), INTERVAL 22 HOUR), 1, 1, 152.00, '不要�?, '13800138001', '北京市朝阳区xxx街道xxx�?, '张三', '张三', 2),
(CONCAT('ORD', DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 23 HOUR), '%Y%m%d'), '000023'), 3, 1, 1, DATE_SUB(NOW(), INTERVAL 23 HOUR), DATE_SUB(NOW(), INTERVAL 23 HOUR), 2, 1, 168.00, '快点�?, '13800138001', '北京市朝阳区xxx街道xxx�?, '张三', '张三', 2),
(CONCAT('ORD', DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 24 HOUR), '%Y%m%d'), '000024'), 3, 1, 1, DATE_SUB(NOW(), INTERVAL 24 HOUR), DATE_SUB(NOW(), INTERVAL 24 HOUR), 1, 1, 142.00, NULL, '13800138001', '北京市朝阳区xxx街道xxx�?, '张三', '张三', 2),
(CONCAT('ORD', DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 25 HOUR), '%Y%m%d'), '000025'), 3, 1, 1, DATE_SUB(NOW(), INTERVAL 25 HOUR), DATE_SUB(NOW(), INTERVAL 25 HOUR), 2, 1, 175.00, '多放点菜', '13800138001', '北京市朝阳区xxx街道xxx�?, '张三', '张三', 2),
(CONCAT('ORD', DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 26 HOUR), '%Y%m%d'), '000026'), 3, 1, 1, DATE_SUB(NOW(), INTERVAL 26 HOUR), DATE_SUB(NOW(), INTERVAL 26 HOUR), 1, 1, 158.00, NULL, '13800138001', '北京市朝阳区xxx街道xxx�?, '张三', '张三', 2),
(CONCAT('ORD', DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 27 HOUR), '%Y%m%d'), '000027'), 3, 1, 1, DATE_SUB(NOW(), INTERVAL 27 HOUR), DATE_SUB(NOW(), INTERVAL 27 HOUR), 2, 1, 192.00, '不要�?, '13800138001', '北京市朝阳区xxx街道xxx�?, '张三', '张三', 2),
(CONCAT('ORD', DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 28 HOUR), '%Y%m%d'), '000028'), 3, 1, 1, DATE_SUB(NOW(), INTERVAL 28 HOUR), DATE_SUB(NOW(), INTERVAL 28 HOUR), 1, 1, 148.00, '快点�?, '13800138001', '北京市朝阳区xxx街道xxx�?, '张三', '张三', 2),
(CONCAT('ORD', DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 29 HOUR), '%Y%m%d'), '000029'), 3, 1, 1, DATE_SUB(NOW(), INTERVAL 29 HOUR), DATE_SUB(NOW(), INTERVAL 29 HOUR), 2, 1, 165.00, NULL, '13800138001', '北京市朝阳区xxx街道xxx�?, '张三', '张三', 2),
(CONCAT('ORD', DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 30 HOUR), '%Y%m%d'), '000030'), 3, 1, 1, DATE_SUB(NOW(), INTERVAL 30 HOUR), DATE_SUB(NOW(), INTERVAL 30 HOUR), 1, 1, 138.00, '多放点菜', '13800138001', '北京市朝阳区xxx街道xxx�?, '张三', '张三', 2),
(CONCAT('ORD', DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 31 HOUR), '%Y%m%d'), '000031'), 2, 1, 1, DATE_SUB(NOW(), INTERVAL 31 HOUR), NULL, 2, 0, 178.00, NULL, '13800138001', '北京市朝阳区xxx街道xxx�?, '张三', '张三', 2),
(CONCAT('ORD', DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 32 HOUR), '%Y%m%d'), '000032'), 2, 1, 1, DATE_SUB(NOW(), INTERVAL 32 HOUR), NULL, 1, 0, 152.00, '不要�?, '13800138001', '北京市朝阳区xxx街道xxx�?, '张三', '张三', 2),
(CONCAT('ORD', DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 33 HOUR), '%Y%m%d'), '000033'), 2, 1, 1, DATE_SUB(NOW(), INTERVAL 33 HOUR), NULL, 2, 0, 188.00, '快点�?, '13800138001', '北京市朝阳区xxx街道xxx�?, '张三', '张三', 2),
(CONCAT('ORD', DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 34 HOUR), '%Y%m%d'), '000034'), 2, 1, 1, DATE_SUB(NOW(), INTERVAL 34 HOUR), NULL, 1, 0, 125.00, NULL, '13800138001', '北京市朝阳区xxx街道xxx�?, '张三', '张三', 2),
(CONCAT('ORD', DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 35 HOUR), '%Y%m%d'), '000035'), 2, 1, 1, DATE_SUB(NOW(), INTERVAL 35 HOUR), NULL, 2, 0, 155.00, '多放点菜', '13800138001', '北京市朝阳区xxx街道xxx�?, '张三', '张三', 2),
(CONCAT('ORD', DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 36 HOUR), '%Y%m%d'), '000036'), 2, 1, 1, DATE_SUB(NOW(), INTERVAL 36 HOUR), NULL, 1, 0, 138.00, NULL, '13800138001', '北京市朝阳区xxx街道xxx�?, '张三', '张三', 2),
(CONCAT('ORD', DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 37 HOUR), '%Y%m%d'), '000037'), 2, 1, 1, DATE_SUB(NOW(), INTERVAL 37 HOUR), NULL, 2, 0, 172.00, '不要�?, '13800138001', '北京市朝阳区xxx街道xxx�?, '张三', '张三', 2),
(CONCAT('ORD', DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 38 HOUR), '%Y%m%d'), '000038'), 2, 1, 1, DATE_SUB(NOW(), INTERVAL 38 HOUR), NULL, 1, 0, 148.00, '快点�?, '13800138001', '北京市朝阳区xxx街道xxx�?, '张三', '张三', 2),
(CONCAT('ORD', DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 39 HOUR), '%Y%m%d'), '000039'), 2, 1, 1, DATE_SUB(NOW(), INTERVAL 39 HOUR), NULL, 2, 0, 162.00, NULL, '13800138001', '北京市朝阳区xxx街道xxx�?, '张三', '张三', 2),
(CONCAT('ORD', DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 40 HOUR), '%Y%m%d'), '000040'), 2, 1, 1, DATE_SUB(NOW(), INTERVAL 40 HOUR), NULL, 1, 0, 135.00, '多放点菜', '13800138001', '北京市朝阳区xxx街道xxx�?, '张三', '张三', 2),
(CONCAT('ORD', DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 41 HOUR), '%Y%m%d'), '000041'), 1, 1, 1, DATE_SUB(NOW(), INTERVAL 41 HOUR), NULL, 2, 0, 185.00, NULL, '13800138001', '北京市朝阳区xxx街道xxx�?, '张三', '张三', 2),
(CONCAT('ORD', DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 42 HOUR), '%Y%m%d'), '000042'), 1, 1, 1, DATE_SUB(NOW(), INTERVAL 42 HOUR), NULL, 1, 0, 152.00, '不要�?, '13800138001', '北京市朝阳区xxx街道xxx�?, '张三', '张三', 2),
(CONCAT('ORD', DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 43 HOUR), '%Y%m%d'), '000043'), 1, 1, 1, DATE_SUB(NOW(), INTERVAL 43 HOUR), NULL, 2, 0, 168.00, '快点�?, '13800138001', '北京市朝阳区xxx街道xxx�?, '张三', '张三', 2),
(CONCAT('ORD', DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 44 HOUR), '%Y%m%d'), '000044'), 1, 1, 1, DATE_SUB(NOW(), INTERVAL 44 HOUR), NULL, 1, 0, 142.00, NULL, '13800138001', '北京市朝阳区xxx街道xxx�?, '张三', '张三', 2),
(CONCAT('ORD', DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 45 HOUR), '%Y%m%d'), '000045'), 1, 1, 1, DATE_SUB(NOW(), INTERVAL 45 HOUR), NULL, 2, 0, 175.00, '多放点菜', '13800138001', '北京市朝阳区xxx街道xxx�?, '张三', '张三', 2),
(CONCAT('ORD', DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 46 HOUR), '%Y%m%d'), '000046'), 1, 1, 1, DATE_SUB(NOW(), INTERVAL 46 HOUR), NULL, 1, 0, 158.00, NULL, '13800138001', '北京市朝阳区xxx街道xxx�?, '张三', '张三', 2),
(CONCAT('ORD', DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 47 HOUR), '%Y%m%d'), '000047'), 1, 1, 1, DATE_SUB(NOW(), INTERVAL 47 HOUR), NULL, 2, 0, 192.00, '不要�?, '13800138001', '北京市朝阳区xxx街道xxx�?, '张三', '张三', 2),
(CONCAT('ORD', DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 48 HOUR), '%Y%m%d'), '000048'), 1, 1, 1, DATE_SUB(NOW(), INTERVAL 48 HOUR), NULL, 1, 0, 148.00, '快点�?, '13800138001', '北京市朝阳区xxx街道xxx�?, '张三', '张三', 2),
(CONCAT('ORD', DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 49 HOUR), '%Y%m%d'), '000049'), 1, 1, 1, DATE_SUB(NOW(), INTERVAL 49 HOUR), NULL, 2, 0, 165.00, NULL, '13800138001', '北京市朝阳区xxx街道xxx�?, '张三', '张三', 2),
(CONCAT('ORD', DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 50 HOUR), '%Y%m%d'), '000050'), 1, 1, 1, DATE_SUB(NOW(), INTERVAL 50 HOUR), NULL, 1, 0, 138.00, '多放点菜', '13800138001', '北京市朝阳区xxx街道xxx�?, '张三', '张三', 2);

-- ============================================
-- 5. 添加订单详情数据
-- ============================================
-- 注意：需要先执行订单插入，然后根据实际订单ID插入详情
-- 这里使用变量来获取最近插入的订单ID范围

SET @min_order_id = (SELECT COALESCE(MAX(id), 0) - 49 FROM orders);
SET @max_order_id = (SELECT COALESCE(MAX(id), 0) FROM orders);

-- 为每个订单添�?-2个菜�?
INSERT INTO `order_detail` (`name`, `order_id`, `dish_id`, `setmeal_id`, `dish_flavor`, `number`, `amount`, `image`)
SELECT 
    d.name,
    o.id,
    d.id,
    NULL,
    CASE 
        WHEN d.category_id IN (13, 14) THEN '微辣'
        ELSE '正常'
    END,
    FLOOR(1 + RAND() * 2) + 1,
    d.price * (FLOOR(1 + RAND() * 2) + 1),
    d.image
FROM (
    SELECT id FROM orders WHERE id >= @min_order_id AND id <= @max_order_id
) o
CROSS JOIN (
    SELECT id, name, price, image, category_id 
    FROM dish 
    WHERE status = 1 
    ORDER BY RAND() 
    LIMIT 1
) d
LIMIT 50;

-- 为部分订单添加第二个菜品
INSERT INTO `order_detail` (`name`, `order_id`, `dish_id`, `setmeal_id`, `dish_flavor`, `number`, `amount`, `image`)
SELECT 
    d.name,
    o.id,
    d.id,
    NULL,
    CASE 
        WHEN d.category_id IN (13, 14) THEN '中辣'
        ELSE '正常'
    END,
    FLOOR(1 + RAND() * 2) + 1,
    d.price * (FLOOR(1 + RAND() * 2) + 1),
    d.image
FROM (
    SELECT id FROM orders WHERE id >= @min_order_id AND id <= @max_order_id AND id % 2 = 0
) o
CROSS JOIN (
    SELECT id, name, price, image, category_id 
    FROM dish 
    WHERE status = 1 
    ORDER BY RAND() 
    LIMIT 1
) d
LIMIT 25;

-- 为部分订单添加套餐（�?个订单中有一个包含套餐）
INSERT INTO `order_detail` (`name`, `order_id`, `dish_id`, `setmeal_id`, `dish_flavor`, `number`, `amount`, `image`)
SELECT 
    s.name,
    o.id,
    NULL,
    s.id,
    NULL,
    1,
    s.price,
    s.image
FROM (
    SELECT id FROM orders WHERE id >= @min_order_id AND id <= @max_order_id AND id % 3 = 0
) o
CROSS JOIN (
    SELECT id, name, price, image 
    FROM setmeal 
    WHERE status = 1 
    ORDER BY RAND() 
    LIMIT 1
) s
LIMIT 17;
