package com.fooddelivery.annotation;

import com.fooddelivery.enumeration.OperationType;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 自定义注解，用于标识需要自动填充的字段
 */
@Target(ElementType.METHOD)// 表示注解只能用于方法�?
@Retention(RetentionPolicy.RUNTIME)// 表示注解在运行时生效

public @interface AutoFill {
    //数据库操作类�?UPDATE INSERT
    OperationType value();
}
