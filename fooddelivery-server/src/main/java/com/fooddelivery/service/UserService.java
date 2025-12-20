package com.fooddelivery.service;

import com.fooddelivery.dto.UserLoginDTO;
import com.fooddelivery.entity.User;

public interface UserService {

    User wxLogin(UserLoginDTO userLoginDTO);

    /**
     * 根据id查询用户信息
     * @param id 用户id
     * @return 用户信息
     */
    User getById(Long id);
}
