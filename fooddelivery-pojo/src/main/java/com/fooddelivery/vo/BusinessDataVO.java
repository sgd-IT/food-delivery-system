package com.fooddelivery.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * 数据概览
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class BusinessDataVO implements Serializable {

    private Double turnover;//营业�?

    private Integer validOrderCount;//有效订单�?

    private Double orderCompletionRate;//订单完成�?

    private Double unitPrice;//平均客单�?

    private Integer newUsers;//新增用户�?

}
