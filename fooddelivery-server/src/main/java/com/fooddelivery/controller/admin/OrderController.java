package com.fooddelivery.controller.admin;

import com.fooddelivery.dto.OrdersCancelDTO;
import com.fooddelivery.dto.OrdersConfirmDTO;
import com.fooddelivery.dto.OrdersPageQueryDTO;
import com.fooddelivery.dto.OrdersRejectionDTO;
import com.fooddelivery.result.PageResult;
import com.fooddelivery.result.Result;
import com.fooddelivery.service.OrderService;
import com.fooddelivery.vo.OrderOverViewVO;
import com.fooddelivery.vo.OrderStatisticsVO;
import com.fooddelivery.vo.OrderVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.annotation.Order;
import org.springframework.web.bind.annotation.*;

@RestController("adminOrderController")
@RequestMapping("/admin/order")
@Slf4j
public class OrderController {

    @Autowired
    private OrderService orderService;

    /**
     * 查询订单详情
     *
     * @param id
     * @return
     */
    @GetMapping("/details/{id}")
    public Result<OrderVO> queryOrderDetail(@PathVariable Long id) {
        OrderVO orderVO = orderService.queryOrderDetail(id);
        return Result.success(orderVO);
    }

    /**
     * 订单搜索
     *
     * @param ordersPageQueryDTO
     * @return
     */
    @GetMapping("/conditionSearch")
    public Result<PageResult> pageConditionSearch(OrdersPageQueryDTO ordersPageQueryDTO) {
        PageResult pageResult = orderService.conditionSearch(ordersPageQueryDTO);
        return Result.success(pageResult);
    }

    /**
     * 各个状态的订单数量统计
     *
     * @return
     */
    @GetMapping("/statistics")
    public Result<OrderStatisticsVO> statisticsNum() {
        OrderStatisticsVO orderStatisticsVO = orderService.statisticsNum();
        return Result.success(orderStatisticsVO);
    }

    /**
     * 接单
     *
     * @param ordersConfirmDTO
     * @return
     */
    @PutMapping("/confirm")
    public Result confirm(@RequestBody OrdersConfirmDTO ordersConfirmDTO) {
        orderService.confirmOrder(ordersConfirmDTO);
        return Result.success();
    }

    /**
     * 拒单
     *
     * @param ordersRejectionDTO
     * @return
     */
    @PutMapping("/rejection")
    public Result rejectionOrder(@RequestBody OrdersRejectionDTO ordersRejectionDTO) {
        orderService.rejectionOrder(ordersRejectionDTO);
        return Result.success();
    }

    /**
     * 取消订单
     *
     * @param ordersCancelDTO
     * @return
     */
    @PutMapping("/cancel")
    public Result cancelOrder(@RequestBody OrdersCancelDTO ordersCancelDTO) {
        orderService.cancelOrder(ordersCancelDTO);
        return Result.success();
    }

    /**
     * 派送订�?
     *
     * @param id
     * @return
     */
    @PutMapping("/delivery/{id}")
    public Result deliveryOrder(@PathVariable Long id) {
        orderService.deliveryOrder(id);
        return Result.success();
    }

    /**
     * 完成订单
     * @param id
     * @return
     */
    @PutMapping("/complete/{id}")
    public Result completeOrder(@PathVariable Long id) {
        orderService.completeOrder(id);
        return Result.success();
    }


    //TODO 校验收货地址是否超出配送范�?学完再去完善
}
