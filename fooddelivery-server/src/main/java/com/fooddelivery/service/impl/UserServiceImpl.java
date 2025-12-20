package com.fooddelivery.service.impl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.fooddelivery.constant.MessageConstant;
import com.fooddelivery.dto.UserLoginDTO;
import com.fooddelivery.entity.User;
import com.fooddelivery.exception.LoginFailedException;
import com.fooddelivery.mapper.UserMapper;
import com.fooddelivery.properties.WeChatProperties;
import com.fooddelivery.result.Result;
import com.fooddelivery.service.UserService;
import com.fooddelivery.utils.HttpClientUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

/**
 * 用户服务实现�?
 */
@Service
@Slf4j
public class UserServiceImpl implements UserService {

    public static final String WX_LOGIN = "https://api.weixin.qq.com/sns/jscode2session";

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private WeChatProperties weChatProperties;

    /**
     * 微信登录
     *
     * @param userLoginDTO 登录参数传输对象，包含微信登录所需的code
     * @return 登录成功的用户信�?
     */

    @Override
    public User wxLogin(UserLoginDTO userLoginDTO) {

        // 调用微信接口服务，获取当前openid
        Map<String, String> map = new HashMap<>();
        map.put("appid", weChatProperties.getAppid());
        map.put("secret", weChatProperties.getSecret());
        map.put("js_code", userLoginDTO.getCode());
        map.put("grant_type", "authorization_code");

        // 发送HTTP GET请求到微信接口获取用户信�?
        String json = HttpClientUtil.doGet(WX_LOGIN, map);
        log.info("微信接口返回的JSON数据：{}", json);

        //因为返回的是JSON数据 解析返回的JSON数据获取openid
        JSONObject jsonObject = JSON.parseObject(json);
        String openid = jsonObject.getString("openid");
        log.info("openid：{}", openid);

        // 判断openid是否为空，为空就表示登录失败，则抛出登录异常
        if (openid == null) {
            throw new LoginFailedException(MessageConstant.LOGIN_FAILED);
        }

        // 根据openid查询用户是否存在，判断是否为新用�?
        User user = userMapper.getByOpenid(openid);

        // 如果用户不存在，则创建新用户并插入数据库
        if (user == null) {
            user = User.builder()
                    .openid(openid)
                    .createTime(LocalDateTime.now())
                    .build();
            userMapper.insert(user);
        }
        return user;
    }

    /**
     * 根据id查询用户信息
     * @param id 用户id
     * @return 用户信息
     */
    @Override
    public User getById(Long id) {
        return userMapper.getById(id);
    }
}
