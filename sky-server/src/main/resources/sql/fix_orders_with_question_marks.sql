-- ============================================
-- 修复订单数据：删除包含问号的订单，重新添加最新日期的订单
-- 数据库名: sky_take_out
-- ============================================

USE `sky_take_out`;

-- ============================================
-- 1. 删除备注字段包含问号的订单（先删除订单详情，再删除订单）
-- ============================================

-- 删除订单详情（关联删除）
DELETE od FROM order_detail od
INNER JOIN orders o ON od.order_id = o.id
WHERE o.remark LIKE '%?%' OR o.remark LIKE '%？%';

-- 删除订单
DELETE FROM orders 
WHERE remark LIKE '%?%' OR remark LIKE '%？%';

-- ============================================
-- 2. 添加最新日期的订单数据（50条订单）
-- ============================================
-- 注意：需要先有用户数据和地址数据，这里假设user_id=1, address_book_id=1

-- 插入50条最新日期的订单数据
INSERT INTO `orders` (`number`, `status`, `user_id`, `address_book_id`, `order_time`, `checkout_time`, `pay_method`, `pay_status`, `amount`, `remark`, `phone`, `address`, `user_name`, `consignee`, `order_type`, `pack_amount`, `tableware_number`, `tableware_status`, `delivery_status`) VALUES
(CONCAT('ORD', DATE_FORMAT(NOW(), '%Y%m%d'), '000001'), 5, 1, 1, DATE_SUB(NOW(), INTERVAL 1 HOUR), DATE_SUB(NOW(), INTERVAL 1 HOUR), 1, 1, 126.00, '不要辣', '13800138001', '北京市朝阳区xxx街道xxx号', '张三', '张三', 1, 0, 1, 1, 1),
(CONCAT('ORD', DATE_FORMAT(NOW(), '%Y%m%d'), '000002'), 5, 1, 1, DATE_SUB(NOW(), INTERVAL 2 HOUR), DATE_SUB(NOW(), INTERVAL 2 HOUR), 1, 1, 88.00, NULL, '13800138001', '北京市朝阳区xxx街道xxx号', '张三', '张三', 1, 0, 1, 1, 1),
(CONCAT('ORD', DATE_FORMAT(NOW(), '%Y%m%d'), '000003'), 5, 1, 1, DATE_SUB(NOW(), INTERVAL 3 HOUR), DATE_SUB(NOW(), INTERVAL 3 HOUR), 2, 1, 168.00, '快点送', '13800138001', '北京市朝阳区xxx街道xxx号', '张三', '张三', 1, 0, 1, 1, 1),
(CONCAT('ORD', DATE_FORMAT(NOW(), '%Y%m%d'), '000004'), 5, 1, 1, DATE_SUB(NOW(), INTERVAL 4 HOUR), DATE_SUB(NOW(), INTERVAL 4 HOUR), 1, 1, 98.00, NULL, '13800138001', '北京市朝阳区xxx街道xxx号', '张三', '张三', 1, 0, 1, 1, 1),
(CONCAT('ORD', DATE_FORMAT(NOW(), '%Y%m%d'), '000005'), 5, 1, 1, DATE_SUB(NOW(), INTERVAL 5 HOUR), DATE_SUB(NOW(), INTERVAL 5 HOUR), 2, 1, 156.00, '多放点菜', '13800138001', '北京市朝阳区xxx街道xxx号', '张三', '张三', 1, 0, 1, 1, 1),
(CONCAT('ORD', DATE_FORMAT(NOW(), '%Y%m%d'), '000006'), 5, 1, 1, DATE_SUB(NOW(), INTERVAL 6 HOUR), DATE_SUB(NOW(), INTERVAL 6 HOUR), 1, 1, 145.00, NULL, '13800138001', '北京市朝阳区xxx街道xxx号', '张三', '张三', 1, 0, 1, 1, 1),
(CONCAT('ORD', DATE_FORMAT(NOW(), '%Y%m%d'), '000007'), 5, 1, 1, DATE_SUB(NOW(), INTERVAL 7 HOUR), DATE_SUB(NOW(), INTERVAL 7 HOUR), 2, 1, 132.00, '不要辣', '13800138001', '北京市朝阳区xxx街道xxx号', '张三', '张三', 1, 0, 1, 1, 1),
(CONCAT('ORD', DATE_FORMAT(NOW(), '%Y%m%d'), '000008'), 5, 1, 1, DATE_SUB(NOW(), INTERVAL 8 HOUR), DATE_SUB(NOW(), INTERVAL 8 HOUR), 1, 1, 178.00, '快点送', '13800138001', '北京市朝阳区xxx街道xxx号', '张三', '张三', 1, 0, 1, 1, 1),
(CONCAT('ORD', DATE_FORMAT(NOW(), '%Y%m%d'), '000009'), 5, 1, 1, DATE_SUB(NOW(), INTERVAL 9 HOUR), DATE_SUB(NOW(), INTERVAL 9 HOUR), 2, 1, 112.00, NULL, '13800138001', '北京市朝阳区xxx街道xxx号', '张三', '张三', 1, 0, 1, 1, 1),
(CONCAT('ORD', DATE_FORMAT(NOW(), '%Y%m%d'), '000010'), 5, 1, 1, DATE_SUB(NOW(), INTERVAL 10 HOUR), DATE_SUB(NOW(), INTERVAL 10 HOUR), 1, 1, 198.00, '多放点菜', '13800138001', '北京市朝阳区xxx街道xxx号', '张三', '张三', 1, 0, 1, 1, 1),
(CONCAT('ORD', DATE_FORMAT(NOW(), '%Y%m%d'), '000011'), 4, 1, 1, DATE_SUB(NOW(), INTERVAL 11 HOUR), DATE_SUB(NOW(), INTERVAL 11 HOUR), 2, 1, 165.00, NULL, '13800138001', '北京市朝阳区xxx街道xxx号', '张三', '张三', 1, 0, 1, 1, 1),
(CONCAT('ORD', DATE_FORMAT(NOW(), '%Y%m%d'), '000012'), 4, 1, 1, DATE_SUB(NOW(), INTERVAL 12 HOUR), DATE_SUB(NOW(), INTERVAL 12 HOUR), 1, 1, 142.00, '不要辣', '13800138001', '北京市朝阳区xxx街道xxx号', '张三', '张三', 1, 0, 1, 1, 1),
(CONCAT('ORD', DATE_FORMAT(NOW(), '%Y%m%d'), '000013'), 4, 1, 1, DATE_SUB(NOW(), INTERVAL 13 HOUR), DATE_SUB(NOW(), INTERVAL 13 HOUR), 2, 1, 188.00, '快点送', '13800138001', '北京市朝阳区xxx街道xxx号', '张三', '张三', 1, 0, 1, 1, 1),
(CONCAT('ORD', DATE_FORMAT(NOW(), '%Y%m%d'), '000014'), 4, 1, 1, DATE_SUB(NOW(), INTERVAL 14 HOUR), DATE_SUB(NOW(), INTERVAL 14 HOUR), 1, 1, 125.00, NULL, '13800138001', '北京市朝阳区xxx街道xxx号', '张三', '张三', 1, 0, 1, 1, 1),
(CONCAT('ORD', DATE_FORMAT(NOW(), '%Y%m%d'), '000015'), 4, 1, 1, DATE_SUB(NOW(), INTERVAL 15 HOUR), DATE_SUB(NOW(), INTERVAL 15 HOUR), 2, 1, 155.00, '多放点菜', '13800138001', '北京市朝阳区xxx街道xxx号', '张三', '张三', 1, 0, 1, 1, 1),
(CONCAT('ORD', DATE_FORMAT(NOW(), '%Y%m%d'), '000016'), 4, 1, 1, DATE_SUB(NOW(), INTERVAL 16 HOUR), DATE_SUB(NOW(), INTERVAL 16 HOUR), 1, 1, 138.00, NULL, '13800138001', '北京市朝阳区xxx街道xxx号', '张三', '张三', 1, 0, 1, 1, 1),
(CONCAT('ORD', DATE_FORMAT(NOW(), '%Y%m%d'), '000017'), 4, 1, 1, DATE_SUB(NOW(), INTERVAL 17 HOUR), DATE_SUB(NOW(), INTERVAL 17 HOUR), 2, 1, 172.00, '不要辣', '13800138001', '北京市朝阳区xxx街道xxx号', '张三', '张三', 1, 0, 1, 1, 1),
(CONCAT('ORD', DATE_FORMAT(NOW(), '%Y%m%d'), '000018'), 4, 1, 1, DATE_SUB(NOW(), INTERVAL 18 HOUR), DATE_SUB(NOW(), INTERVAL 18 HOUR), 1, 1, 148.00, '快点送', '13800138001', '北京市朝阳区xxx街道xxx号', '张三', '张三', 1, 0, 1, 1, 1),
(CONCAT('ORD', DATE_FORMAT(NOW(), '%Y%m%d'), '000019'), 4, 1, 1, DATE_SUB(NOW(), INTERVAL 19 HOUR), DATE_SUB(NOW(), INTERVAL 19 HOUR), 2, 1, 162.00, NULL, '13800138001', '北京市朝阳区xxx街道xxx号', '张三', '张三', 1, 0, 1, 1, 1),
(CONCAT('ORD', DATE_FORMAT(NOW(), '%Y%m%d'), '000020'), 4, 1, 1, DATE_SUB(NOW(), INTERVAL 20 HOUR), DATE_SUB(NOW(), INTERVAL 20 HOUR), 1, 1, 135.00, '多放点菜', '13800138001', '北京市朝阳区xxx街道xxx号', '张三', '张三', 1, 0, 1, 1, 1),
(CONCAT('ORD', DATE_FORMAT(NOW(), '%Y%m%d'), '000021'), 3, 1, 1, DATE_SUB(NOW(), INTERVAL 21 HOUR), DATE_SUB(NOW(), INTERVAL 21 HOUR), 2, 1, 185.00, NULL, '13800138001', '北京市朝阳区xxx街道xxx号', '张三', '张三', 1, 0, 1, 1, 1),
(CONCAT('ORD', DATE_FORMAT(NOW(), '%Y%m%d'), '000022'), 3, 1, 1, DATE_SUB(NOW(), INTERVAL 22 HOUR), DATE_SUB(NOW(), INTERVAL 22 HOUR), 1, 1, 152.00, '不要辣', '13800138001', '北京市朝阳区xxx街道xxx号', '张三', '张三', 1, 0, 1, 1, 1),
(CONCAT('ORD', DATE_FORMAT(NOW(), '%Y%m%d'), '000023'), 3, 1, 1, DATE_SUB(NOW(), INTERVAL 23 HOUR), DATE_SUB(NOW(), INTERVAL 23 HOUR), 2, 1, 168.00, '快点送', '13800138001', '北京市朝阳区xxx街道xxx号', '张三', '张三', 1, 0, 1, 1, 1),
(CONCAT('ORD', DATE_FORMAT(NOW(), '%Y%m%d'), '000024'), 3, 1, 1, DATE_SUB(NOW(), INTERVAL 24 HOUR), DATE_SUB(NOW(), INTERVAL 24 HOUR), 1, 1, 142.00, NULL, '13800138001', '北京市朝阳区xxx街道xxx号', '张三', '张三', 1, 0, 1, 1, 1),
(CONCAT('ORD', DATE_FORMAT(NOW(), '%Y%m%d'), '000025'), 3, 1, 1, DATE_SUB(NOW(), INTERVAL 25 HOUR), DATE_SUB(NOW(), INTERVAL 25 HOUR), 2, 1, 175.00, '多放点菜', '13800138001', '北京市朝阳区xxx街道xxx号', '张三', '张三', 1, 0, 1, 1, 1),
(CONCAT('ORD', DATE_FORMAT(NOW(), '%Y%m%d'), '000026'), 3, 1, 1, DATE_SUB(NOW(), INTERVAL 26 HOUR), DATE_SUB(NOW(), INTERVAL 26 HOUR), 1, 1, 158.00, NULL, '13800138001', '北京市朝阳区xxx街道xxx号', '张三', '张三', 1, 0, 1, 1, 1),
(CONCAT('ORD', DATE_FORMAT(NOW(), '%Y%m%d'), '000027'), 3, 1, 1, DATE_SUB(NOW(), INTERVAL 27 HOUR), DATE_SUB(NOW(), INTERVAL 27 HOUR), 2, 1, 192.00, '不要辣', '13800138001', '北京市朝阳区xxx街道xxx号', '张三', '张三', 1, 0, 1, 1, 1),
(CONCAT('ORD', DATE_FORMAT(NOW(), '%Y%m%d'), '000028'), 3, 1, 1, DATE_SUB(NOW(), INTERVAL 28 HOUR), DATE_SUB(NOW(), INTERVAL 28 HOUR), 1, 1, 148.00, '快点送', '13800138001', '北京市朝阳区xxx街道xxx号', '张三', '张三', 1, 0, 1, 1, 1),
(CONCAT('ORD', DATE_FORMAT(NOW(), '%Y%m%d'), '000029'), 3, 1, 1, DATE_SUB(NOW(), INTERVAL 29 HOUR), DATE_SUB(NOW(), INTERVAL 29 HOUR), 2, 1, 165.00, NULL, '13800138001', '北京市朝阳区xxx街道xxx号', '张三', '张三', 1, 0, 1, 1, 1),
(CONCAT('ORD', DATE_FORMAT(NOW(), '%Y%m%d'), '000030'), 3, 1, 1, DATE_SUB(NOW(), INTERVAL 30 HOUR), DATE_SUB(NOW(), INTERVAL 30 HOUR), 1, 1, 138.00, '多放点菜', '13800138001', '北京市朝阳区xxx街道xxx号', '张三', '张三', 1, 0, 1, 1, 1),
(CONCAT('ORD', DATE_FORMAT(NOW(), '%Y%m%d'), '000031'), 2, 1, 1, DATE_SUB(NOW(), INTERVAL 31 HOUR), NULL, 2, 0, 178.00, NULL, '13800138001', '北京市朝阳区xxx街道xxx号', '张三', '张三', 1, 0, 1, 1, 1),
(CONCAT('ORD', DATE_FORMAT(NOW(), '%Y%m%d'), '000032'), 2, 1, 1, DATE_SUB(NOW(), INTERVAL 32 HOUR), NULL, 1, 0, 152.00, '不要辣', '13800138001', '北京市朝阳区xxx街道xxx号', '张三', '张三', 1, 0, 1, 1, 1),
(CONCAT('ORD', DATE_FORMAT(NOW(), '%Y%m%d'), '000033'), 2, 1, 1, DATE_SUB(NOW(), INTERVAL 33 HOUR), NULL, 2, 0, 188.00, '快点送', '13800138001', '北京市朝阳区xxx街道xxx号', '张三', '张三', 1, 0, 1, 1, 1),
(CONCAT('ORD', DATE_FORMAT(NOW(), '%Y%m%d'), '000034'), 2, 1, 1, DATE_SUB(NOW(), INTERVAL 34 HOUR), NULL, 1, 0, 125.00, NULL, '13800138001', '北京市朝阳区xxx街道xxx号', '张三', '张三', 1, 0, 1, 1, 1),
(CONCAT('ORD', DATE_FORMAT(NOW(), '%Y%m%d'), '000035'), 2, 1, 1, DATE_SUB(NOW(), INTERVAL 35 HOUR), NULL, 2, 0, 155.00, '多放点菜', '13800138001', '北京市朝阳区xxx街道xxx号', '张三', '张三', 1, 0, 1, 1, 1),
(CONCAT('ORD', DATE_FORMAT(NOW(), '%Y%m%d'), '000036'), 2, 1, 1, DATE_SUB(NOW(), INTERVAL 36 HOUR), NULL, 1, 0, 138.00, NULL, '13800138001', '北京市朝阳区xxx街道xxx号', '张三', '张三', 1, 0, 1, 1, 1),
(CONCAT('ORD', DATE_FORMAT(NOW(), '%Y%m%d'), '000037'), 2, 1, 1, DATE_SUB(NOW(), INTERVAL 37 HOUR), NULL, 2, 0, 172.00, '不要辣', '13800138001', '北京市朝阳区xxx街道xxx号', '张三', '张三', 1, 0, 1, 1, 1),
(CONCAT('ORD', DATE_FORMAT(NOW(), '%Y%m%d'), '000038'), 2, 1, 1, DATE_SUB(NOW(), INTERVAL 38 HOUR), NULL, 1, 0, 148.00, '快点送', '13800138001', '北京市朝阳区xxx街道xxx号', '张三', '张三', 1, 0, 1, 1, 1),
(CONCAT('ORD', DATE_FORMAT(NOW(), '%Y%m%d'), '000039'), 2, 1, 1, DATE_SUB(NOW(), INTERVAL 39 HOUR), NULL, 2, 0, 162.00, NULL, '13800138001', '北京市朝阳区xxx街道xxx号', '张三', '张三', 1, 0, 1, 1, 1),
(CONCAT('ORD', DATE_FORMAT(NOW(), '%Y%m%d'), '000040'), 2, 1, 1, DATE_SUB(NOW(), INTERVAL 40 HOUR), NULL, 1, 0, 135.00, '多放点菜', '13800138001', '北京市朝阳区xxx街道xxx号', '张三', '张三', 1, 0, 1, 1, 1),
(CONCAT('ORD', DATE_FORMAT(NOW(), '%Y%m%d'), '000041'), 1, 1, 1, DATE_SUB(NOW(), INTERVAL 41 HOUR), NULL, 2, 0, 185.00, NULL, '13800138001', '北京市朝阳区xxx街道xxx号', '张三', '张三', 1, 0, 1, 1, 1),
(CONCAT('ORD', DATE_FORMAT(NOW(), '%Y%m%d'), '000042'), 1, 1, 1, DATE_SUB(NOW(), INTERVAL 42 HOUR), NULL, 1, 0, 152.00, '不要辣', '13800138001', '北京市朝阳区xxx街道xxx号', '张三', '张三', 1, 0, 1, 1, 1),
(CONCAT('ORD', DATE_FORMAT(NOW(), '%Y%m%d'), '000043'), 1, 1, 1, DATE_SUB(NOW(), INTERVAL 43 HOUR), NULL, 2, 0, 168.00, '快点送', '13800138001', '北京市朝阳区xxx街道xxx号', '张三', '张三', 1, 0, 1, 1, 1),
(CONCAT('ORD', DATE_FORMAT(NOW(), '%Y%m%d'), '000044'), 1, 1, 1, DATE_SUB(NOW(), INTERVAL 44 HOUR), NULL, 1, 0, 142.00, NULL, '13800138001', '北京市朝阳区xxx街道xxx号', '张三', '张三', 1, 0, 1, 1, 1),
(CONCAT('ORD', DATE_FORMAT(NOW(), '%Y%m%d'), '000045'), 1, 1, 1, DATE_SUB(NOW(), INTERVAL 45 HOUR), NULL, 2, 0, 175.00, '多放点菜', '13800138001', '北京市朝阳区xxx街道xxx号', '张三', '张三', 1, 0, 1, 1, 1),
(CONCAT('ORD', DATE_FORMAT(NOW(), '%Y%m%d'), '000046'), 1, 1, 1, DATE_SUB(NOW(), INTERVAL 46 HOUR), NULL, 1, 0, 158.00, NULL, '13800138001', '北京市朝阳区xxx街道xxx号', '张三', '张三', 1, 0, 1, 1, 1),
(CONCAT('ORD', DATE_FORMAT(NOW(), '%Y%m%d'), '000047'), 1, 1, 1, DATE_SUB(NOW(), INTERVAL 47 HOUR), NULL, 2, 0, 192.00, '不要辣', '13800138001', '北京市朝阳区xxx街道xxx号', '张三', '张三', 1, 0, 1, 1, 1),
(CONCAT('ORD', DATE_FORMAT(NOW(), '%Y%m%d'), '000048'), 1, 1, 1, DATE_SUB(NOW(), INTERVAL 48 HOUR), NULL, 1, 0, 148.00, '快点送', '13800138001', '北京市朝阳区xxx街道xxx号', '张三', '张三', 1, 0, 1, 1, 1),
(CONCAT('ORD', DATE_FORMAT(NOW(), '%Y%m%d'), '000049'), 1, 1, 1, DATE_SUB(NOW(), INTERVAL 49 HOUR), NULL, 2, 0, 165.00, NULL, '13800138001', '北京市朝阳区xxx街道xxx号', '张三', '张三', 1, 0, 1, 1, 1),
(CONCAT('ORD', DATE_FORMAT(NOW(), '%Y%m%d'), '000050'), 1, 1, 1, DATE_SUB(NOW(), INTERVAL 50 HOUR), NULL, 1, 0, 138.00, '多放点菜', '13800138001', '北京市朝阳区xxx街道xxx号', '张三', '张三', 1, 0, 1, 1, 1);

-- ============================================
-- 3. 添加订单详情数据
-- ============================================
-- 注意：需要先执行订单插入，然后根据实际订单ID插入详情
-- 这里使用变量来获取最近插入的订单ID范围

SET @min_order_id = (SELECT COALESCE(MAX(id), 0) - 49 FROM orders);
SET @max_order_id = (SELECT COALESCE(MAX(id), 0) FROM orders);

-- 为每个订单添加1-2个菜品
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

-- 为部分订单添加套餐（每3个订单中有一个包含套餐）
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

-- ============================================
-- 4. 验证：查看删除和插入的结果
-- ============================================

-- 查看是否还有包含问号的订单
SELECT COUNT(*) as remaining_question_mark_orders 
FROM orders 
WHERE remark LIKE '%?%' OR remark LIKE '%？%';

-- 查看最新插入的订单数量
SELECT COUNT(*) as new_orders_count 
FROM orders 
WHERE order_time >= DATE_SUB(NOW(), INTERVAL 50 HOUR);

-- 查看订单总数
SELECT COUNT(*) as total_orders FROM orders;

