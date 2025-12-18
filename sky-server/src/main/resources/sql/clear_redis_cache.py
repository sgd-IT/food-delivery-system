#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
清理Redis中的菜品缓存
"""
import redis
import sys

# Redis配置（从application.yml获取）
REDIS_CONFIG = {
    'host': 'localhost',
    'port': 6379,
    'password': '',  # 如果没有密码，留空
    'db': 0,  # 默认数据库
    'decode_responses': True
}

def clear_dish_cache():
    """清理所有菜品相关的Redis缓存"""
    try:
        # 连接Redis
        r = redis.Redis(**REDIS_CONFIG)
        
        # 查找所有dish相关的key
        pattern = 'dish_*'
        keys = r.keys(pattern)
        
        if keys:
            print(f"找到 {len(keys)} 个菜品缓存key:")
            for key in keys:
                print(f"  - {key}")
            
            # 删除所有匹配的key
            deleted = r.delete(*keys)
            print(f"\n✅ 成功删除 {deleted} 个缓存key")
        else:
            print("未找到菜品缓存")
        
        # 验证清理结果
        remaining_keys = r.keys(pattern)
        if remaining_keys:
            print(f"⚠️  仍有 {len(remaining_keys)} 个缓存key未清理")
        else:
            print("✅ 所有菜品缓存已清理完毕")
            
    except redis.ConnectionError:
        print("❌ 无法连接到Redis服务器，请检查Redis是否运行")
        print("   如果Redis有密码，请修改脚本中的password配置")
    except Exception as e:
        print(f"❌ 清理缓存时出错: {e}")

if __name__ == '__main__':
    print("=" * 50)
    print("清理Redis菜品缓存")
    print("=" * 50)
    clear_dish_cache()
    print("=" * 50)

