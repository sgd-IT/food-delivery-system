package com.fooddelivery.controller.user;

import com.fooddelivery.dto.OrdersPageQueryDTO;
import com.fooddelivery.dto.OrdersPaymentDTO;
import com.fooddelivery.dto.OrdersSubmitDTO;
import com.fooddelivery.result.PageResult;
import com.fooddelivery.result.Result;
import com.fooddelivery.service.OrderService;
import com.fooddelivery.vo.OrderOverViewVO;
import com.fooddelivery.vo.OrderPaymentVO;
import com.fooddelivery.vo.OrderSubmitVO;
import com.fooddelivery.vo.OrderVO;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;


@RestController("userOrderController")
@RequestMapping("/user/order")
@Slf4j
public class OrderController {

    @Autowired
    private OrderService orderService;

    /**
     * 用户下单
     * @param ordersSubmitDTO
     * @return
     */
    @PostMapping("/submit")
    public Result<OrderSubmitVO> submit(@RequestBody OrdersSubmitDTO ordersSubmitDTO) {
        log.info("用户下单：{}", ordersSubmitDTO);
        OrderSubmitVO orderSubmitVO = orderService.submit(ordersSubmitDTO);
        return Result.success(orderSubmitVO);
    }

    /**
     * 订单支付
     *
     * @param ordersPaymentDTO
     * @return
     */
    @PutMapping("/payment")
    @ApiOperation("订单支付")
    public Result<OrderPaymentVO> payment(@RequestBody OrdersPaymentDTO ordersPaymentDTO) throws Exception {
        log.info("订单支付：{}", ordersPaymentDTO);
        OrderPaymentVO orderPaymentVO = orderService.payment(ordersPaymentDTO);
        log.info("生成预支付交易单：{}", orderPaymentVO);
        return Result.success(orderPaymentVO);
    }

    /**
     * 查询订单详情
     * @param id
     * @return
     */
    @GetMapping("/orderDetail/{id}")
    public Result<OrderVO> queryOrderDetail(@PathVariable Long id) {
        OrderVO orderVO = orderService.queryOrderDetail(id);
        return Result.success(orderVO);
    }

    /**
     * 分页查询历史订单
     * @param ordersPageQueryDTO
     * @return
     */
    @GetMapping("/historyOrders")
    public Result<PageResult> pageHistoryOrders(OrdersPageQueryDTO ordersPageQueryDTO) {
        PageResult pageResult = orderService.pageHistoryOrders(ordersPageQueryDTO);
        return Result.success(pageResult);
    }

    /**
     * 取消订单
     * @param id
     * @return
     */
    @PutMapping("/cancel/{id}")
    public Result cancelOrder(@PathVariable Long id) {
        orderService.cancelOrderById(id);
        return Result.success();
    }

    /**
     * 再次下单
     * @param id
     * @return
     */
    @PostMapping("/repetition/{id}")
    public Result repetitionOrder(@PathVariable Long id) {
        orderService.repetitionOrder(id);
        return Result.success();
    }

    /**
     * 客户催单
     * @param id
     * @return
     */
    @GetMapping("/reminder/{id}")
    public Result reminderOrder(@PathVariable Long id) {
        orderService.reminderOrder(id);
        return Result.success();
    }
}
