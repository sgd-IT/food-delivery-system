package com.fooddelivery.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class OrderPaymentVO implements Serializable {

    private String nonceStr; //随机字符�?
    private String paySign; //签名
    private String timeStamp; //时间�?
    private String signType; //签名算法
    private String packageStr; //统一下单接口返回�?prepay_id 参数�?

}
