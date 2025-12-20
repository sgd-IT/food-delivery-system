package com.fooddelivery.service;

import com.fooddelivery.dto.CategoryDTO;
import com.fooddelivery.dto.CategoryPageQueryDTO;
import com.fooddelivery.entity.Category;
import com.fooddelivery.result.PageResult;

import java.util.List;

public interface CategoryService {

    /**
     * 分类分页查询
     * @param categoryPageQueryDTO
     * @return
     */
    PageResult pageQuery(CategoryPageQueryDTO categoryPageQueryDTO);

    /**
     * 新增分类
     * @param categoryDTO
     */
    void add(CategoryDTO categoryDTO);

    /**
     * 启用或禁用分�?
     * @param status
     * @param id
     */
    void startOrStop(Integer status, Long id);

    /**
     * 修改分类
     * @param categoryDTO
     */
    void update(CategoryDTO categoryDTO);

    /**
     * 根据id删除
     * @param id
     * @return
     */
    void delById(Long id);

    /**
     * 根据类型查询分类
     * @param type
     * @return
     */
    List<Category> getByType(Integer type);

}