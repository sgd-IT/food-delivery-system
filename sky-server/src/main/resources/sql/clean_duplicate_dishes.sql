-- 清理重复的菜品数据
USE `sky_take_out`;

-- 对于每个重复的菜品名称，保留最早创建的（ID最小的），删除其他重复的
-- 地三鲜：保留 ID 14，删除 28, 29, 30, 31
DELETE FROM dish WHERE id IN (28, 29, 30, 31) AND name = '地三鲜';

-- 佛跳墙：保留 ID 44（最小的），删除 45, 46, 47
DELETE FROM dish WHERE id IN (45, 46, 47) AND name = '佛跳墙';

-- 北京烤鸭：保留 ID 52（最小的），删除 53, 54, 55
-- 注意：北京烤鸭在订单中有使用，需要先检查
SELECT id, name, price, 
       (SELECT COUNT(*) FROM order_detail WHERE dish_id = d.id) as order_count
FROM dish d
WHERE name = '北京烤鸭'
ORDER BY id;

-- 松鼠桂鱼：保留 ID 36（最小的），删除 37, 38, 39
DELETE FROM dish WHERE id IN (37, 38, 39) AND name = '松鼠桂鱼';

-- 糖醋里脊：保留 ID 32（最小的），删除 33, 34, 35
DELETE FROM dish WHERE id IN (33, 34, 35) AND name = '糖醋里脊';

-- 红烧肉：保留 ID 56（最小的），删除 57, 58, 59
DELETE FROM dish WHERE id IN (57, 58, 59) AND name = '红烧肉';

-- 羊肉泡馍：保留 ID 60（最小的），删除 61, 62, 63
DELETE FROM dish WHERE id IN (61, 62, 63) AND name = '羊肉泡馍';

-- 臭鳜鱼：保留 ID 48（最小的），删除 49, 50, 51
DELETE FROM dish WHERE id IN (49, 50, 51) AND name = '臭鳜鱼';

-- 西湖醋鱼：保留 ID 40（最小的），删除 41, 42, 43
DELETE FROM dish WHERE id IN (41, 42, 43) AND name = '西湖醋鱼';

-- 叉烧包：保留 ID 10（最小的），删除 27
DELETE FROM dish WHERE id = 27 AND name = '叉烧包';

-- 验证清理结果
SELECT name, COUNT(*) as count
FROM dish
GROUP BY name
HAVING count > 1
ORDER BY count DESC;

-- 查看剩余的"地三鲜"
SELECT id, name, price, description
FROM dish
WHERE name = '地三鲜';

