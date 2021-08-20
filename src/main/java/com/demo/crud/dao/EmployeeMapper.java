package com.demo.crud.dao;

import com.demo.crud.bean.Employee;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
public interface EmployeeMapper {
    int deleteByPrimaryKey(Integer empId);

    int insert(Employee record);

    Employee selectByPrimaryKey(Integer empId);

    List<Employee> selectAll();

    int updateByPrimaryKey(Employee record);
    int updateByPrimaryKeyWithSelect(Employee record);

    Employee selectByPrimaryKeyWithDept(Integer empId);

    List<Employee> selectAllWithDept();

    List<Employee> selectName( String empName);

    void deleteBatch(List<Integer> ids);
}