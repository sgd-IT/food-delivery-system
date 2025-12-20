package com.fooddelivery.controller.admin;

import com.fooddelivery.dto.CategoryDTO;
import com.fooddelivery.dto.CategoryPageQueryDTO;
import com.fooddelivery.entity.Category;
import com.fooddelivery.result.PageResult;
import com.fooddelivery.result.Result;
import com.fooddelivery.service.CategoryService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RequestMapping("/admin/category")
@RestController("adminCategoryController")
public class CategoryController {
    @Autowired
    private CategoryService categoryService;

    /**
     * 分类分页查询
     * @param categoryPageQueryDTO
     * @return
     */
    @GetMapping("/page")
    public Result<PageResult> page(CategoryPageQueryDTO categoryPageQueryDTO) {
        log.info("分页查询：{}", categoryPageQueryDTO);
        PageResult pageResult = categoryService.pageQuery(categoryPageQueryDTO);
        return Result.success(pageResult);
    }


    /**
     * 新增分类
     * @param categoryDTO
     * @return
     */
    @PostMapping
    public Result add(@RequestBody CategoryDTO categoryDTO) {
        log.info("新增分类：{}", categoryDTO);
        categoryService.add(categoryDTO);
        return Result.success();
    }

    /**
     * 启用或禁用分�?
     * @param status
     * @param id
     * @return
     */
    @PostMapping("/status/{status}")
    public Result stratOrStop(@PathVariable Integer status, Long id) {
        log.info("启用或禁用分类：{}, {}", status, id);
        categoryService.startOrStop(status, id);
        return Result.success();
    }

    /**
     * 修改分类
     * @param categoryDTO
     * @return
     */
    @PutMapping
    public Result update(@RequestBody CategoryDTO categoryDTO){
        log.info("修改分类：{}", categoryDTO);
        categoryService.update(categoryDTO);
        return Result.success();
    }

    /**
     * 根据id删除分类
     * @param id
     * @return
     */
    @DeleteMapping
    public Result delById(Long id) {
        log.info("查询分类：{}", id);
        categoryService.delById(id);
        return Result.success();
    }

    /**
     * 根据类型查询分类
     * @param type
     * @return
     */
    @GetMapping("/list")
    public Result<List<Category>> getByType(Integer type) {
        log.info("根据类型查询分类：{}", type);
        List<Category> list = categoryService.getByType(type);
        return Result.success(list);
    }
}
