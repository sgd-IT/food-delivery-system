package com.fooddelivery.service;


import com.fooddelivery.vo.OrderReportVO;
import com.fooddelivery.vo.SalesTop10ReportVO;
import com.fooddelivery.vo.TurnoverReportVO;
import com.fooddelivery.vo.UserReportVO;

import javax.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.time.LocalDateTime;

public interface ReportService {

    /**
     * 营业额统�?
     * @param begin
     * @param end
     * @return
     */
    TurnoverReportVO turnoverStatistics(LocalDate begin, LocalDate end);

    /**
     * 用户统计
     * @param begin
     * @param end
     * @return
     */
    UserReportVO userStatistics(LocalDate begin, LocalDate end);

    /**
     * 订单统计
     * @param begin
     * @param end
     * @return
     */
    OrderReportVO orderStatistics(LocalDate begin, LocalDate end);

    /**
     * 统计指定时间区间销量排名top10
     * @param begin
     * @param end
     * @return
     */
    SalesTop10ReportVO getSalesTop10(LocalDate begin, LocalDate end);

    /**
     * 导出数据报表
     * @param response
     */
    void export(HttpServletResponse response);
}
