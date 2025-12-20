package com.fooddelivery.service;

import com.fooddelivery.dto.ShoppingCartDTO;
import com.fooddelivery.entity.ShoppingCart;

import java.util.List;

public interface ShoppingCartService {
    /**
     * 添加购物�?
     * @param shoppingCartDTO
     */
    void add(ShoppingCartDTO shoppingCartDTO);

    /**
     * 查看购物车列�?
     * @return
     */
    List<ShoppingCart> showShoppingCart();

    /**
     * 清空购物�?
     */
    void clean();

    /**
     * 删除购物车中一个商�?
     * @param shoppingCartDTO
     */
    void sub(ShoppingCartDTO shoppingCartDTO);
}
