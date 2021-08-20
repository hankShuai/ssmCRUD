package com.demo.crud.service;

import com.demo.crud.bean.Employee;
import com.demo.crud.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
@Service
public class EmployService {
    @Autowired
    EmployeeMapper employeeMapper;

    /**
     * 查询所有员工
     * @return
     */
    public List<Employee> getAll() {
        return employeeMapper.selectAllWithDept();
    }

    public void saveEmp(Employee employee) {
        employeeMapper.insert(employee);
    }

    public boolean checkUser(String empName) {
        List <Employee> list;
        list = employeeMapper.selectName(empName);
        return list.isEmpty();
    }

    public Employee getEmp(Integer id) {
        return employeeMapper.selectByPrimaryKey(id);
    }

    public void updateEmp(Employee employee) {
        employeeMapper.updateByPrimaryKeyWithSelect(employee);
    }

    public void delEmpById(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    public void deleteBatch(List<Integer> ids) {
        employeeMapper.deleteBatch(ids);
    }
}
