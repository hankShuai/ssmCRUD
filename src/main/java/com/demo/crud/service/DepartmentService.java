package com.demo.crud.service;

import com.demo.crud.bean.Department;
import com.demo.crud.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentService {
    @Autowired
    private DepartmentMapper departmentMapper;
    public List<Department> getAllDept(){
        return departmentMapper.selectAll();
    }
}
