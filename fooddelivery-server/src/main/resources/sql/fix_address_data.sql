-- ============================================
-- 修复地址数据乱码问题
-- 请在 Navicat 或 MySQL Workbench 中执行此脚本
-- ============================================

USE `food_delivery_system`;

-- 1. 获取当前用户ID (最新创建的用户)
SET @user_id = (SELECT id FROM `user` ORDER BY create_time DESC LIMIT 1);

-- 2. 删除该用户现有的乱码地址 (A4-A10)
DELETE FROM `address_book` 
WHERE user_id = @user_id 
AND (detail LIKE '%??%' OR detail LIKE '%广东科技学院A%');

-- 3. 重新插入清晰的地址数据
INSERT INTO `address_book` 
    (`user_id`, `consignee`, `phone`, `sex`, `province_code`, `province_name`, 
     `city_code`, `city_name`, `district_code`, `district_name`, `detail`, 
     `label`, `is_default`)
VALUES
    (@user_id, '木东', '13800138004', '0', '440000', '广东省', '441900', '东莞市', '441900', '石排镇', '广东科技学院A4宿舍楼', '学校', 0),
    (@user_id, '木东', '13800138005', '0', '440000', '广东省', '441900', '东莞市', '441900', '石排镇', '广东科技学院A5宿舍楼', '学校', 0),
    (@user_id, '木东', '13800138006', '0', '440000', '广东省', '441900', '东莞市', '441900', '石排镇', '广东科技学院A6宿舍楼', '学校', 0),
    (@user_id, '木东', '13800138007', '0', '440000', '广东省', '441900', '东莞市', '441900', '石排镇', '广东科技学院A7宿舍楼', '学校', 0),
    (@user_id, '木东', '13800138008', '0', '440000', '广东省', '441900', '东莞市', '441900', '石排镇', '广东科技学院A8宿舍楼', '学校', 0),
    (@user_id, '木东', '13800138009', '0', '440000', '广东省', '441900', '东莞市', '441900', '石排镇', '广东科技学院A9宿舍楼', '学校', 0),
    (@user_id, '木东', '13800138010', '0', '440000', '广东省', '441900', '东莞市', '441900', '石排镇', '广东科技学院A10宿舍楼', '学校', 0);

-- 4. 确保所有地址性别为先生 (0)
UPDATE `address_book` SET sex = '0' WHERE user_id = @user_id;

-- 5. 验证结果
SELECT id, consignee, detail, sex FROM `address_book` WHERE user_id = @user_id;

