package com.fooddelivery.interceptor;

import com.fooddelivery.constant.JwtClaimsConstant;
import com.fooddelivery.context.BaseContext;
import com.fooddelivery.properties.JwtProperties;
import com.fooddelivery.utils.JwtUtil;
import io.jsonwebtoken.Claims;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * jwt令牌校验的拦截器
 */
@Component
@Slf4j
public class JwtTokenAdminInterceptor implements HandlerInterceptor {

    @Autowired
    private JwtProperties jwtProperties;

    /**
     * 校验jwt
     *
     * @param request
     * @param response
     * @param handler
     * @return
     * @throws Exception
     */
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        //判断当前拦截到的是Controller的方法还是其他资�?
        if (!(handler instanceof HandlerMethod)) {
            //当前拦截到的不是动态方法，直接放行
            return true;
        }

        //1、从请求头中获取令牌
        String tokenName = jwtProperties.getAdminTokenName();
        String token = request.getHeader(tokenName);
        
        log.info("JWT拦截�?- 请求路径: {}, Token名称: {}, Token�? {}", 
                request.getRequestURI(), tokenName, token != null ? "存在" : "为空");

        //2、校验令�?
        if (token == null || token.isEmpty()) {
            log.warn("JWT拦截�?- Token为空，请求路�? {}", request.getRequestURI());
            response.setStatus(401);
            return false;
        }
        
        try {
            log.info("JWT拦截�?- 开始校验Token");
            Claims claims = JwtUtil.parseJWT(jwtProperties.getAdminSecretKey(), token);
            //获取员工id
            Long empId = Long.valueOf(claims.get(JwtClaimsConstant.EMP_ID).toString());
            log.info("JWT拦截�?- Token校验成功，当前员工id：{}", empId);
            //将员工id放入ThreadLocal
            BaseContext.setCurrentId(empId);
            log.info("JWT拦截�?- BaseContext已设置，当前ID：{}", BaseContext.getCurrentId());

            //3、通过，放�?
            return true;
        } catch (Exception ex) {
            //4、不通过，响�?01状态码
            log.error("JWT拦截�?- Token校验失败: {}", ex.getMessage(), ex);
            response.setStatus(401);
            return false;
        }
    }
}
