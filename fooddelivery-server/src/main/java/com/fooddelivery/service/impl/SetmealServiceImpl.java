package com.fooddelivery.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.fooddelivery.constant.MessageConstant;
import com.fooddelivery.constant.StatusConstant;
import com.fooddelivery.dto.SetmealDTO;
import com.fooddelivery.dto.SetmealPageQueryDTO;
import com.fooddelivery.entity.Dish;
import com.fooddelivery.entity.Setmeal;
import com.fooddelivery.entity.SetmealDish;
import com.fooddelivery.mapper.DishMapper;
import com.fooddelivery.mapper.SetmealDishMapper;
import com.fooddelivery.mapper.SetmealMapper;
import com.fooddelivery.result.PageResult;
import com.fooddelivery.service.SetmealService;
import com.fooddelivery.vo.DishItemVO;
import com.fooddelivery.vo.SetmealVO;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 套餐业务实现�?
 */
@Service
public class SetmealServiceImpl implements SetmealService {

    @Autowired
    private SetmealMapper setmealMapper;
    @Autowired
    private SetmealDishMapper setmealDishMapper;
    @Autowired
    private DishMapper dishMapper;

    /**
     * 新增套餐及其关联的菜�?
     *
     * @param setmealDTO 套餐数据传输对象，包含套餐基本信息和关联的菜品列�?
     */
    @Override
    public void addWithDishes(SetmealDTO setmealDTO) {
        Setmeal setmeal = new Setmeal();
        BeanUtils.copyProperties(setmealDTO, setmeal);

        // 插入套餐基本信息
        setmealMapper.insert(setmeal);

        //获取新增套餐的id
        Long setmealId = setmeal.getId();

        List<SetmealDish> setmealDishes = setmealDTO.getSetmealDishes();
        // 如果套餐关联了菜品，则批量插入套餐菜品关联数�?
        if (setmealDishes != null && setmealDishes.size() > 0) {
            setmealDishes.forEach(setmealDish -> setmealDish.setSetmealId(setmealId));
            setmealDishMapper.insertBatch(setmealDishes);
        }

    }

    /**
     * 分页查询
     *
     * @param setmealPageQueryDTO
     * @return
     */
    @Override
    public PageResult pageQuery(SetmealPageQueryDTO setmealPageQueryDTO) {
        PageHelper.startPage(setmealPageQueryDTO.getPage(), setmealPageQueryDTO.getPageSize());

        Page<SetmealVO> page = setmealMapper.pageQuery(setmealPageQueryDTO);

        return new PageResult(page.getTotal(), page.getResult());
    }

    /**
     * @param ids
     */
    @Override
    public void delete(List<Long> ids) {
        ids.forEach(id -> {
            Setmeal setmeal = setmealMapper.getById(id);
            if (setmeal.getStatus() == 1) {
                throw new RuntimeException(MessageConstant.SETMEAL_ON_SALE);
            }

            setmealMapper.deleteById(id);
            setmealDishMapper.deleteBySetmealId(id);
        });
    }

    /**
     * 根据id查询套餐
     *
     * @param id 套餐ID
     * @return 套餐信息VO对象，包含套餐基本信息和关联的菜品信�?
     */
    @Override
    public SetmealVO getById(Long id) {
        // 查询套餐基本信息
        Setmeal setmeal = setmealMapper.getById(id);

        // 复制套餐基本信息到VO对象
        SetmealVO setmealVO = new SetmealVO();
        BeanUtils.copyProperties(setmeal, setmealVO);

        // 查询并设置套餐关联的菜品信息
        setmealVO.setSetmealDishes(setmealDishMapper.getBySetmealId(id));

        return setmealVO;
    }

    /**
     * 修改套餐信息
     *
     * @param setmealDTO 套餐数据传输对象
     */
    @Override
    @Transactional
    public void update(SetmealDTO setmealDTO) {
        // 更新套餐基本信息
        Setmeal setmeal = new Setmeal();
        BeanUtils.copyProperties(setmealDTO, setmeal);
        setmealMapper.update(setmeal);

        // 重新关联菜品信息：先删除原有关系，再插入新关�?
        setmealDishMapper.deleteBySetmealId(setmealDTO.getId());

        // 获取套餐菜品列表
        List<SetmealDish> setmealDishes = setmealDTO.getSetmealDishes();
        // 如果套餐菜品列表不为空，则批量插入套餐菜品关联数�?
        if (setmealDishes != null && !setmealDishes.isEmpty()) {
            // 为每个套餐菜品设置套餐ID
            setmealDishes.forEach(setmealDish -> setmealDish.setSetmealId(setmealDTO.getId()));
            // 批量插入套餐菜品关联数据
            setmealDishMapper.insertBatch(setmealDishes);

        }
    }

    /**
     * 启用或停用套�?
     *
     * @param status 套餐状态，ENABLE为启用，DISABLE为停�?
     * @param id     套餐ID
     */
    @Override
    public void startOrStop(Integer status, Long id) {
//        - 可以对状态为起售的套餐进行停售操作，可以对状态为停售的套餐进行起售操�?
//        - 起售套餐时，如果套餐内包含停售的菜品，则不能起售

        // 检查启用套餐的条件：如果要启用套餐，需要确保套餐内所有菜品都处于启用状�?
        if (status == StatusConstant.ENABLE) {
            List<Dish> dishlist = dishMapper.getBySetmealId(id);
            if (dishlist != null && dishlist.size() > 0) {
                dishlist.forEach(dish -> {
                    if (dish.getStatus() == StatusConstant.DISABLE) {
                        throw new RuntimeException(MessageConstant.SETMEAL_ENABLE_FAILED);
                    }
                });
            }
        }
//        //TODO 起售的套餐可以展示在用户端，停售的套餐不能展示在用户�?

        // 更新套餐状�?
        Setmeal setmeal = Setmeal.builder()
                .id(id)
                .status(status)
                .build();
        setmealMapper.update(setmeal);
    }

    /**
     * 条件查询
     *
     * @param setmeal
     * @return
     */
    public List<Setmeal> list(Setmeal setmeal) {
        List<Setmeal> list = setmealMapper.list(setmeal);
        return list;
    }

    /**
     * 根据id查询菜品选项
     *
     * @param id
     * @return
     */
    public List<DishItemVO> getDishItemById(Long id) {
        return setmealMapper.getDishItemBySetmealId(id);
    }

}
