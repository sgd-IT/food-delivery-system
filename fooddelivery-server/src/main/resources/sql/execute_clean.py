#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
执行清理问号数据的SQL脚本
"""
import pymysql
import sys

# 数据库配置
DB_CONFIG = {
    'host': 'localhost',
    'port': 3306,
    'user': 'root',
    'password': '1234',
    'database': 'food_delivery_system',
    'charset': 'utf8mb4'
}

def execute_sql(sql):
    """执行SQL语句"""
    try:
        connection = pymysql.connect(**DB_CONFIG)
        cursor = connection.cursor()
        
        # 执行SQL
        cursor.execute(sql)
        connection.commit()
        
        # 获取影响的行数
        affected_rows = cursor.rowcount
        cursor.close()
        connection.close()
        
        return affected_rows
    except Exception as e:
        print(f"执行SQL出错: {e}")
        return -1

def query_sql(sql):
    """查询SQL并返回结果"""
    try:
        connection = pymysql.connect(**DB_CONFIG)
        cursor = connection.cursor()
        
        cursor.execute(sql)
        results = cursor.fetchall()
        
        cursor.close()
        connection.close()
        
        return results
    except Exception as e:
        print(f"查询SQL出错: {e}")
        return None

def main():
    print("=" * 50)
    print("开始清理数据库中的问号数据")
    print("=" * 50)
    
    # 1. 检查清理前的数据
    print("\n1. 检查清理前的数据...")
    dish_count = query_sql("SELECT COUNT(*) FROM dish WHERE description LIKE '%?%' OR description LIKE '%？%'")
    setmeal_count = query_sql("SELECT COUNT(*) FROM setmeal WHERE description LIKE '%?%' OR description LIKE '%？%'")
    
    if dish_count:
        print(f"   菜品表包含问号的记录数: {dish_count[0][0]}")
    if setmeal_count:
        print(f"   套餐表包含问号的记录数: {setmeal_count[0][0]}")
    
    # 2. 清理菜品描述中的问号
    print("\n2. 清理菜品描述中的问号...")
    
    # 如果描述全是问号，设置为空字符串
    sql1 = """
    UPDATE dish 
    SET description = '', 
        update_time = NOW()
    WHERE TRIM(REPLACE(REPLACE(description, '?', ''), '？', '')) = ''
      AND (description LIKE '%?%' OR description LIKE '%？%')
    """
    rows1 = execute_sql(sql1)
    print(f"   清理全是问号的描述: {rows1} 条记录")
    
    # 如果描述包含问号，移除问号字符
    sql2 = """
    UPDATE dish 
    SET description = REPLACE(REPLACE(description, '?', ''), '？', ''),
        update_time = NOW()
    WHERE description LIKE '%?%' OR description LIKE '%？%'
    """
    rows2 = execute_sql(sql2)
    print(f"   移除问号字符: {rows2} 条记录")
    
    # 如果移除问号后描述为空，设置为空字符串
    sql3 = """
    UPDATE dish 
    SET description = '', 
        update_time = NOW()
    WHERE TRIM(description) = ''
    """
    rows3 = execute_sql(sql3)
    print(f"   清理空描述: {rows3} 条记录")
    
    # 3. 清理套餐描述中的问号
    print("\n3. 清理套餐描述中的问号...")
    
    # 如果描述全是问号，设置为空字符串
    sql4 = """
    UPDATE setmeal 
    SET description = '', 
        update_time = NOW()
    WHERE TRIM(REPLACE(REPLACE(description, '?', ''), '？', '')) = ''
      AND (description LIKE '%?%' OR description LIKE '%？%')
    """
    rows4 = execute_sql(sql4)
    print(f"   清理全是问号的描述: {rows4} 条记录")
    
    # 如果描述包含问号，移除问号字符
    sql5 = """
    UPDATE setmeal 
    SET description = REPLACE(REPLACE(description, '?', ''), '？', ''),
        update_time = NOW()
    WHERE description LIKE '%?%' OR description LIKE '%？%'
    """
    rows5 = execute_sql(sql5)
    print(f"   移除问号字符: {rows5} 条记录")
    
    # 如果移除问号后描述为空，设置为空字符串
    sql6 = """
    UPDATE setmeal 
    SET description = '', 
        update_time = NOW()
    WHERE TRIM(description) = ''
    """
    rows6 = execute_sql(sql6)
    print(f"   清理空描述: {rows6} 条记录")
    
    # 4. 验证清理结果
    print("\n4. 验证清理结果...")
    dish_remaining = query_sql("SELECT COUNT(*) FROM dish WHERE description LIKE '%?%' OR description LIKE '%？%'")
    setmeal_remaining = query_sql("SELECT COUNT(*) FROM setmeal WHERE description LIKE '%?%' OR description LIKE '%？%'")
    
    if dish_remaining:
        print(f"   菜品表剩余问号数量: {dish_remaining[0][0]}")
    if setmeal_remaining:
        print(f"   套餐表剩余问号数量: {setmeal_remaining[0][0]}")
    
    print("\n" + "=" * 50)
    if dish_remaining and setmeal_remaining:
        if dish_remaining[0][0] == 0 and setmeal_remaining[0][0] == 0:
            print("✅ 清理成功！所有问号数据已清理完毕")
        else:
            print("⚠️  仍有部分问号数据，请检查")
    print("=" * 50)

if __name__ == '__main__':
    main()

