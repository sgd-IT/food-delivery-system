package com.fooddelivery.controller.admin;

import com.fooddelivery.result.Result;
import com.fooddelivery.service.ReportService;
import com.fooddelivery.service.WorkspaceService;
import com.fooddelivery.vo.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

/**
 * 数据统计相关接口
 */

@RestController
@RequestMapping("/admin/report")
@Slf4j
public class ReportController {

    @Autowired
    private ReportService reportService;

    @Autowired
    private WorkspaceService workspaceService;

    /**
     * 营业额统�?
     *
     * @param begin
     * @param end
     * @return
     */
    @GetMapping("/turnoverStatistics")
    public Result<TurnoverReportVO> turnoverStatistics(@DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate begin,
                                                       @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate end) {
        log.info("营业额统计：{}，{}", begin, end);
        TurnoverReportVO turnoverReportVO = reportService.turnoverStatistics(begin, end);
        return Result.success(turnoverReportVO);
    }

    /**
     * 用户统计
     *
     * @param begin
     * @param end
     * @return
     */
    @GetMapping("/userStatistics")
    public Result<UserReportVO> userStatistics(@DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate begin,
                                               @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate end) {
        log.info("用户统计：{}，{}", begin, end);
        UserReportVO userReportVO = reportService.userStatistics(begin, end);
        return Result.success(userReportVO);
    }

    /**
     * 订单统计
     *
     * @param begin
     * @param end
     * @return
     */
    @GetMapping("/ordersStatistics")
    public Result<OrderReportVO> orderStatistics(@DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate begin,
                                                 @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate end) {
        log.info("订单统计：{}，{}", begin, end);
        OrderReportVO orderReportVO = reportService.orderStatistics(begin, end);
        return Result.success(orderReportVO);
    }

    /**
     * 销量排�?
     *
     * @return
     */
    @GetMapping("/top10")
    public Result<SalesTop10ReportVO> top10(@DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate begin,
                                            @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate end) {
        log.info("查询销量排名top10 {} , {}", begin, end);
        SalesTop10ReportVO top10ReportVO = reportService.getSalesTop10(begin, end);
        return Result.success(top10ReportVO);
    }

    /**
     * 数据概览
     *
     * @param begin
     * @param end
     * @return
     */
    @GetMapping({"/dataOverView", "/dataOverview"})
    public Result<BusinessDataVO> dataOverView(@DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate begin,
                                               @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate end) {
        log.info("数据概览：{}，{}", begin, end);
        BusinessDataVO businessDataVO = workspaceService.getBusinessData(
                LocalDateTime.of(begin, LocalTime.MIN),
                LocalDateTime.of(end, LocalTime.MAX)
        );
        return Result.success(businessDataVO);
    }

    /**
     * 导出运营数据报表
     * @param response
     */
    @GetMapping("/export")
    public void export(HttpServletResponse response){
        reportService.export(response);
    }
}
