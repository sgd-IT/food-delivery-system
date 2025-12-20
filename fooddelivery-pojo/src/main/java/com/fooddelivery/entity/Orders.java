package com.fooddelivery.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 订单
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Orders implements Serializable {

    /**
     * 订单状�?1待付�?2待接�?3已接�?4派送中 5已完�?6已取�?
     */
    public static final Integer PENDING_PAYMENT = 1;
    public static final Integer TO_BE_CONFIRMED = 2;
    public static final Integer CONFIRMED = 3;
    public static final Integer DELIVERY_IN_PROGRESS = 4;
    public static final Integer COMPLETED = 5;
    public static final Integer CANCELLED = 6;

    /**
     * 支付状�?0未支�?1已支�?2退�?
     */
    public static final Integer UN_PAID = 0;
    public static final Integer PAID = 1;
    public static final Integer REFUND = 2;

    private static final long serialVersionUID = 1L;

    private Long id;

    //订单�?
    private String number;

    //订单状�?1待付�?2待接�?3已接�?4派送中 5已完�?6已取�?7退�?
    private Integer status;

    //下单用户id
    private Long userId;

    //地址id
    private Long addressBookId;

    //下单时间
    private LocalDateTime orderTime;

    //结账时间
    private LocalDateTime checkoutTime;

    //支付方式 1微信�?支付�?
    private Integer payMethod;

    //支付状�?0未支�?1已支�?2退�?
    private Integer payStatus;

    //实收金额
    private BigDecimal amount;

    //备注
    private String remark;

    //用户�?
    private String userName;

    //手机�?
    private String phone;

    //地址
    private String address;

    //收货�?
    private String consignee;

    //订单取消原因
    private String cancelReason;

    //订单拒绝原因
    private String rejectionReason;

    //订单取消时间
    private LocalDateTime cancelTime;

    //预计送达时间
    private LocalDateTime estimatedDeliveryTime;

    //配送状�? 1立即送出  0选择具体时间
    private Integer deliveryStatus;

    //送达时间
    private LocalDateTime deliveryTime;

    //打包�?
    private int packAmount;

    //餐具数量
    private int tablewareNumber;

    //餐具数量状�? 1按餐量提�? 0选择具体数量
    private Integer tablewareStatus;
    
    //订单类型 1:堂食自取 2:外卖配�?
    private Integer orderType;
}