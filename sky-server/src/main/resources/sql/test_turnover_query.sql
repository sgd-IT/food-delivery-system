-- 测试营业额统计查询
USE `sky_take_out`;

-- 模拟前端默认查询：近7日（不包括今天）
-- 假设今天是 2025-12-15，近7日应该是 2025-12-08 到 2025-12-14
SELECT 
    DATE(order_time) as order_date,
    COUNT(*) as completed_order_count,
    SUM(amount) as total_turnover
FROM orders
WHERE status = 5
  AND DATE(order_time) >= '2025-12-08'
  AND DATE(order_time) <= '2025-12-14'
GROUP BY DATE(order_time)
ORDER BY order_date;

-- 查看今天（2025-12-15）的已完成订单
SELECT 
    COUNT(*) as today_completed_count,
    SUM(amount) as today_turnover
FROM orders
WHERE status = 5
  AND DATE(order_time) = '2025-12-15';

-- 查看最近7天（包括今天）的已完成订单
SELECT 
    DATE(order_time) as order_date,
    COUNT(*) as completed_order_count,
    SUM(amount) as total_turnover
FROM orders
WHERE status = 5
  AND DATE(order_time) >= DATE_SUB(CURDATE(), INTERVAL 6 DAY)
  AND DATE(order_time) <= CURDATE()
GROUP BY DATE(order_time)
ORDER BY order_date;

