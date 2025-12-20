package com.fooddelivery.controller.admin;

import com.fooddelivery.result.Result;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.*;

@RestController("adminShopController")
@RequestMapping("/admin/shop")
@Slf4j
public class ShopController {

    private static final String KEY = "SHOP_STATUS";

    @Autowired
    private RedisTemplate redisTemplate;

    /**
     * 设置起售停售状�?
     * @param status
     * @return
     */
    @PutMapping("/{status}")
    public Result setStatus(@PathVariable Integer status) {
        log.info("设置店铺营业状态：{}", status == 1 ? "营业中" : "打烊中");
        redisTemplate.opsForValue().set(KEY, status);
        return Result.success();
    }

    /**
     * 获取店铺营业状�?
     * @return
     */
    @GetMapping("/status")
    public Result<Integer> getStatus() {
        Integer status = (Integer) redisTemplate.opsForValue().get(KEY);

        // 如果Redis中没有设置状态，可以返回默认状�?
        if (status == null) {
            status = 0; // 默认为打烊状�?
            log.info("获取店铺营业状态：打烊中(默认)");
        } else {
            log.info("获取店铺营业状态：{}", status == 1 ? "营业中" : "打烊中");
        }

        return Result.success(status);
    }

}
