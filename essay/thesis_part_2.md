
# 4 系统设计

## 4.1 系统功能结构设计

系统采用B/S（Browser/Server）架构，主要分为两个客户端：后台管理端（Web）和用户端（微信小程序）。

### 4.1.1 后台管理端功能结构
后台管理端面向餐饮商家，主要功能模块如下：
*   **员工管理**：负责新增员工、编辑员工信息、禁用/启用员工账号。
*   **分类管理**：维护菜品分类和套餐分类，设置分类排序。
*   **菜品管理**：实现菜品的增删改查，支持图片上传和口味配置。
*   **套餐管理**：实现套餐的增删改查，关联菜品。
*   **订单管理**：处理待接单、待派送、派送中、已完成、已取消等各状态订单。
*   **数据统计**：提供营业额、用户、订单、销量排名的可视化报表。

### 4.1.2 用户端（小程序）功能结构
用户端面向消费者，主要功能模块如下：
*   **登录/注册**：基于微信授权的一键登录。
*   **点餐首页**：展示轮播图、菜品分类、菜品列表、购物车入口。
*   **购物车**：添加/减少商品、清空购物车、去结算。
*   **订单中心**：提交订单、支付订单、查看订单状态、再来一单。
*   **个人中心**：地址簿管理、历史订单查询。

## 4.2 系统技术架构设计

本系统采用经典的分层架构设计，自下而上分为：

1.  **数据层（Data Layer）**：
    *   **MySQL**：存储业务数据（用户信息、订单、菜品等）。
    *   **Redis**：缓存热点数据（菜品列表、套餐列表）及临时数据（验证码、购物车）。
2.  **数据访问层（DAO Layer）**：
    *   使用**MyBatis**框架，通过Mapper接口与数据库交互。
    *   定义POJO实体类与数据库表进行映射。
3.  **业务逻辑层（Service Layer）**：
    *   核心业务逻辑处理，如订单状态流转、支付逻辑、报表统计。
    *   利用Spring的`@Transactional`注解控制事务边界。
4.  **接口层（Controller Layer）**：
    *   基于RESTful风格定义API接口。
    *   统一封装返回结果`Result<T>`，包含状态码、错误信息和数据。
    *   使用Swagger生成接口文档。
5.  **表现层（View Layer）**：
    *   **Web端**：Vue.js + Element UI。
    *   **移动端**：微信小程序 + Uni-app。

## 4.3 数据库设计

### 4.3.1 数据库概念结构设计

根据需求分析，提炼出以下核心实体：

1.  **用户（User）**：包含用户ID、姓名、OpenID、手机号、头像等属性。
2.  **员工（Employee）**：包含员工ID、用户名、密码、身份证号、状态等属性。
3.  **菜品（Dish）**：包含菜品ID、名称、价格、图片、描述、状态（起售/停售）等属性。
4.  **套餐（Setmeal）**：包含套餐ID、名称、价格、图片、描述等属性。
5.  **分类（Category）**：包含分类ID、名称、类型（菜品/套餐）、排序等属性。
6.  **订单（Orders）**：包含订单ID、订单号、状态、总金额、下单时间、支付方式、地址等属性。

**实体间关系**：
*   一个分类下可以有多个菜品（1:N）。
*   一个套餐可以包含多个菜品（N:M）。
*   一个用户可以下多个订单（1:N）。
*   一个订单包含多个订单明细（1:N）。

### 4.3.2 数据库表结构设计

本系统数据库名为 `food_delivery_system`，包含以下核心数据表。

**1. 员工表（employee）**

| 字段名 | 数据类型 | 长度 | 约束 | 说明 |
| :--- | :--- | :--- | :--- | :--- |
| id | bigint | 20 | PK, Auto | 主键 |
| username | varchar | 32 | Unique | 用户名 |
| password | varchar | 64 | Not Null | 密码（MD5加密） |
| name | varchar | 32 | Not Null | 姓名 |
| phone | varchar | 11 | Not Null | 手机号 |
| sex | varchar | 2 | Not Null | 性别 |
| id_number | varchar | 18 | Not Null | 身份证号 |
| status | int | 11 | Default 1 | 状态 0:禁用 1:启用 |

**2. 用户表（user）**

| 字段名 | 数据类型 | 长度 | 约束 | 说明 |
| :--- | :--- | :--- | :--- | :--- |
| id | bigint | 20 | PK, Auto | 主键 |
| openid | varchar | 45 | Unique | 微信用户唯一标识 |
| name | varchar | 32 | Nullable | 姓名 |
| phone | varchar | 11 | Nullable | 手机号 |
| avatar | varchar | 500 | Nullable | 头像 |
| create_time | datetime | - | Nullable | 注册时间 |

**3. 分类表（category）**

| 字段名 | 数据类型 | 长度 | 约束 | 说明 |
| :--- | :--- | :--- | :--- | :--- |
| id | bigint | 20 | PK, Auto | 主键 |
| type | int | 11 | Not Null | 类型 1:菜品分类 2:套餐分类 |
| name | varchar | 32 | Not Null | 分类名称 |
| sort | int | 11 | Default 0 | 排序 |
| status | int | 11 | Default 1 | 状态 0:禁用 1:启用 |

**4. 菜品表（dish）**

| 字段名 | 数据类型 | 长度 | 约束 | 说明 |
| :--- | :--- | :--- | :--- | :--- |
| id | bigint | 20 | PK, Auto | 主键 |
| name | varchar | 32 | Not Null | 菜品名称 |
| category_id | bigint | 20 | FK | 菜品分类ID |
| price | decimal | 10,2 | Nullable | 价格 |
| image | varchar | 500 | Nullable | 图片URL |
| description | varchar | 500 | Nullable | 描述信息 |
| status | int | 11 | Default 1 | 状态 0:停售 1:起售 |

**5. 菜品口味表（dish_flavor）**

| 字段名 | 数据类型 | 长度 | 约束 | 说明 |
| :--- | :--- | :--- | :--- | :--- |
| id | bigint | 20 | PK, Auto | 主键 |
| dish_id | bigint | 20 | FK | 关联菜品ID |
| name | varchar | 32 | Nullable | 口味名称（如辣度） |
| value | varchar | 255 | Nullable | 口味数据列表（如["微辣","中辣"]） |

**6. 套餐表（setmeal）**

| 字段名 | 数据类型 | 长度 | 约束 | 说明 |
| :--- | :--- | :--- | :--- | :--- |
| id | bigint | 20 | PK, Auto | 主键 |
| category_id | bigint | 20 | FK | 套餐分类ID |
| name | varchar | 32 | Not Null | 套餐名称 |
| price | decimal | 10,2 | Not Null | 套餐价格 |
| status | int | 11 | Nullable | 状态 0:停用 1:启用 |
| image | varchar | 500 | Nullable | 图片 |

**7. 套餐菜品关系表（setmeal_dish）**

| 字段名 | 数据类型 | 长度 | 约束 | 说明 |
| :--- | :--- | :--- | :--- | :--- |
| id | bigint | 20 | PK, Auto | 主键 |
| setmeal_id | bigint | 20 | FK | 套餐ID |
| dish_id | bigint | 20 | FK | 菜品ID |
| copies | int | 11 | Not Null | 份数 |

**8. 订单表（orders）**

| 字段名 | 数据类型 | 长度 | 约束 | 说明 |
| :--- | :--- | :--- | :--- | :--- |
| id | bigint | 20 | PK, Auto | 主键 |
| number | varchar | 50 | Unique | 订单号 |
| status | int | 11 | Default 1 | 状态 1待付款 2待接单 3已接单 4派送中 5已完成 6已取消 |
| user_id | bigint | 20 | FK | 下单用户ID |
| address_book_id | bigint | 20 | FK | 地址ID |
| order_time | datetime | - | Not Null | 下单时间 |
| pay_method | int | 11 | Default 1 | 支付方式 1微信 2支付宝 |
| amount | decimal | 10,2 | Not Null | 实收金额 |

**9. 订单明细表（order_detail）**

| 字段名 | 数据类型 | 长度 | 约束 | 说明 |
| :--- | :--- | :--- | :--- | :--- |
| id | bigint | 20 | PK, Auto | 主键 |
| order_id | bigint | 20 | FK | 订单ID |
| dish_id | bigint | 20 | FK | 菜品ID |
| setmeal_id | bigint | 20 | FK | 套餐ID |
| dish_flavor | varchar | 50 | Nullable | 口味 |
| number | int | 11 | Default 1 | 数量 |
| amount | decimal | 10,2 | Not Null | 单价 |

## 4.4 系统功能模块详细设计

### 4.4.1 菜品管理功能详细设计

**业务流程**：
1.  管理员点击“新建菜品”。
2.  前端请求获取“菜品分类”列表。
3.  管理员输入菜品名称、价格，选择分类，上传图片。
4.  管理员设置口味（动态添加，如“甜度”：[无糖, 半糖, 全糖]）。
5.  点击保存，前端将JSON数据发送给 `DishController.save`。
6.  后端开启事务，先向 `dish` 表插入基本信息，获取自增ID，再向 `dish_flavor` 表插入多条口味数据。

### 4.4.2 订单管理功能详细设计

**下单流程**：
1.  用户在小程序购物车点击“去结算”。
2.  前端发送 `OrdersSubmitDTO`，包含地址ID、支付方式、预计送达时间等。
3.  后端校验地址簿有效性、购物车是否为空。
4.  后端生成全局唯一的订单号，计算总金额。
5.  向 `orders` 表插入订单主数据，向 `order_detail` 表批量插入明细数据。
6.  清空Redis中当前用户的购物车数据。
7.  返回订单ID和订单号。

**接单流程**：
1.  商家后台Web端与服务器建立WebSocket连接。
2.  用户支付成功后，后端触发支付成功回调，通过WebSocket向Web端推送JSON消息：`{type: 1, orderId: xxx, content: "订单号：xxx"}`。
3.  Web端接收消息，播放提示音，并弹窗提示“您有新的订单”。
4.  商家点击“接单”，前端发送请求更新订单状态为 `CONFIRMED` (3)。

### 4.4.3 数据统计功能详细设计

**设计思路**：
统计报表涉及大量聚合计算（Sum, Count），为保证性能，对于历史数据（昨天及之前）可以考虑定时任务计算后存入统计表，或者直接基于数据库索引进行实时查询（适用于数据量尚可的情况）。本系统采用实时查询方式。

**逻辑流程**：
1.  前端传入日期范围（如2023-10-01至2023-10-07）。
2.  后端根据日期范围生成日期列表。
3.  遍历每一天，构造 `LocalDateTime` 的开始和结束时间。
4.  调用Mapper接口查询该时间段内状态为“已完成”的订单总金额。
5.  将结果封装为 `TurnoverReportVO` 返回给前端，前端使用ECharts渲染。

## 4.5 本章小结

本章完成了系统的总体设计。首先确定了B/S架构和前后端分离的技术路线；其次详细设计了MySQL数据库的表结构，确保满足第三范式要求；最后对核心业务流程进行了详细的逻辑梳理，为下一章的代码实现提供了蓝图。

