package com.fooddelivery.controller.user;

import com.fooddelivery.dto.ShoppingCartDTO;
import com.fooddelivery.entity.ShoppingCart;
import com.fooddelivery.result.Result;
import com.fooddelivery.service.ShoppingCartService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/user/shoppingCart")
@Slf4j
public class ShoppingCartController {

    @Autowired
    private ShoppingCartService shoppingCartService;

    /**
     * 添加购物�?
     *
     * @param shoppingCartDTO
     * @return
     */
    @PostMapping("/add")
    public Result add(@RequestBody ShoppingCartDTO shoppingCartDTO) {
        log.info("添加购物车：{}", shoppingCartDTO);
        shoppingCartService.add(shoppingCartDTO);
        return Result.success();
    }

    @GetMapping("/list")
    public Result<List<ShoppingCart>> list() {
        log.info("查询购物车");
        List<ShoppingCart> list = shoppingCartService.showShoppingCart();
        return Result.success(list);
    }

    /**
     * 清空购物�?
     * @return
     */
    @DeleteMapping("/clean")
    public Result clean() {
        log.info("清空购物车");
        shoppingCartService.clean();
        return Result.success();
    }

    /**
     * 减购物车商品数量
     * @param shoppingCartDTO
     * @return
     */
    @PostMapping("/sub")
    public Result sub(@RequestBody ShoppingCartDTO shoppingCartDTO) {
        log.info("删除购物车商品：{}", shoppingCartDTO);
        shoppingCartService.sub(shoppingCartDTO);
        return Result.success();
    }
}
