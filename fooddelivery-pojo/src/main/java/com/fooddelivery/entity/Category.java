package com.fooddelivery.entity;

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
public class Category implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long id;

    //类型: 1菜品分类 2套餐分类
    private Integer type;

    //分类名称
    private String name;

    //顺序
    private Integer sort;

    //分类状�?0标识禁用 1表示启用
    private Integer status;

    //创建时间
    private LocalDateTime createTime;

    //更新时间
    private LocalDateTime updateTime;

    //创建�?
    private Long createUser;

    //修改�?
    private Long updateUser;
}
