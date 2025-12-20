-- ============================================
-- 为当前登录用户添加订单数据
-- 使用说明：
-- 1. 先执行查询语句获取当前用户ID（根据openid或最新用户）
-- 2. 如果没有地址，会先创建一个默认地址
-- 3. 然后创建订单和订单明细
-- ============================================

USE `food_delivery_system`;

-- ============================================
-- 步骤1: 查询当前用户ID（请根据实际情况修改openid）
-- ============================================
-- 方式1: 根据openid查询（请替换为实际的openid）
-- SET @user_id = (SELECT id FROM `user` WHERE openid = '你的openid' LIMIT 1);

-- 方式2: 使用最新创建的用户（推荐用于测试）
SET @user_id = (SELECT id FROM `user` ORDER BY create_time DESC LIMIT 1);

-- 显示当前用户ID
SELECT @user_id AS current_user_id, 
       (SELECT openid FROM `user` WHERE id = @user_id) AS openid;

-- ============================================
-- 步骤2: 检查并创建默认地址（如果没有地址）
-- ============================================
SET @address_id = (SELECT id FROM `address_book` WHERE user_id = @user_id LIMIT 1);

-- 如果没有地址，创建一个默认地址
INSERT INTO `address_book` 
    (`user_id`, `consignee`, `phone`, `sex`, `province_code`, `province_name`, 
     `city_code`, `city_name`, `district_code`, `district_name`, `detail`, 
     `label`, `is_default`)
SELECT 
    @user_id,
    'Zhang San',
    '13800138000',
    '1',
    '110000',
    'Beijing',
    '110100',
    'Beijing',
    '110101',
    'Dongcheng',
    'Test Street 123',
    '2',
    1
WHERE NOT EXISTS (SELECT 1 FROM `address_book` WHERE user_id = @user_id);

-- 获取地址ID
SET @address_id = (SELECT id FROM `address_book` WHERE user_id = @user_id LIMIT 1);

-- ============================================
-- 步骤3: 查询一些菜品ID用于订单明细
-- ============================================
SET @dish_id_1 = (SELECT id FROM `dish` WHERE status = 1 LIMIT 1);
SET @dish_id_2 = (SELECT id FROM `dish` WHERE status = 1 AND id != @dish_id_1 LIMIT 1);
SET @dish_id_3 = (SELECT id FROM `dish` WHERE status = 1 AND id != @dish_id_1 AND id != @dish_id_2 LIMIT 1);

-- 如果菜品不足，使用第一个菜品
SET @dish_id_2 = IFNULL(@dish_id_2, @dish_id_1);
SET @dish_id_3 = IFNULL(@dish_id_3, @dish_id_1);

-- ============================================
-- 步骤4: 创建订单（多个不同状态的订单用于测试）
-- ============================================

-- 订单1: 待付款
INSERT INTO `orders` 
    (`number`, `status`, `user_id`, `address_book_id`, `order_time`, 
     `pay_method`, `pay_status`, `amount`, `remark`, `phone`, `address`, 
     `user_name`, `consignee`, `pack_amount`, `tableware_number`, `tableware_status`, `order_type`)
SELECT 
    CONCAT('ORDER', UNIX_TIMESTAMP(NOW()), '001'),
    1, -- 待付款
    @user_id,
    @address_id,
    NOW(),
    1, -- 微信支付
    0, -- 未支付
    128.00,
    '请尽快送达',
    (SELECT phone FROM `address_book` WHERE id = @address_id),
    (SELECT detail FROM `address_book` WHERE id = @address_id),
    (SELECT name FROM `user` WHERE id = @user_id),
    (SELECT consignee FROM `address_book` WHERE id = @address_id),
    2, -- 打包费
    2, -- 餐具数量
    0, -- 选择具体数量
    2; -- 外卖配送

SET @order_id_1 = LAST_INSERT_ID();

-- 订单2: 待接单
INSERT INTO `orders` 
    (`number`, `status`, `user_id`, `address_book_id`, `order_time`, 
     `pay_method`, `pay_status`, `amount`, `remark`, `phone`, `address`, 
     `user_name`, `consignee`, `pack_amount`, `tableware_number`, `tableware_status`, `order_type`)
SELECT 
    CONCAT('ORDER', UNIX_TIMESTAMP(NOW()), '002'),
    2, -- 待接单
    @user_id,
    @address_id,
    DATE_SUB(NOW(), INTERVAL 10 MINUTE),
    1, -- 微信支付
    1, -- 已支付
    88.00,
    '不要辣',
    (SELECT phone FROM `address_book` WHERE id = @address_id),
    (SELECT detail FROM `address_book` WHERE id = @address_id),
    (SELECT name FROM `user` WHERE id = @user_id),
    (SELECT consignee FROM `address_book` WHERE id = @address_id),
    2,
    1,
    0,
    2;

SET @order_id_2 = LAST_INSERT_ID();

-- 订单3: 已接单
INSERT INTO `orders` 
    (`number`, `status`, `user_id`, `address_book_id`, `order_time`, 
     `pay_method`, `pay_status`, `amount`, `remark`, `phone`, `address`, 
     `user_name`, `consignee`, `pack_amount`, `tableware_number`, `tableware_status`, `order_type`)
SELECT 
    CONCAT('ORDER', UNIX_TIMESTAMP(NOW()), '003'),
    3, -- 已接单
    @user_id,
    @address_id,
    DATE_SUB(NOW(), INTERVAL 30 MINUTE),
    1,
    1,
    156.00,
    '谢谢',
    (SELECT phone FROM `address_book` WHERE id = @address_id),
    (SELECT detail FROM `address_book` WHERE id = @address_id),
    (SELECT name FROM `user` WHERE id = @user_id),
    (SELECT consignee FROM `address_book` WHERE id = @address_id),
    2,
    2,
    0,
    2;

SET @order_id_3 = LAST_INSERT_ID();

-- 订单4: 派送中
INSERT INTO `orders` 
    (`number`, `status`, `user_id`, `address_book_id`, `order_time`, 
     `pay_method`, `pay_status`, `amount`, `remark`, `phone`, `address`, 
     `user_name`, `consignee`, `pack_amount`, `tableware_number`, `tableware_status`, `order_type`)
SELECT 
    CONCAT('ORDER', UNIX_TIMESTAMP(NOW()), '004'),
    4, -- 派送中
    @user_id,
    @address_id,
    DATE_SUB(NOW(), INTERVAL 1 HOUR),
    1,
    1,
    98.00,
    NULL,
    (SELECT phone FROM `address_book` WHERE id = @address_id),
    (SELECT detail FROM `address_book` WHERE id = @address_id),
    (SELECT name FROM `user` WHERE id = @user_id),
    (SELECT consignee FROM `address_book` WHERE id = @address_id),
    2,
    1,
    0,
    2;

SET @order_id_4 = LAST_INSERT_ID();

-- 订单5: 已完成
INSERT INTO `orders` 
    (`number`, `status`, `user_id`, `address_book_id`, `order_time`, 
     `checkout_time`, `pay_method`, `pay_status`, `amount`, `remark`, `phone`, `address`, 
     `user_name`, `consignee`, `pack_amount`, `tableware_number`, `tableware_status`, `order_type`)
SELECT 
    CONCAT('ORDER', UNIX_TIMESTAMP(NOW()), '005'),
    5, -- 已完成
    @user_id,
    @address_id,
    DATE_SUB(NOW(), INTERVAL 2 DAY),
    DATE_SUB(NOW(), INTERVAL 2 DAY),
    1,
    1,
    168.00,
    '很好吃',
    (SELECT phone FROM `address_book` WHERE id = @address_id),
    (SELECT detail FROM `address_book` WHERE id = @address_id),
    (SELECT name FROM `user` WHERE id = @user_id),
    (SELECT consignee FROM `address_book` WHERE id = @address_id),
    2,
    2,
    0,
    2;

SET @order_id_5 = LAST_INSERT_ID();

-- ============================================
-- 步骤5: 创建订单明细
-- ============================================

-- 订单1的明细
INSERT INTO `order_detail` (`name`, `order_id`, `dish_id`, `dish_flavor`, `number`, `amount`, `image`)
SELECT 
    d.name,
    @order_id_1,
    d.id,
    '微辣',
    2,
    d.price * 2,
    d.image
FROM `dish` d
WHERE d.id = @dish_id_1;

INSERT INTO `order_detail` (`name`, `order_id`, `dish_id`, `dish_flavor`, `number`, `amount`, `image`)
SELECT 
    d.name,
    @order_id_1,
    d.id,
    '不辣',
    1,
    d.price,
    d.image
FROM `dish` d
WHERE d.id = @dish_id_2;

-- 订单2的明细
INSERT INTO `order_detail` (`name`, `order_id`, `dish_id`, `dish_flavor`, `number`, `amount`, `image`)
SELECT 
    d.name,
    @order_id_2,
    d.id,
    '中辣',
    1,
    d.price,
    d.image
FROM `dish` d
WHERE d.id = @dish_id_1;

INSERT INTO `order_detail` (`name`, `order_id`, `dish_id`, `dish_flavor`, `number`, `amount`, `image`)
SELECT 
    d.name,
    @order_id_2,
    d.id,
    '微辣',
    2,
    d.price * 2,
    d.image
FROM `dish` d
WHERE d.id = @dish_id_2;

-- 订单3的明细
INSERT INTO `order_detail` (`name`, `order_id`, `dish_id`, `dish_flavor`, `number`, `amount`, `image`)
SELECT 
    d.name,
    @order_id_3,
    d.id,
    '不辣',
    2,
    d.price * 2,
    d.image
FROM `dish` d
WHERE d.id = @dish_id_1;

INSERT INTO `order_detail` (`name`, `order_id`, `dish_id`, `dish_flavor`, `number`, `amount`, `image`)
SELECT 
    d.name,
    @order_id_3,
    d.id,
    '微辣',
    1,
    d.price,
    d.image
FROM `dish` d
WHERE d.id = @dish_id_2;

INSERT INTO `order_detail` (`name`, `order_id`, `dish_id`, `dish_flavor`, `number`, `amount`, `image`)
SELECT 
    d.name,
    @order_id_3,
    d.id,
    '中辣',
    1,
    d.price,
    d.image
FROM `dish` d
WHERE d.id = @dish_id_3;

-- 订单4的明细
INSERT INTO `order_detail` (`name`, `order_id`, `dish_id`, `dish_flavor`, `number`, `amount`, `image`)
SELECT 
    d.name,
    @order_id_4,
    d.id,
    '微辣',
    1,
    d.price,
    d.image
FROM `dish` d
WHERE d.id = @dish_id_1;

INSERT INTO `order_detail` (`name`, `order_id`, `dish_id`, `dish_flavor`, `number`, `amount`, `image`)
SELECT 
    d.name,
    @order_id_4,
    d.id,
    '不辣',
    2,
    d.price * 2,
    d.image
FROM `dish` d
WHERE d.id = @dish_id_2;

-- 订单5的明细
INSERT INTO `order_detail` (`name`, `order_id`, `dish_id`, `dish_flavor`, `number`, `amount`, `image`)
SELECT 
    d.name,
    @order_id_5,
    d.id,
    '中辣',
    2,
    d.price * 2,
    d.image
FROM `dish` d
WHERE d.id = @dish_id_1;

INSERT INTO `order_detail` (`name`, `order_id`, `dish_id`, `dish_flavor`, `number`, `amount`, `image`)
SELECT 
    d.name,
    @order_id_5,
    d.id,
    '微辣',
    1,
    d.price,
    d.image
FROM `dish` d
WHERE d.id = @dish_id_2;

INSERT INTO `order_detail` (`name`, `order_id`, `dish_id`, `dish_flavor`, `number`, `amount`, `image`)
SELECT 
    d.name,
    @order_id_5,
    d.id,
    '不辣',
    1,
    d.price,
    d.image
FROM `dish` d
WHERE d.id = @dish_id_3;

-- ============================================
-- 步骤6: 验证结果
-- ============================================
SELECT 
    '订单创建完成！' AS message,
    @user_id AS user_id,
    (SELECT COUNT(*) FROM `orders` WHERE user_id = @user_id) AS total_orders,
    (SELECT COUNT(*) FROM `order_detail` od 
     INNER JOIN `orders` o ON od.order_id = o.id 
     WHERE o.user_id = @user_id) AS total_order_details;

-- 查看创建的订单
SELECT 
    o.id,
    o.number,
    o.status,
    CASE o.status
        WHEN 1 THEN '待付款'
        WHEN 2 THEN '待接单'
        WHEN 3 THEN '已接单'
        WHEN 4 THEN '派送中'
        WHEN 5 THEN '已完成'
        WHEN 6 THEN '已取消'
        WHEN 7 THEN '退款'
        ELSE '未知'
    END AS status_name,
    o.amount,
    o.order_time,
    o.pay_status,
    CASE o.pay_status
        WHEN 0 THEN '未支付'
        WHEN 1 THEN '已支付'
        WHEN 2 THEN '退款'
        ELSE '未知'
    END AS pay_status_name
FROM `orders` o
WHERE o.user_id = @user_id
ORDER BY o.order_time DESC;

