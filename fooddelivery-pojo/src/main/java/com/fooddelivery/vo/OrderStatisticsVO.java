package com.fooddelivery.vo;

import lombok.Data;
import java.io.Serializable;

@Data
public class OrderStatisticsVO implements Serializable {
    //待接单数�?
    private Integer toBeConfirmed;

    //待派送数�?
    private Integer confirmed;

    //派送中数量
    private Integer deliveryInProgress;
}
