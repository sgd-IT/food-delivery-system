package com.fooddelivery.controller.user;

import com.fooddelivery.constant.StatusConstant;
import com.fooddelivery.entity.Dish;
import com.fooddelivery.result.Result;
import com.fooddelivery.service.DishService;
import com.fooddelivery.vo.DishVO;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * 用户端菜品相关接口控制器
 * 提供菜品查询相关功能
 */
@RestController("userDishController")
@RequestMapping("/user/dish")
@Slf4j
public class DishController {
    @Autowired
    private DishService dishService;
    @Autowired
    private RedisTemplate redisTemplate;

    /**
     * 根据分类id查询菜品
     * 查询时会优先从Redis缓存中获取，如果缓存中不存在则查询数据库并缓存结�?
     *
     * @param categoryId 分类ID
     * @return 菜品列表结果封装
     */
    @GetMapping("/list")
    public Result<List<DishVO>> list(Long categoryId) {
        //构造redis中的key  规则：dish_categoryId
        String key = "dish_" + categoryId;
        //查询redis中是否存在菜品数�?
        List<DishVO> list = (List<DishVO>) redisTemplate.opsForValue().get(key);
        if ((list != null) && (list.size() > 0)) {
            //如果存在，直接返回，无须查询数据�?
            return Result.success(list);
        }

        Dish dish = new Dish();
        dish.setCategoryId(categoryId);
        dish.setStatus(StatusConstant.ENABLE);//查询起售中的菜品

        //如果不存在，查询数据库，将数据缓存到redis
        list = dishService.listWithFlavor(dish);
        redisTemplate.opsForValue().set(key, list);

        return Result.success(list);
    }

}

