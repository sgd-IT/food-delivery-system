package com.fooddelivery.mapper;

import com.github.pagehelper.Page;
import com.fooddelivery.annotation.AutoFill;
import com.fooddelivery.dto.EmployeePageQueryDTO;
import com.fooddelivery.entity.Employee;
import com.fooddelivery.enumeration.OperationType;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.Map;

@Mapper
public interface EmployeeMapper {

    /**
     * 根据用户名查询员�?
     * @param username
     * @return
     */
    @Select("select * from employee where username = #{username}")
    Employee getByUsername(String username);

    /**
     * 插入员工数据
     * @param employee
     */
    @Insert("insert into employee (username, name, password, phone, sex, id_number, status, create_time, update_time, create_user, update_user) " +
            "values (#{username}, #{name}, #{password}, #{phone}, #{sex}, #{idNumber}, #{status}, #{createTime}, #{updateTime}, #{createUser}, #{updateUser})")
    @AutoFill(value = OperationType.INSERT)
    void insert(Employee employee);

    /**
     * 分页查询
     * @param employeePageQueryDTO
     * @return
     */
    Page<Employee> pageQuery(EmployeePageQueryDTO employeePageQueryDTO);

    Employee getById(Long id);

    @AutoFill(value = OperationType.UPDATE)
    void update(Employee employee);



}
