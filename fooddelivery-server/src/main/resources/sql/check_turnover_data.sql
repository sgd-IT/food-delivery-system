-- 检查营业额统计数据
USE `food_delivery_system`;

-- 查看订单状态定义（通常5是已完成）
SELECT DISTINCT status, 
       CASE status
         WHEN 1 THEN '待付款'
         WHEN 2 THEN '待接单'
         WHEN 3 THEN '已接单'
         WHEN 4 THEN '派送中'
         WHEN 5 THEN '已完成'
         WHEN 6 THEN '已取消'
         ELSE '未知'
       END as status_name
FROM orders
ORDER BY status;

-- 查看最近30天的订单状态分布
SELECT 
    DATE(order_time) as order_date,
    status,
    COUNT(*) as order_count,
    SUM(amount) as total_amount
FROM orders
WHERE order_time >= DATE_SUB(NOW(), INTERVAL 30 DAY)
GROUP BY DATE(order_time), status
ORDER BY order_date DESC, status;

-- 查看已完成订单的数量和金额
SELECT 
    DATE(order_time) as order_date,
    COUNT(*) as completed_order_count,
    SUM(amount) as total_turnover
FROM orders
WHERE status = 5
  AND order_time >= DATE_SUB(NOW(), INTERVAL 30 DAY)
GROUP BY DATE(order_time)
ORDER BY order_date DESC;

-- 查看所有订单的状态和金额
SELECT 
    id,
    number,
    status,
    amount,
    order_time,
    checkout_time
FROM orders
ORDER BY order_time DESC
LIMIT 20;

