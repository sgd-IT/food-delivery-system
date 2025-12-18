package com.sky.controller.admin;

import com.sky.result.Result;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Set;

/**
 * 缓存管理控制器
 * 用于清理Redis缓存
 */
@RestController("adminCacheController")
@RequestMapping("/admin/cache")
@Slf4j
public class CacheController {

    @Qualifier("redisTemplate")
    @Autowired
    private RedisTemplate redisTemplate;

    /**
     * 清理所有菜品缓存
     * @return
     */
    @DeleteMapping("/dish")
    public Result cleanDishCache() {
        log.info("清理菜品缓存");
        try {
            Set keys = redisTemplate.keys("dish_*");
            if (keys != null && !keys.isEmpty()) {
                Long deleted = redisTemplate.delete(keys);
                log.info("成功删除 {} 个菜品缓存key", deleted);
                return Result.success("成功清理 " + deleted + " 个菜品缓存");
            } else {
                return Result.success("没有找到菜品缓存");
            }
        } catch (Exception e) {
            log.error("清理缓存失败", e);
            return Result.error("清理缓存失败: " + e.getMessage());
        }
    }

    /**
     * 清理所有缓存
     * @return
     */
    @DeleteMapping("/all")
    public Result cleanAllCache() {
        log.info("清理所有缓存");
        try {
            Set keys = redisTemplate.keys("*");
            if (keys != null && !keys.isEmpty()) {
                Long deleted = redisTemplate.delete(keys);
                log.info("成功删除 {} 个缓存key", deleted);
                return Result.success("成功清理 " + deleted + " 个缓存");
            } else {
                return Result.success("没有找到缓存");
            }
        } catch (Exception e) {
            log.error("清理缓存失败", e);
            return Result.error("清理缓存失败: " + e.getMessage());
        }
    }
}

