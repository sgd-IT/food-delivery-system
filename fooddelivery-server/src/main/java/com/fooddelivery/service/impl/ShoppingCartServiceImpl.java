package com.fooddelivery.service.impl;

import com.fasterxml.jackson.databind.ser.Serializers;
import com.fooddelivery.context.BaseContext;
import com.fooddelivery.dto.ShoppingCartDTO;
import com.fooddelivery.entity.Dish;
import com.fooddelivery.entity.Setmeal;
import com.fooddelivery.entity.ShoppingCart;
import com.fooddelivery.mapper.DishMapper;
import com.fooddelivery.mapper.SetmealMapper;
import com.fooddelivery.mapper.ShoppingCartMapper;
import com.fooddelivery.service.ShoppingCartService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.beans.beancontext.BeanContext;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class ShoppingCartServiceImpl implements ShoppingCartService {

    @Autowired
    private ShoppingCartMapper shoppingCartMapper;
    @Autowired
    private DishMapper dishMapper;
    @Autowired
    private SetmealMapper setmealMapper;

    /**
     * 添加购物�?
     *
     * @param shoppingCartDTO
     */
    @Override
    public void add(ShoppingCartDTO shoppingCartDTO) {
        //判断购物车中是否已经存在该商�?
        ShoppingCart shoppingCart = new ShoppingCart();
        BeanUtils.copyProperties(shoppingCartDTO, shoppingCart);

        //shoppingCartDTO里面没有userId
        Long userId = BaseContext.getCurrentId();
        shoppingCart.setUserId(userId);
        List<ShoppingCart> list = shoppingCartMapper.list(shoppingCart);

        //如果存在，只需要更新数量即�?
        if (list != null && list.size() > 0) {
            ShoppingCart cart = list.get(0);
            cart.setNumber(cart.getNumber() + 1);
            shoppingCartMapper.updateNumberById(cart);
        } else {
            //如果不存在，需要新�?
            //判断添加的是菜品还是套餐
            Long dishId = shoppingCartDTO.getDishId();
            Long setmealId = shoppingCartDTO.getSetmealId();
            if (dishId != null) {
                //添加的是菜品
                Dish dish = dishMapper.getById(dishId);
                shoppingCart.setName(dish.getName());
                shoppingCart.setImage(dish.getImage());
                shoppingCart.setAmount(dish.getPrice());
            } else {
                //添加的是套餐
                Setmeal setmeal = setmealMapper.getById(setmealId);
                shoppingCart.setName(setmeal.getName());
                shoppingCart.setImage(setmeal.getImage());
                shoppingCart.setAmount(setmeal.getPrice());
                shoppingCart.setSetmealId(setmealId);
            }
            shoppingCart.setNumber(1);
            shoppingCart.setCreateTime(LocalDateTime.now());
            shoppingCartMapper.insert(shoppingCart);
        }
    }

    /**
     * 查看购物车列�?
     *
     * @return
     */
    @Override
    public List<ShoppingCart> showShoppingCart() {
        // 获取当前用户ID
        Long id = BaseContext.getCurrentId();
        // 构建购物车查询条�?
        ShoppingCart shoppingCart = ShoppingCart.builder()
                .userId(id)
                .build();
        // 查询购物车列�?
        List<ShoppingCart> list = shoppingCartMapper.list(shoppingCart);
        return list;
    }

    /**
     * 清空购物�?
     */
    @Override
    public void clean() {
        // 获取当前用户ID
        Long id = BaseContext.getCurrentId();

        shoppingCartMapper.deleteByUserId(id);
    }

    /**
     * 减购物车商品数量
     * @param shoppingCartDTO
     */
    @Override
    public void sub(ShoppingCartDTO shoppingCartDTO) {
        //构建查询条件
        ShoppingCart shoppingCart = new ShoppingCart();
        BeanUtils.copyProperties(shoppingCartDTO, shoppingCart);
        shoppingCart.setUserId(BaseContext.getCurrentId()); // 确保用户ID

        //查询购物车中的商�?
        List<ShoppingCart> list = shoppingCartMapper.list(shoppingCart);
        if (list != null && !list.isEmpty()) {
            ShoppingCart cart = list.get(0);
            Integer number = cart.getNumber() != null ? cart.getNumber() : 0;

            if (number <= 1) {
                // 数量小于等于1直接删除
                shoppingCartMapper.delete(cart);
            } else {
                // 数量�?
                cart.setNumber(number - 1);
                shoppingCartMapper.updateNumberById(cart);
            }
        }
    }
}
