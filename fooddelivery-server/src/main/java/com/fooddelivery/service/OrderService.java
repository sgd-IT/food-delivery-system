package com.fooddelivery.service;

import com.fooddelivery.dto.*;
import com.fooddelivery.result.PageResult;
import com.fooddelivery.vo.OrderPaymentVO;
import com.fooddelivery.vo.OrderStatisticsVO;
import com.fooddelivery.vo.OrderSubmitVO;
import com.fooddelivery.vo.OrderVO;

public interface OrderService {
    /**
     * 用户下单
     * @param ordersSubmitDTO
     * @return
     */
    OrderSubmitVO submit(OrdersSubmitDTO ordersSubmitDTO);

    /**
     * 订单支付
     * @param ordersPaymentDTO
     * @return
     */
    OrderPaymentVO payment(OrdersPaymentDTO ordersPaymentDTO) throws Exception;

    /**
     * 查询订单详情
     * @param id
     * @return
     */
    OrderVO queryOrderDetail(Long id);

    /**
     * 历史订单分页查询
     * @param ordersPageQueryDTO
     * @return
     */
    PageResult pageHistoryOrders(OrdersPageQueryDTO ordersPageQueryDTO);

    /**
     * 取消订单
     * @param id
     */
    void cancelOrderById(Long id);

    /**
     * 再次下单
     * @param id
     */
    void repetitionOrder(Long id);

    /**
     * 订单搜索
     * @param ordersPageQueryDTO
     * @return
     */
    PageResult conditionSearch(OrdersPageQueryDTO ordersPageQueryDTO);

    /**
     * 各个状态的订单数量统计
     * @return
     */
    OrderStatisticsVO statisticsNum();

    /**
     * 接单
     * @param ordersConfirmDTO
     */
    void confirmOrder(OrdersConfirmDTO ordersConfirmDTO);

    /**
     * 拒单
     * @param ordersRejectionDTO
     */
    void rejectionOrder(OrdersRejectionDTO ordersRejectionDTO);

    /**
     * 取消订单
     * @param ordersCancelDTO
     */
    void cancelOrder(OrdersCancelDTO ordersCancelDTO);

    /**
     * 派送订�?
     * @param id
     */
    void deliveryOrder(Long id);

    /**
     * 完成订单
     * @param id
     */
    void completeOrder(Long id);

    /**
     * 客户催单
     * @param id
     */
    void reminderOrder(Long id);

    /**
     * 支付成功，修改订单状�?
     * @param outTradeNo
     */
//    void paySuccess(String outTradeNo);

}
