package com.fooddelivery.controller.admin;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.fooddelivery.constant.JwtClaimsConstant;
import com.fooddelivery.dto.EmployeeDTO;
import com.fooddelivery.dto.EmployeeLoginDTO;
import com.fooddelivery.dto.EmployeePageQueryDTO;
import com.fooddelivery.entity.Employee;
import com.fooddelivery.properties.JwtProperties;
import com.fooddelivery.result.PageResult;
import com.fooddelivery.result.Result;
import com.fooddelivery.service.EmployeeService;
import com.fooddelivery.context.BaseContext;
import com.fooddelivery.utils.JwtUtil;
import com.fooddelivery.vo.EmployeeLoginVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

/**
 * 员工管理
 */
@RestController
@RequestMapping("/admin/employee")
@Slf4j
public class  EmployeeController {

    @Autowired
    private EmployeeService employeeService;
    @Autowired
    private JwtProperties jwtProperties;

    /**
     * 登录
     *
     * @param employeeLoginDTO
     * @return
     */
    @PostMapping("/login")
    public Result<EmployeeLoginVO> login(@RequestBody EmployeeLoginDTO employeeLoginDTO) {
        log.info("员工登录：{}", employeeLoginDTO);

        Employee employee = employeeService.login(employeeLoginDTO);

        //登录成功后，生成jwt令牌
        Map<String, Object> claims = new HashMap<>();
        claims.put(JwtClaimsConstant.EMP_ID, employee.getId());
        String token = JwtUtil.createJWT(
                jwtProperties.getAdminSecretKey(),
                jwtProperties.getAdminTtl(),
                claims);

        EmployeeLoginVO employeeLoginVO = EmployeeLoginVO.builder()
                .id(employee.getId())
                .userName(employee.getUsername())
                .name(employee.getName())
                .token(token)
                .build();

        return Result.success(employeeLoginVO);
    }

    /**
     * 退出
     *
     * @return
     */
    @PostMapping("/logout")
    public Result<String> logout() {
        return Result.success();
    }

    /**
     * 新增员工
     *
     * @return
     */
    @PostMapping
    public Result addEmployee(@RequestBody EmployeeDTO employeeDTO) {
        log.info("新增员工：{}", employeeDTO);
        employeeService.addEmployee(employeeDTO);
        return Result.success();
    }

    /**
     * 获取当前登录员工信息（必须在 /{id} 之前，避免路径冲突）
     * @return
     */
    @GetMapping("/info")
    public Result<Employee> getInfo(){
        Long empId = BaseContext.getCurrentId();
        log.info("获取当前登录员工信息，员工id：{}", empId);
        
        if (empId == null) {
            log.error("获取当前登录员工信息失败：员工id为空");
            return Result.error("未登录或登录已过期，请重新登录");
        }
        
        Employee employee = employeeService.getById(empId);
        if (employee == null) {
            log.error("获取当前登录员工信息失败：员工不存在，id：{}", empId);
            return Result.error("员工信息不存在");
        }
        
        return Result.success(employee);
    }

    /**
     * 分页查询
     * @param 、、page
     * @param 、、pageSize
     * @return
     */
    @GetMapping("/page")
    public Result<PageResult> Page(EmployeePageQueryDTO employeePageQueryDTO){
        log.info("分页查询：{}", employeePageQueryDTO);
        PageResult pageResult = employeeService.pageQuery(employeePageQueryDTO);
        return Result.success(pageResult);
    }

    /**
     * 启用禁用员工账号
     * @param status
     * @param id
     * @return
     */
    @PostMapping("/status/{status}")
    public Result startOrStop(@PathVariable Integer status, Long id){
        log.info("员工状态：{}，员工id：{}", status, id);
        employeeService.startOrStop(status, id);
        return Result.success();
    }

    /**
     * 根据id查询员工信息（必须在所有具体路径之后）
     * 使用正则表达式约束，只匹配数字ID，避免与 /info 等路径冲�?
     * @param id 员工ID
     * @return
     */
    @GetMapping("/{id:\\d+}")
    public Result<Employee> getById(@PathVariable Long id){
        log.info("根据ID查询员工信息：{}", id);
        Employee employee = employeeService.getById(id);
        return Result.success(employee);
    }

    /**
     * 编辑员工信息
     * @param employeeDTO
     * @return
     */
    @PutMapping
    public Result update(@RequestBody EmployeeDTO employeeDTO){
        log.info("编辑员工信息：{}", employeeDTO);
        employeeService.update(employeeDTO);
        return Result.success();
    }
}
