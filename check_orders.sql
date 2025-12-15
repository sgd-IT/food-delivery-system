-- 检查订单表数据
-- 1. 查看订单总数
SELECT COUNT(*) as total_orders FROM orders;

-- 2. 按状态统计订单数量
SELECT 
    status,
    CASE status
        WHEN 1 THEN '待付款'
        WHEN 2 THEN '待接单'
        WHEN 3 THEN '已接单/待派送'
        WHEN 4 THEN '派送中'
        WHEN 5 THEN '已完成'
        WHEN 6 THEN '已取消'
        ELSE '未知状态'
    END as status_name,
    COUNT(*) as count
FROM orders
GROUP BY status
ORDER BY status;

-- 3. 查看最近10条订单的详细信息
SELECT 
    id,
    number,
    status,
    CASE status
        WHEN 1 THEN '待付款'
        WHEN 2 THEN '待接单'
        WHEN 3 THEN '已接单/待派送'
        WHEN 4 THEN '派送中'
        WHEN 5 THEN '已完成'
        WHEN 6 THEN '已取消'
        ELSE '未知状态'
    END as status_name,
    user_id,
    order_time,
    amount,
    phone,
    consignee
FROM orders
ORDER BY order_time DESC
LIMIT 10;

-- 4. 检查特定状态的订单（用于测试前端查询）
-- 待接单 (status = 2)
SELECT COUNT(*) as to_be_confirmed_count FROM orders WHERE status = 2;

-- 待派送 (status = 3)
SELECT COUNT(*) as confirmed_count FROM orders WHERE status = 3;

-- 派送中 (status = 4)
SELECT COUNT(*) as delivery_in_progress_count FROM orders WHERE status = 4;

-- 5. 如果数据为空，可以插入一些测试数据（可选）
-- 注意：执行前请确认是否需要测试数据

