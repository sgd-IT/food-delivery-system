-- ============================================
-- 云味道外卖项目初始化测试数据
-- 数据库名: food_delivery_system
-- 说明: 包含分类、菜品、套餐、用户、地址等完整测试数据
-- ============================================

USE `food_delivery_system`;

-- ============================================
-- 1. 插入分类数据
-- ============================================
-- 菜品分类
INSERT INTO `category` (`type`, `name`, `sort`, `status`, `create_time`, `update_time`, `create_user`, `update_user`) VALUES
(1, '湘菜', 1, 1, NOW(), NOW(), 1, 1),
(1, '川菜', 2, 1, NOW(), NOW(), 1, 1),
(1, '粤菜', 3, 1, NOW(), NOW(), 1, 1),
(1, '东北菜', 4, 1, NOW(), NOW(), 1, 1),
(1, '鲁菜', 5, 1, NOW(), NOW(), 1, 1),
(1, '苏菜', 6, 1, NOW(), NOW(), 1, 1),
(1, '浙菜', 7, 1, NOW(), NOW(), 1, 1),
(1, '闽菜', 8, 1, NOW(), NOW(), 1, 1),
(1, '徽菜', 9, 1, NOW(), NOW(), 1, 1),
(1, '京菜', 10, 1, NOW(), NOW(), 1, 1),
(1, '上海菜', 11, 1, NOW(), NOW(), 1, 1),
(1, '西北菜', 12, 1, NOW(), NOW(), 1, 1);

-- 套餐分类
INSERT INTO `category` (`type`, `name`, `sort`, `status`, `create_time`, `update_time`, `create_user`, `update_user`) VALUES
(2, '商务套餐', 1, 1, NOW(), NOW(), 1, 1),
(2, '情侣套餐', 2, 1, NOW(), NOW(), 1, 1),
(2, '儿童套餐', 3, 1, NOW(), NOW(), 1, 1);

-- ============================================
-- 2. 插入菜品数据
-- ============================================
-- 湘菜 (category_id = 1)
INSERT INTO `dish` (`name`, `category_id`, `price`, `image`, `description`, `status`, `create_time`, `update_time`, `create_user`, `update_user`) VALUES
('剁椒鱼头', 1, 88.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '经典湘菜，鲜香麻辣', 1, NOW(), NOW(), 1, 1),
('口味虾', 1, 68.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '湖南特色，香辣可口', 1, NOW(), NOW(), 1, 1),
('毛氏红烧肉', 1, 58.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '肥而不腻，入口即化', 1, NOW(), NOW(), 1, 1),
('小炒黄牛肉', 1, 48.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '鲜嫩爽滑，香辣下饭', 1, NOW(), NOW(), 1, 1);

-- 川菜 (category_id = 2)
INSERT INTO `dish` (`name`, `category_id`, `price`, `image`, `description`, `status`, `create_time`, `update_time`, `create_user`, `update_user`) VALUES
('麻婆豆腐', 2, 28.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '经典川菜，麻辣鲜香', 1, NOW(), NOW(), 1, 1),
('宫保鸡丁', 2, 38.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '酸甜微辣，口感丰富', 1, NOW(), NOW(), 1, 1),
('水煮鱼', 2, 78.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '麻辣鲜香，鱼肉鲜嫩', 1, NOW(), NOW(), 1, 1),
('回锅肉', 2, 42.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '肥瘦相间，香辣下饭', 1, NOW(), NOW(), 1, 1);

-- 粤菜 (category_id = 3)
INSERT INTO `dish` (`name`, `category_id`, `price`, `image`, `description`, `status`, `create_time`, `update_time`, `create_user`, `update_user`) VALUES
('白切鸡', 3, 48.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '清淡鲜美，原汁原味', 1, NOW(), NOW(), 1, 1),
('叉烧包', 3, 18.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '香甜软糯，经典点心', 1, NOW(), NOW(), 1, 1),
('蒸排骨', 3, 38.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '鲜嫩多汁，营养丰富', 1, NOW(), NOW(), 1, 1),
('煲仔饭', 3, 32.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '香气四溢，米饭香糯', 1, NOW(), NOW(), 1, 1);

-- 东北菜 (category_id = 4)
INSERT INTO `dish` (`name`, `category_id`, `price`, `image`, `description`, `status`, `create_time`, `update_time`, `create_user`, `update_user`) VALUES
('锅包肉', 4, 45.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '外酥内嫩，酸甜可口', 1, NOW(), NOW(), 1, 1),
('地三鲜', 4, 28.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '经典素菜，营养丰富', 1, NOW(), NOW(), 1, 1),
('小鸡炖蘑菇', 4, 58.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '鲜香浓郁，滋补养生', 1, NOW(), NOW(), 1, 1);

-- ============================================
-- 3. 插入菜品口味数据
-- ============================================
-- 为部分菜品添加口味选项
INSERT INTO `dish_flavor` (`dish_id`, `name`, `value`) VALUES
(1, '辣度', '["微辣","中辣","重辣"]'),
(1, '口味', '["正常","少盐","多盐"]'),
(2, '辣度', '["微辣","中辣","重辣"]'),
(5, '辣度', '["微辣","中辣","重辣"]'),
(5, '口味', '["正常","少盐","多盐"]'),
(7, '辣度', '["微辣","中辣","重辣","特辣"]'),
(7, '配菜', '["豆芽","白菜","金针菇"]');

-- ============================================
-- 4. 插入套餐数据
-- ============================================
-- 商务套餐 (category_id = 13)
INSERT INTO `setmeal` (`category_id`, `name`, `price`, `status`, `description`, `image`, `create_time`, `update_time`, `create_user`, `update_user`) VALUES
(13, '商务套餐A', 88.00, 1, '包含：白切鸡+蒸排骨+时蔬+米饭+汤', 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', NOW(), NOW(), 1, 1),
(13, '商务套餐B', 98.00, 1, '包含：水煮鱼+宫保鸡丁+时蔬+米饭+汤', 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', NOW(), NOW(), 1, 1);

-- 情侣套餐 (category_id = 14)
INSERT INTO `setmeal` (`category_id`, `name`, `price`, `status`, `description`, `image`, `create_time`, `update_time`, `create_user`, `update_user`) VALUES
(14, '情侣套餐', 168.00, 1, '包含：剁椒鱼头+小炒黄牛肉+时蔬+米饭+汤+甜品', 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', NOW(), NOW(), 1, 1);

-- 儿童套餐 (category_id = 15)
INSERT INTO `setmeal` (`category_id`, `name`, `price`, `status`, `description`, `image`, `create_time`, `update_time`, `create_user`, `update_user`) VALUES
(15, '儿童套餐', 38.00, 1, '包含：蒸蛋+小份白切鸡+米饭+果汁', 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', NOW(), NOW(), 1, 1);

-- ============================================
-- 5. 插入套餐菜品关系数据
-- ============================================
-- 商务套餐A
INSERT INTO `setmeal_dish` (`setmeal_id`, `dish_id`, `name`, `price`, `copies`) 
SELECT (SELECT id FROM setmeal WHERE name = '商务套餐A' LIMIT 1), id, name, price, 1 
FROM dish WHERE name = '白切鸡' LIMIT 1;

INSERT INTO `setmeal_dish` (`setmeal_id`, `dish_id`, `name`, `price`, `copies`) 
SELECT (SELECT id FROM setmeal WHERE name = '商务套餐A' LIMIT 1), id, name, price, 1 
FROM dish WHERE name = '蒸排骨' LIMIT 1;

-- 商务套餐B
INSERT INTO `setmeal_dish` (`setmeal_id`, `dish_id`, `name`, `price`, `copies`) 
SELECT (SELECT id FROM setmeal WHERE name = '商务套餐B' LIMIT 1), id, name, price, 1 
FROM dish WHERE name = '水煮鱼' LIMIT 1;

INSERT INTO `setmeal_dish` (`setmeal_id`, `dish_id`, `name`, `price`, `copies`) 
SELECT (SELECT id FROM setmeal WHERE name = '商务套餐B' LIMIT 1), id, name, price, 1 
FROM dish WHERE name = '宫保鸡丁' LIMIT 1;

-- 情侣套餐
INSERT INTO `setmeal_dish` (`setmeal_id`, `dish_id`, `name`, `price`, `copies`) 
SELECT (SELECT id FROM setmeal WHERE name = '情侣套餐' LIMIT 1), id, name, price, 1 
FROM dish WHERE name = '剁椒鱼头' LIMIT 1;

INSERT INTO `setmeal_dish` (`setmeal_id`, `dish_id`, `name`, `price`, `copies`) 
SELECT (SELECT id FROM setmeal WHERE name = '情侣套餐' LIMIT 1), id, name, price, 1 
FROM dish WHERE name = '小炒黄牛肉' LIMIT 1;

-- 儿童套餐
INSERT INTO `setmeal_dish` (`setmeal_id`, `dish_id`, `name`, `price`, `copies`) 
SELECT (SELECT id FROM setmeal WHERE name = '儿童套餐' LIMIT 1), id, name, price, 1 
FROM dish WHERE name = '白切鸡' LIMIT 1;

-- ============================================
-- 6. 插入测试用户数据
-- ============================================
INSERT INTO `user` (`openid`, `name`, `phone`, `sex`, `create_time`) VALUES
('test_openid_001', '张三', '13800138001', '1', NOW());

-- ============================================
-- 7. 插入地址数据
-- ============================================
SET @user_id = (SELECT id FROM `user` WHERE openid = 'test_openid_001' LIMIT 1);

INSERT INTO `address_book` 
    (`user_id`, `consignee`, `phone`, `sex`, `province_code`, `province_name`, 
     `city_code`, `city_name`, `district_code`, `district_name`, `detail`, 
     `label`, `is_default`) VALUES
    (@user_id, '张三', '13800138001', '1', '110000', '北京市', '110100', '北京市', '110101', '朝阳区', '北京市朝阳区xxx街道xxx号', '家', 1),
    (@user_id, '木东', '13800138004', '1', '440000', '广东省', '441900', '东莞市', '441900', '石排镇', '广东科技学院A4宿舍楼', '学校', 0),
    (@user_id, '木东', '13800138005', '1', '440000', '广东省', '441900', '东莞市', '441900', '石排镇', '广东科技学院A5宿舍楼', '学校', 0),
    (@user_id, '木东', '13800138006', '1', '440000', '广东省', '441900', '东莞市', '441900', '石排镇', '广东科技学院A6宿舍楼', '学校', 0),
    (@user_id, '木东', '13800138007', '1', '440000', '广东省', '441900', '东莞市', '441900', '石排镇', '广东科技学院A7宿舍楼', '学校', 0),
    (@user_id, '木东', '13800138008', '1', '440000', '广东省', '441900', '东莞市', '441900', '石排镇', '广东科技学院A8宿舍楼', '学校', 0),
    (@user_id, '木东', '13800138009', '1', '440000', '广东省', '441900', '东莞市', '441900', '石排镇', '广东科技学院A9宿舍楼', '学校', 0),
    (@user_id, '木东', '13800138010', '1', '440000', '广东省', '441900', '东莞市', '441900', '石排镇', '广东科技学院A10宿舍楼', '学校', 0);
