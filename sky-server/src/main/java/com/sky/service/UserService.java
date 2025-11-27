package com.sky.service;

import com.sky.dto.UserLoginDTO;
import com.sky.entity.User;

public interface UserService {

    User wxLogin(UserLoginDTO userLoginDTO);

    /**
     * 根据id查询用户信息
     * @param id 用户id
     * @return 用户信息
     */
    User getById(Long id);
}
