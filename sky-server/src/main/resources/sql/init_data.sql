-- ============================================
-- 苍穹外卖项目初始化测试数�?
-- 数据库名: sky_take_out
-- ============================================

USE `sky_take_out`;

-- ============================================
-- 1. 插入分类数据
-- ============================================
-- 菜品分类
INSERT INTO `category` (`type`, `name`, `sort`, `status`, `create_time`, `update_time`, `create_user`, `update_user`) VALUES
(1, '湘菜', 1, 1, NOW(), NOW(), 1, 1),
(1, '川菜', 2, 1, NOW(), NOW(), 1, 1),
(1, '粤菜', 3, 1, NOW(), NOW(), 1, 1),
(1, '东北�?, 4, 1, NOW(), NOW(), 1, 1),
(1, '鲁菜', 5, 1, NOW(), NOW(), 1, 1),
(1, '苏菜', 6, 1, NOW(), NOW(), 1, 1),
(1, '浙菜', 7, 1, NOW(), NOW(), 1, 1),
(1, '闽菜', 8, 1, NOW(), NOW(), 1, 1),
(1, '徽菜', 9, 1, NOW(), NOW(), 1, 1),
(1, '京菜', 10, 1, NOW(), NOW(), 1, 1),
(1, '上海�?, 11, 1, NOW(), NOW(), 1, 1),
(1, '西北�?, 12, 1, NOW(), NOW(), 1, 1);

-- 套餐分类
INSERT INTO `category` (`type`, `name`, `sort`, `status`, `create_time`, `update_time`, `create_user`, `update_user`) VALUES
(2, '商务套餐', 1, 1, NOW(), NOW(), 1, 1),
(2, '情侣套餐', 2, 1, NOW(), NOW(), 1, 1),
(2, '儿童套餐', 3, 1, NOW(), NOW(), 1, 1);

-- ============================================
-- 2. 插入菜品数据
-- ============================================
-- 湘菜
INSERT INTO `dish` (`name`, `category_id`, `price`, `image`, `description`, `status`, `create_time`, `update_time`, `create_user`, `update_user`) VALUES
('剁椒鱼头', 1, 88.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '经典湘菜，鲜香麻�?, 1, NOW(), NOW(), 1, 1),
('口味�?, 1, 68.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '湖南特色，香辣可�?, 1, NOW(), NOW(), 1, 1),
('毛氏红烧�?, 1, 58.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '肥而不腻，入口即化', 1, NOW(), NOW(), 1, 1),
('小炒黄牛�?, 1, 48.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '鲜嫩爽滑，香辣下�?, 1, NOW(), NOW(), 1, 1);

-- 川菜
INSERT INTO `dish` (`name`, `category_id`, `price`, `image`, `description`, `status`, `create_time`, `update_time`, `create_user`, `update_user`) VALUES
('麻婆豆腐', 2, 28.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '经典川菜，麻辣鲜�?, 1, NOW(), NOW(), 1, 1),
('宫保鸡丁', 2, 38.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '酸甜微辣，口感丰�?, 1, NOW(), NOW(), 1, 1),
('水煮�?, 2, 78.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '麻辣鲜香，鱼肉鲜�?, 1, NOW(), NOW(), 1, 1),
('回锅�?, 2, 42.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '肥瘦相间，香辣下�?, 1, NOW(), NOW(), 1, 1);

-- 粤菜
INSERT INTO `dish` (`name`, `category_id`, `price`, `image`, `description`, `status`, `create_time`, `update_time`, `create_user`, `update_user`) VALUES
('白切�?, 3, 48.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '清淡鲜美，原汁原�?, 1, NOW(), NOW(), 1, 1),
('叉烧�?, 3, 18.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '香甜软糯，经典点�?, 1, NOW(), NOW(), 1, 1),
('蒸排�?, 3, 38.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '鲜嫩多汁，营养丰�?, 1, NOW(), NOW(), 1, 1),
('煲仔�?, 3, 32.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '香气四溢，米饭香�?, 1, NOW(), NOW(), 1, 1);

-- 东北�?
INSERT INTO `dish` (`name`, `category_id`, `price`, `image`, `description`, `status`, `create_time`, `update_time`, `create_user`, `update_user`) VALUES
('锅包�?, 4, 45.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '外酥内嫩，酸甜可�?, 1, NOW(), NOW(), 1, 1),
('地三�?, 4, 28.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '经典素菜，营养丰�?, 1, NOW(), NOW(), 1, 1),
('小鸡炖蘑�?, 4, 58.00, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', '鲜香浓郁，滋补养�?, 1, NOW(), NOW(), 1, 1);

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
(7, '配菜', '["豆芽","白菜","金针�?]');

-- ============================================
-- 4. 插入套餐数据
-- ============================================
INSERT INTO `setmeal` (`category_id`, `name`, `price`, `status`, `description`, `image`, `create_time`, `update_time`, `create_user`, `update_user`) VALUES
(28, '商务套餐A', 88.00, 1, '包含：白切鸡+蒸排�?时蔬+米饭+�?, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', NOW(), NOW(), 1, 1),
(28, '商务套餐B', 98.00, 1, '包含：水煮鱼+宫保鸡丁+时蔬+米饭+�?, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', NOW(), NOW(), 1, 1),
(29, '情侣套餐', 168.00, 1, '包含：剁椒鱼�?小炒黄牛�?时蔬+米饭+�?甜品', 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', NOW(), NOW(), 1, 1),
(30, '儿童套餐', 38.00, 1, '包含：蒸�?小份白切�?米饭+果汁', 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80', NOW(), NOW(), 1, 1);

-- ============================================
-- 5. 插入套餐菜品关系数据
-- ============================================
-- 商务套餐A
INSERT INTO `setmeal_dish` (`setmeal_id`, `dish_id`, `name`, `price`, `copies`) VALUES
(1, 9, '白切�?, 48.00, 1),
(1, 11, '蒸排�?, 38.00, 1);

-- 商务套餐B
INSERT INTO `setmeal_dish` (`setmeal_id`, `dish_id`, `name`, `price`, `copies`) VALUES
(2, 7, '水煮�?, 78.00, 1),
(2, 6, '宫保鸡丁', 38.00, 1);

-- 情侣套餐
INSERT INTO `setmeal_dish` (`setmeal_id`, `dish_id`, `name`, `price`, `copies`) VALUES
(3, 1, '剁椒鱼头', 88.00, 1),
(3, 4, '小炒黄牛�?, 48.00, 1);

-- 儿童套餐
INSERT INTO `setmeal_dish` (`setmeal_id`, `dish_id`, `name`, `price`, `copies`) VALUES
(4, 9, '白切�?, 48.00, 1);

