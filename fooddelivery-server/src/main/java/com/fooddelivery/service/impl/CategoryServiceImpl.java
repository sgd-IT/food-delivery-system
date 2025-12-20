package com.fooddelivery.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.fooddelivery.constant.MessageConstant;
import com.fooddelivery.dto.CategoryDTO;
import com.fooddelivery.dto.CategoryPageQueryDTO;
import com.fooddelivery.entity.Category;
import com.fooddelivery.exception.DeletionNotAllowedException;
import com.fooddelivery.mapper.CategoryMapper;
import com.fooddelivery.mapper.DishMapper;
import com.fooddelivery.mapper.SetmealMapper;
import com.fooddelivery.result.PageResult;
import com.fooddelivery.service.CategoryService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class CategoryServiceImpl implements CategoryService {

    @Autowired
    private CategoryMapper categoryMapper;
    @Autowired
    private DishMapper dishMapper;
    @Autowired
    private SetmealMapper setmealMapper;

    /**
     * 分类分页查询
     *
     * @param categoryPageQueryDTO
     * @return
     */
    @Override
    public PageResult pageQuery(CategoryPageQueryDTO categoryPageQueryDTO) {
        PageHelper.startPage(categoryPageQueryDTO.getPage(), categoryPageQueryDTO.getPageSize());

        Page<Category> page = categoryMapper.pageQuery(categoryPageQueryDTO);

        return new PageResult(page.getTotal(), page.getResult());
    }

    /**
     * 新增分类
     *
     * @param categoryDTO
     */
    @Override
    public void add(CategoryDTO categoryDTO) {
        Category category = new Category();
        BeanUtils.copyProperties(categoryDTO, category);

        category.setStatus(0);

        categoryMapper.insert(category);
    }

    /**
     * 启用禁用分类
     *
     * @param status
     * @param id
     */
    @Override
    public void startOrStop(Integer status, Long id) {
        Category category = Category.builder()
                .status(status)
                .id(id)
                .build();

        categoryMapper.update(category);
    }

    /**
     * 修改分类
     *
     * @param categoryDTO
     */
    @Override
    public void update(CategoryDTO categoryDTO) {
        Category category = new Category();
        BeanUtils.copyProperties(categoryDTO, category);
        categoryMapper.update(category);
    }

    /**
     * 根据id删除分类
     *
     * @param id
     * @return
     */
    @Override
    public void delById(Long id) {
        Integer count = dishMapper.countByCategoryId(id);
        if (count > 0) {
            throw new DeletionNotAllowedException(MessageConstant.CATEGORY_BE_RELATED_BY_DISH);
        }

        count = setmealMapper.countByCategoryId(id);
        if (count > 0) {
            throw new DeletionNotAllowedException(MessageConstant.CATEGORY_BE_RELATED_BY_SETMEAL);
        }

        categoryMapper.deleteById(id);
    }

    /**
     * 根据类型查询
     *
     * @param type
     * @return
     */
    @Override
    public List<Category> getByType(Integer type) {

        return categoryMapper.getByType(type);
    }

}
