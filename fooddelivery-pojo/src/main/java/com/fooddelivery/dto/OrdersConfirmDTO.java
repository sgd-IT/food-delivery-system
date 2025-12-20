package com.fooddelivery.dto;

import lombok.Data;

import java.io.Serializable;

@Data
public class OrdersConfirmDTO implements Serializable {

    private Long id;
    //订单状�?1待付�?2待接�?3 已接�?4 派送中 5 已完�?6 已取�?7 退�?
    private Integer status;

}
