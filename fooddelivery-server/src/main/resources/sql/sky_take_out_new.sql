-- ============================================
-- 云味道外卖项目数据库建表脚本
-- 数据库名: food_delivery_system
-- 创建时间: 2024
-- ============================================

-- 创建数据库
CREATE DATABASE IF NOT EXISTS `food_delivery_system` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE `food_delivery_system`;

-- ============================================
-- 1. 员工表
-- ============================================
CREATE TABLE `employee` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(32) NOT NULL COMMENT '用户名',
  `name` varchar(32) NOT NULL COMMENT '姓名',
  `password` varchar(64) NOT NULL COMMENT '密码',
  `phone` varchar(11) NOT NULL COMMENT '手机号',
  `sex` varchar(2) NOT NULL COMMENT '性别',
  `id_number` varchar(18) NOT NULL COMMENT '身份证号',
  `status` int NOT NULL DEFAULT '1' COMMENT '状态 0:禁用 1:启用',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `create_user` bigint DEFAULT NULL COMMENT '创建人',
  `update_user` bigint DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='员工信息';

-- ============================================
-- 2. 用户表（C端用户）
-- ============================================
CREATE TABLE `user` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `openid` varchar(45) DEFAULT NULL COMMENT '微信用户唯一标识',
  `name` varchar(32) DEFAULT NULL COMMENT '姓名',
  `phone` varchar(11) DEFAULT NULL COMMENT '手机号',
  `sex` varchar(2) DEFAULT NULL COMMENT '性别 0 女 1 男',
  `id_number` varchar(18) DEFAULT NULL COMMENT '身份证号',
  `avatar` varchar(500) DEFAULT NULL COMMENT '头像',
  `create_time` datetime DEFAULT NULL COMMENT '注册时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_openid` (`openid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户信息';

-- ============================================
-- 3. 分类表
-- ============================================
CREATE TABLE `category` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `type` int DEFAULT NULL COMMENT '类型 1 菜品分类 2 套餐分类',
  `name` varchar(32) NOT NULL COMMENT '分类名称',
  `sort` int NOT NULL DEFAULT '0' COMMENT '顺序',
  `status` int DEFAULT NULL COMMENT '分类状态 0:禁用 1:启用',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `create_user` bigint DEFAULT NULL COMMENT '创建人',
  `update_user` bigint DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='分类';

-- ============================================
-- 4. 菜品表
-- ============================================
CREATE TABLE `dish` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(32) NOT NULL COMMENT '菜品名称',
  `category_id` bigint NOT NULL COMMENT '菜品分类id',
  `price` decimal(10,2) DEFAULT NULL COMMENT '菜品价格',
  `image` varchar(500) DEFAULT NULL COMMENT '图片',
  `description` varchar(500) DEFAULT NULL COMMENT '描述信息',
  `status` int DEFAULT '1' COMMENT '0 停售 1 起售',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `create_user` bigint DEFAULT NULL COMMENT '创建人',
  `update_user` bigint DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`),
  KEY `idx_category_id` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='菜品';

-- ============================================
-- 5. 菜品口味表
-- ============================================
CREATE TABLE `dish_flavor` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `dish_id` bigint NOT NULL COMMENT '菜品',
  `name` varchar(32) DEFAULT NULL COMMENT '口味名称',
  `value` varchar(255) DEFAULT NULL COMMENT '口味数据list',
  PRIMARY KEY (`id`),
  KEY `idx_dish_id` (`dish_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='菜品口味关系表';

-- ============================================
-- 6. 套餐表
-- ============================================
CREATE TABLE `setmeal` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `category_id` bigint NOT NULL COMMENT '套餐分类id',
  `name` varchar(32) NOT NULL COMMENT '套餐名称',
  `price` decimal(10,2) NOT NULL COMMENT '套餐价格',
  `status` int DEFAULT NULL COMMENT '状态 0:停用 1:启用',
  `description` varchar(255) DEFAULT NULL COMMENT '描述信息',
  `image` varchar(500) DEFAULT NULL COMMENT '图片',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `create_user` bigint DEFAULT NULL COMMENT '创建人',
  `update_user` bigint DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`),
  KEY `idx_category_id` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='套餐';

-- ============================================
-- 7. 套餐菜品关系表
-- ============================================
CREATE TABLE `setmeal_dish` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `setmeal_id` bigint NOT NULL COMMENT '套餐id',
  `dish_id` bigint NOT NULL COMMENT '菜品id',
  `name` varchar(32) DEFAULT NULL COMMENT '菜品名称（冗余字段）',
  `price` decimal(10,2) DEFAULT NULL COMMENT '菜品原价',
  `copies` int NOT NULL COMMENT '份数',
  PRIMARY KEY (`id`),
  KEY `idx_setmeal_id` (`setmeal_id`),
  KEY `idx_dish_id` (`dish_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='套餐菜品关系';

-- ============================================
-- 8. 购物车表
-- ============================================
CREATE TABLE `shopping_cart` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(32) DEFAULT NULL COMMENT '商品名称',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `dish_id` bigint DEFAULT NULL COMMENT '菜品id',
  `setmeal_id` bigint DEFAULT NULL COMMENT '套餐id',
  `dish_flavor` varchar(50) DEFAULT NULL COMMENT '口味',
  `number` int NOT NULL DEFAULT '1' COMMENT '数量',
  `amount` decimal(10,2) NOT NULL COMMENT '金额',
  `image` varchar(500) DEFAULT NULL COMMENT '图片',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='购物车';

-- ============================================
-- 9. 订单表
-- ============================================
CREATE TABLE `orders` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `number` varchar(50) DEFAULT NULL COMMENT '订单号',
  `status` int NOT NULL DEFAULT '1' COMMENT '订单状态 1待付款 2待接单 3已接单 4派送中 5已完成 6已取消 7退款',
  `user_id` bigint NOT NULL COMMENT '下单用户id',
  `address_book_id` bigint NOT NULL COMMENT '地址id',
  `order_time` datetime NOT NULL COMMENT '下单时间',
  `checkout_time` datetime DEFAULT NULL COMMENT '结账时间',
  `pay_method` int NOT NULL DEFAULT '1' COMMENT '支付方式 1微信，2支付宝',
  `pay_status` int NOT NULL DEFAULT '0' COMMENT '支付状态 0未支付 1已支付 2退款',
  `amount` decimal(10,2) NOT NULL COMMENT '实收金额',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  `phone` varchar(11) DEFAULT NULL COMMENT '手机号',
  `address` varchar(255) DEFAULT NULL COMMENT '地址',
  `user_name` varchar(32) DEFAULT NULL COMMENT '用户名称',
  `consignee` varchar(32) DEFAULT NULL COMMENT '收货人',
  `cancel_reason` varchar(255) DEFAULT NULL COMMENT '订单取消原因',
  `rejection_reason` varchar(255) DEFAULT NULL COMMENT '订单拒绝原因',
  `cancel_time` datetime DEFAULT NULL COMMENT '订单取消时间',
  `estimated_delivery_time` datetime DEFAULT NULL COMMENT '预计送达时间',
  `delivery_status` int NOT NULL DEFAULT '1' COMMENT '配送状态  1立即送出  0选择具体时间',
  `delivery_time` datetime DEFAULT NULL COMMENT '送达时间',
  `pack_amount` int NOT NULL DEFAULT '0' COMMENT '打包费',
  `tableware_number` int DEFAULT NULL COMMENT '餐具数量',
  `tableware_status` int DEFAULT NULL COMMENT '餐具数量状态  1按餐量提供  0选择具体数量',
  `order_type` int NOT NULL DEFAULT '2' COMMENT '订单类型 1:堂食自取 2:外卖配送',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_number` (`number`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='订单表';

-- ============================================
-- 10. 订单明细表
-- ============================================
CREATE TABLE `order_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(32) DEFAULT NULL COMMENT '名字',
  `order_id` bigint NOT NULL COMMENT '订单id',
  `dish_id` bigint DEFAULT NULL COMMENT '菜品id',
  `setmeal_id` bigint DEFAULT NULL COMMENT '套餐id',
  `dish_flavor` varchar(50) DEFAULT NULL COMMENT '口味',
  `number` int NOT NULL DEFAULT '1' COMMENT '数量',
  `amount` decimal(10,2) NOT NULL COMMENT '金额',
  `image` varchar(500) DEFAULT NULL COMMENT '图片',
  PRIMARY KEY (`id`),
  KEY `idx_order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='订单明细表';

-- ============================================
-- 11. 地址簿表
-- ============================================
CREATE TABLE `address_book` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `consignee` varchar(32) NOT NULL COMMENT '收货人',
  `phone` varchar(11) NOT NULL COMMENT '手机号',
  `sex` varchar(2) DEFAULT NULL COMMENT '性别 0 女 1 男',
  `province_code` varchar(12) DEFAULT NULL COMMENT '省级区划编号',
  `province_name` varchar(32) DEFAULT NULL COMMENT '省级名称',
  `city_code` varchar(12) DEFAULT NULL COMMENT '市级区划编号',
  `city_name` varchar(32) DEFAULT NULL COMMENT '市级名称',
  `district_code` varchar(12) DEFAULT NULL COMMENT '区级区划编号',
  `district_name` varchar(32) DEFAULT NULL COMMENT '区级名称',
  `detail` varchar(200) DEFAULT NULL COMMENT '详细地址',
  `label` varchar(100) DEFAULT NULL COMMENT '标签',
  `is_default` int NOT NULL DEFAULT '0' COMMENT '是否默认 0否 1是',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='地址簿';

-- ============================================
-- 初始化数据（可选）
-- ============================================

-- 插入默认管理员账号（密码：123456，已加密）
-- 注意：实际密码需要根据项目中的加密方式进行加密
-- 此INSERT语句已注释，数据将从原数据库迁移
-- INSERT INTO `employee` (`username`, `name`, `password`, `phone`, `sex`, `id_number`, `status`, `create_time`, `update_time`, `create_user`, `update_user`) 
-- VALUES ('admin', '管理员', 'e10adc3949ba59abbe56e057f20f883e', '13812312388', '1', '110101199001010047', 1, NOW(), NOW(), 1, 1);

