package com.fooddelivery.controller.user;

import com.fooddelivery.constant.JwtClaimsConstant;
import com.fooddelivery.context.BaseContext;
import com.fooddelivery.dto.UserLoginDTO;
import com.fooddelivery.entity.User;
import com.fooddelivery.properties.JwtProperties;
import com.fooddelivery.result.Result;
import com.fooddelivery.service.UserService;
import com.fooddelivery.utils.JwtUtil;
import com.fooddelivery.vo.UserLoginVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/user")
@Api(tags = "C端用户接口")
@Slf4j
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private JwtProperties jwtProperties;

    /**
     * 用户登录接口
     * @param userLoginDTO 用户登录信息数据传输对象，包含登录所需的凭证信�?
     * @return Result<UserLoginVO> 登录结果，包含用户信息和访问令牌
     */
    @PostMapping("/user/login")
    @ApiOperation("用户登录")
    public Result<UserLoginVO> login(@RequestBody UserLoginDTO userLoginDTO){
        log.info("用户登录：{}", userLoginDTO);
        User user = userService.wxLogin(userLoginDTO);

        //为微信用户生成jwt令牌
        Map<String, Object> claims = new HashMap<>();
        claims.put(JwtClaimsConstant.USER_ID, user.getId());
        String token = JwtUtil.createJWT(jwtProperties.getUserSecretKey(), jwtProperties.getUserTtl(), claims);

        UserLoginVO userLoginVO = UserLoginVO.builder()
                //这里的id如果是新用户的话需要主键回显获�?
                .id(user.getId())
                .openid(user.getOpenid())
                .token(token)
                .build();

        return Result.success(userLoginVO);
    }

    /**
     * 获取当前登录用户信息
     * @return Result<User> 当前登录用户信息
     */
    @GetMapping("/info")
    @ApiOperation("获取当前登录用户信息")
    public Result<User> getInfo(){
        Long userId = BaseContext.getCurrentId();
        log.info("获取用户信息，用户id：{}", userId);
        User user = userService.getById(userId);
        return Result.success(user);
    }

}
