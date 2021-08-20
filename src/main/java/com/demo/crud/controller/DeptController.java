package com.demo.crud.controller;

import com.demo.crud.bean.Department;
import com.demo.crud.bean.Msg;
import com.demo.crud.service.DepartmentService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class DeptController {
    @Autowired
    private DepartmentService deptService;
    @ResponseBody
    @RequestMapping("/depts")
    public Msg getDepts(){
        List<Department> allDept = deptService.getAllDept();
        return Msg.success().add("depts",allDept);
    }
}
