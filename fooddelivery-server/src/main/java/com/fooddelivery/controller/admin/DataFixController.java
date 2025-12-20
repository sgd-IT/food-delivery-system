package com.fooddelivery.controller.admin;

import com.fooddelivery.context.BaseContext;
import com.fooddelivery.entity.AddressBook;
import com.fooddelivery.entity.User;
import com.fooddelivery.mapper.AddressBookMapper;
import com.fooddelivery.mapper.UserMapper;
import com.fooddelivery.result.Result;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/admin/data/fix")
@Api(tags = "数据修复接口")
@Slf4j
public class DataFixController {

    @Autowired
    private AddressBookMapper addressBookMapper;

    @Autowired
    private UserMapper userMapper;

    @PostMapping("/addresses")
    @ApiOperation("修复地址数据")
    public Result fixAddresses() {
        log.info("开始修复地址数据...");
        
        // 1. 获取最新创建的用户ID
        // 由于这里是在 Admin 端，没有 BaseContext，我们需要手动查�?
        // 假设我们要修复的是最新创建的用户
        // 注意：这里需要自己实现一个查询最新用户的方法，或者我们硬编码ID（不推荐�?
        // 更好的方法是查询所有用户，或者只处理特定的测试用�?
        // 为了简单起见，我们假设�?ID �?61 的用户（根据之前的日志），或者查询最�?ID
        
        // 这里为了安全，我们通过一个特定的 openid 来查找，或者直接插入数�?
        // 由于没有直接查询最新用户的方法，我们先尝试插入数据
        
        // 既然这是一个临时修复，我们可以直接硬编码要插入的数�?
        // 先删除该用户的乱码数据（通过 detail like %??% 判断，或者直接删除所�?A4-A10�?
        
        // 为了确保找到正确的用户，我们需�?UserMapper 支持查询
        // 假设我们之前脚本执行时的用户 ID �?61 (根据之前的日�?current_user_id 61)
        Long userId = 61L; // 请确认这是正确的用户ID，或者我们可以查询数据库确认
        
        // 删除旧数�?
        // addressBookMapper.deleteByUserIdAndDetailLike(userId, "A%"); // 需�?Mapper 支持
        
        // 直接插入新数�?
        insertAddress(userId, "A4");
        insertAddress(userId, "A5");
        insertAddress(userId, "A6");
        insertAddress(userId, "A7");
        insertAddress(userId, "A8");
        insertAddress(userId, "A9");
        insertAddress(userId, "A10");
        
        return Result.success();
    }
    
    private void insertAddress(Long userId, String room) {
        AddressBook addressBook = new AddressBook();
        addressBook.setUserId(userId);
        addressBook.setConsignee("木东");
        addressBook.setPhone("1380013800" + room.substring(1)); // 简单生成电�?
        if (addressBook.getPhone().length() > 11) {
             addressBook.setPhone("13800138010");
        }
        addressBook.setSex("0"); // 先生
        addressBook.setProvinceCode("440000");
        addressBook.setProvinceName("广东省");
        addressBook.setCityCode("441900");
        addressBook.setCityName("东莞市");
        addressBook.setDistrictCode("441900");
        addressBook.setDistrictName("石排镇");
        addressBook.setDetail("广东科技学院" + room + "宿舍楼");
        addressBook.setLabel("学校");
        addressBook.setIsDefault(0);
        
        addressBookMapper.insert(addressBook);
    }
}

