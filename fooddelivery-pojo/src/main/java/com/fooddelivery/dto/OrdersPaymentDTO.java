package com.fooddelivery.dto;

import lombok.Data;
import java.io.Serializable;

@Data
public class OrdersPaymentDTO implements Serializable {
    //订单�?
    private String orderNumber;

    //付款方式
    private Integer payMethod;

}
