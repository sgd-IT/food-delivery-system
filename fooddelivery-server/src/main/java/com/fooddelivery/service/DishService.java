package com.fooddelivery.service;

import com.fooddelivery.dto.DishDTO;
import com.fooddelivery.dto.DishPageQueryDTO;
import com.fooddelivery.entity.Dish;
import com.fooddelivery.result.PageResult;
import com.fooddelivery.vo.DishVO;

import java.util.List;

public interface DishService {

    /**
     * 新增菜品，同时新增菜品的口味
     * @param dishDTO
     */
    void addWithFlavor(DishDTO dishDTO);

    /**
     * 菜品分页查询
     * @param dishPageQueryDTO
     * @return
     */
    PageResult pageQuery(DishPageQueryDTO dishPageQueryDTO);

    /**
     * 批量删除菜品
     * @param ids
     */
    void delete(List<Long> ids);

    /**
     * 根据id查询菜品和对应的口味数据
     * @param id
     * @return
     */
    DishVO getDishByIdWithFlavor(Long id);

    /**
     * 修改菜品
     * @param dishDTO
     */
    void updateWithFlavor(DishDTO dishDTO);

    /**
     * 根据分类id查询菜品选项
     * @param categoryId
     * @return
     */
    List<Dish> getDishByCategoryId(Long categoryId);

    /**
     * 条件查询菜品和口�?
     * @param dish
     * @return
     */
    List<DishVO> listWithFlavor(Dish dish);

    /**
     * 菜品起售、停�?
     * @param status
     * @param id
     */
    void startOrStop(Integer status, Long id);
}