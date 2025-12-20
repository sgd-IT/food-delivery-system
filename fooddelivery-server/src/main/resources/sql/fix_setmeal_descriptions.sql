-- 修复套餐描述中的问号问题
USE `food_delivery_system`;

-- 根据套餐ID和名称修复描述
-- 商务套餐C (id=5)
UPDATE setmeal 
SET description = '包含：北京烤鸭+京酱肉丝+时蔬+米饭+汤'
WHERE id = 5 AND name = '商务套餐C';

-- 商务套餐D (id=6)
UPDATE setmeal 
SET description = '包含：烧鹅+白切鸡+时蔬+米饭+汤'
WHERE id = 6 AND name = '商务套餐D';

-- 商务套餐E (id=7)
UPDATE setmeal 
SET description = '包含：松鼠桂鱼+清炖狮子头+时蔬+米饭+汤'
WHERE id = 7 AND name = '商务套餐E';

-- 浪漫双人餐 (id=8)
UPDATE setmeal 
SET description = '包含：松鼠桂鱼+龙井虾仁+时蔬+米饭+汤+甜品'
WHERE id = 8 AND name = '浪漫双人餐';

-- 甜蜜套餐 (id=9)
UPDATE setmeal 
SET description = '包含：糖醋里脊+鱼香肉丝+时蔬+米饭+汤+甜品'
WHERE id = 9 AND name = '甜蜜套餐';

-- 儿童营养餐 (id=10)
UPDATE setmeal 
SET description = '包含：蒸蛋+小份糖醋里脊+时蔬+米饭+果汁'
WHERE id = 10 AND name = '儿童营养餐';

-- 儿童快乐餐 (id=11)
UPDATE setmeal 
SET description = '包含：小笼包+蒸蛋+时蔬+米饭+果汁'
WHERE id = 11 AND name = '儿童快乐餐';

-- 验证修复结果
SELECT id, name, description
FROM setmeal
WHERE description LIKE '%?%' OR description LIKE '%？%'
ORDER BY id;

-- 查看所有套餐的描述
SELECT id, name, description
FROM setmeal
ORDER BY id;

