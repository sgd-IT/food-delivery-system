# 摘要

随着移动互联网技术的飞速发展，“互联网+餐饮”已成为行业数字化转型的重要方向。针对当前传统餐饮商家面临的第三方平台佣金高昂、用户数据留存难、经营效率低等痛点，本文设计并实现了一套基于Spring Boot的“云味道”外卖点餐系统。

本系统采用B/S架构，基于前后端分离模式进行开发。后端核心采用Spring Boot框架，结合MyBatis进行数据持久化操作，选用MySQL作为关系型数据库存储业务数据；引入Redis缓存技术优化热点数据的查询性能，利用WebSocket技术实现订单消息的实时推送。前端分为管理端和用户端：管理端基于Vue.js和Element UI构建，实现了菜品管理、套餐配置、订单处理及经营数据可视化统计等功能；用户端采用微信小程序开发，为消费者提供便捷的扫码点餐、购物车管理、在线支付及订单追踪服务。

测试结果表明，该系统功能完善、运行稳定，具有良好的并发处理能力和用户体验。系统的投入使用有效解决了商家在订单流转和库存管理上的效率瓶颈，帮助商家摆脱了对单一流量渠道的依赖，降低了运营成本，对于推动中小型餐饮企业的数字化建设具有一定的实用价值。

**关键词**：Spring Boot；微信小程序；外卖点餐系统；Redis；MySQL

---

# Abstract

With the rapid development of mobile Internet technology, "Internet + Catering" has become an important direction for the digital transformation of the industry. Addressing the pain points faced by traditional catering merchants, such as high commissions on third-party platforms, difficulties in retaining user data, and low operational efficiency, this thesis designs and implements a "Cloud Flavor" food delivery system based on Spring Boot.

The system adopts a B/S architecture and is developed based on the separation of front-end and back-end. The back-end core uses the Spring Boot framework, combines MyBatis for data persistence operations, and selects MySQL as the relational database to store business data. Redis caching technology is introduced to optimize the query performance of hot data, and WebSocket technology is utilized to realize real-time pushing of order messages. The front-end is divided into a management terminal and a user terminal: the management terminal is built based on Vue.js and Element UI, implementing functions such as dish management, set meal configuration, order processing, and visual statistics of business data; the user terminal is developed using WeChat Mini Program, providing consumers with convenient services like scanning to order, shopping cart management, online payment, and order tracking.

The test results show that the system has complete functions and stable operation, with good concurrency processing capability and user experience. The deployment of the system effectively solves the efficiency bottlenecks of merchants in order circulation and inventory management, helps merchants get rid of dependence on a single traffic channel, reduces operating costs, and has certain practical value for promoting the digital construction of small and medium-sized catering enterprises.

**Keywords**: Spring Boot; WeChat Mini Program; Food Delivery System; Redis; MySQL

