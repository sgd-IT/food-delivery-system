package com.fooddelivery.service.impl;


import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.fooddelivery.constant.MessageConstant;
import com.fooddelivery.constant.PasswordConstant;
import com.fooddelivery.constant.StatusConstant;
import com.fooddelivery.context.BaseContext;
import com.fooddelivery.dto.EmployeeDTO;
import com.fooddelivery.dto.EmployeeLoginDTO;
import com.fooddelivery.dto.EmployeePageQueryDTO;
import com.fooddelivery.entity.Employee;
import com.fooddelivery.exception.AccountLockedException;
import com.fooddelivery.exception.AccountNotFoundException;
import com.fooddelivery.exception.PasswordErrorException;
import com.fooddelivery.mapper.EmployeeMapper;
import com.fooddelivery.result.PageResult;
import com.fooddelivery.service.EmployeeService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.DigestUtils;

import java.time.LocalDateTime;

@Service
public class EmployeeServiceImpl implements EmployeeService {

    @Autowired
    private EmployeeMapper employeeMapper;

    /**
     * 员工登录
     *
     * @param employeeLoginDTO
     * @return
     */
    public Employee login(EmployeeLoginDTO employeeLoginDTO) {
        String username = employeeLoginDTO.getUsername();
        String password = employeeLoginDTO.getPassword();

        //1、根据用户名查询数据库中的数�?
        Employee employee = employeeMapper.getByUsername(username);

        //2、处理各种异常情况（用户名不存在、密码不对、账号被锁定�?
        if (employee == null) {
            //账号不存�?
            throw new AccountNotFoundException(MessageConstant.ACCOUNT_NOT_FOUND);
        }

        //密码比对
        // 对前端传来的密码进行md5加密
        password = DigestUtils.md5DigestAsHex(password.getBytes());

        if (!password.equals(employee.getPassword())) {
            //密码错误
            throw new PasswordErrorException(MessageConstant.PASSWORD_ERROR);
        }

        if (employee.getStatus() == StatusConstant.DISABLE) {
            //账号被锁�?
            throw new AccountLockedException(MessageConstant.ACCOUNT_LOCKED);
        }

        //3、返回实体对�?
        return employee;
    }

    /**
     * 新增员工
     * @param employeeDTO
     */
    @Override
    public void addEmployee(EmployeeDTO employeeDTO) {
        Employee employee = new Employee();

        //对象属性拷�?
        BeanUtils.copyProperties(employeeDTO,employee);

        //设置账号状�?
        employee.setStatus(StatusConstant.ENABLE);//启用

        //设置默认密码
        employee.setPassword(DigestUtils.md5DigestAsHex(PasswordConstant.DEFAULT_PASSWORD.getBytes()));

        //设置当前创建时间
       // employee.setCreateTime(LocalDateTime.now());
        //employee.setUpdateTime(LocalDateTime.now());

        //设置当前记录创建人id
        //调用ThreadLocal获取当前登录用户id
       // employee.setCreateUser(BaseContext.getCurrentId());
        //employee.setUpdateUser(BaseContext.getCurrentId());

        //新增员工
        employeeMapper.insert(employee);
    }

    /**
     * 分页查询
     * @param employeePageQueryDTO
     * @return
     */
    @Override
    public PageResult pageQuery(EmployeePageQueryDTO employeePageQueryDTO) {
       // 开始分页查�?
        PageHelper.startPage(employeePageQueryDTO.getPage(),employeePageQueryDTO.getPageSize());
        // 执行分页查询
        Page<Employee> page = employeeMapper.pageQuery(employeePageQueryDTO);
        // 封装PageResult并返�?
        return new PageResult(page.getTotal(),page.getResult());
    }

    /**
     * 启用禁用员工账号
     * @param status
     * @param id
     */
    @Override
    public void startOrStop(Integer status, Long id) {
        Employee employee = Employee.builder()
                        .status( status)
                        .id(id)
                        //.updateTime(LocalDateTime.now())
                       // .updateUser(BaseContext.getCurrentId())
                        .build();


        employeeMapper.update(employee);
    }

    /**
     * 根据id查询员工信息
     * @return
     */
    @Override
    public Employee getById(Long id) {
        Employee employee = employeeMapper.getById(id);
        //在实体类添加了@JsonIgnore注解，在返回前端时，不返回密�?保证安全�?
        // employee.setPassword("****");//密码也会返回到前端，因此需要将密码设置�?***
        return employee;
    }

    /**
     * 员工更新
     * @param employeeDTO
     */
    @Override
    public void update( EmployeeDTO employeeDTO) {
        Employee employee = new Employee();
        BeanUtils.copyProperties(employeeDTO, employee);

       // employee.setUpdateTime(LocalDateTime.now());
        //employee.setUpdateUser(BaseContext.getCurrentId());

        employeeMapper.update(employee);

    }


}
