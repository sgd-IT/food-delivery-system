#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
修复dish_flavor表的编码问题
"""
import pymysql

# 数据库配置
DB_CONFIG = {
    'host': 'localhost',
    'port': 3306,
    'user': 'root',
    'password': '1234',
    'database': 'sky_take_out',
    'charset': 'utf8mb4'
}

def fix_dish_flavor():
    """修复dish_flavor表的乱码数据"""
    try:
        # 连接数据库
        connection = pymysql.connect(**DB_CONFIG)
        cursor = connection.cursor()
        
        print("开始修复dish_flavor表...")
        
        # 第一步：删除所有乱码数据
        delete_sql = """
        DELETE FROM dish_flavor 
        WHERE name LIKE '%?%' OR name LIKE '%？%' 
           OR value LIKE '%?%' OR value LIKE '%？%'
        """
        cursor.execute(delete_sql)
        deleted_count = cursor.rowcount
        print(f"删除了 {deleted_count} 条乱码记录")
        
        # 第二步：插入正确的口味数据
        insert_sql = """
        INSERT INTO dish_flavor (dish_id, name, value) VALUES
        (%s, %s, %s)
        """
        
        # 口味数据配置
        flavor_data = [
            # dish_id=1: 剁椒鱼头
            (1, '辣度', '["不辣","微辣","中辣","重辣"]'),
            (1, '忌口', '["不要葱","不要蒜","不要香菜"]'),
            # dish_id=2: 口味虾
            (2, '辣度', '["不辣","微辣","中辣","重辣"]'),
            (2, '忌口', '["不要葱","不要蒜","不要香菜"]'),
            # dish_id=5: 麻婆豆腐
            (5, '辣度', '["不辣","微辣","中辣","重辣"]'),
            (5, '忌口', '["不要葱","不要蒜","不要香菜"]'),
            # dish_id=7: 水煮鱼
            (7, '辣度', '["不辣","微辣","中辣","重辣"]'),
            (7, '忌口', '["不要葱","不要蒜","不要香菜","不要鱼刺"]'),
        ]
        
        cursor.executemany(insert_sql, flavor_data)
        inserted_count = cursor.rowcount
        print(f"插入了 {inserted_count} 条新记录")
        
        # 提交事务
        connection.commit()
        
        # 验证结果
        check_sql = """
        SELECT COUNT(*) as question_mark_count
        FROM dish_flavor
        WHERE name LIKE '%?%' OR name LIKE '%？%' 
           OR value LIKE '%?%' OR value LIKE '%？%'
        """
        cursor.execute(check_sql)
        result = cursor.fetchone()
        question_mark_count = result[0]
        
        print(f"\n验证结果:")
        print(f"包含问号的记录数: {question_mark_count}")
        
        # 查看修复后的数据
        view_sql = """
        SELECT df.id, df.dish_id, d.name as dish_name, df.name as flavor_name, df.value as flavor_value
        FROM dish_flavor df
        LEFT JOIN dish d ON df.dish_id = d.id
        ORDER BY df.dish_id, df.id
        """
        cursor.execute(view_sql)
        results = cursor.fetchall()
        
        print(f"\n修复后的数据:")
        print(f"{'ID':<5} {'菜品ID':<8} {'菜品名称':<15} {'口味名称':<10} {'口味值'}")
        print("-" * 80)
        for row in results:
            print(f"{row[0]:<5} {row[1]:<8} {row[2]:<15} {row[3]:<10} {row[4]}")
        
        cursor.close()
        connection.close()
        
        print("\n修复完成！")
        return True
        
    except Exception as e:
        print(f"执行出错: {e}")
        if 'connection' in locals():
            connection.rollback()
        return False

if __name__ == '__main__':
    fix_dish_flavor()

