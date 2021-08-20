package com.demo.crud.controller;

import com.demo.crud.bean.Employee;
import com.demo.crud.bean.Msg;
import com.demo.crud.service.EmployService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EmployeeController {
    @Autowired
    private EmployService employService;

    /**
     * 员工更新
     * @param employee
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    public Msg saveEmp(Employee employee){
        employService.updateEmp(employee);
        return Msg.success();
    }

    /**
     * 查询员工
     * @param id
     * @return
     */
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable Integer id){
       Employee emp =  employService.getEmp(id);
        return Msg.success().add("emp",emp);
    }
    /**
     * 员工保存信息
     * @return
     */
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        Map<String ,Object> map = new HashMap<>();
        if(result.hasErrors()){
            List<FieldError> fieldErrors = result.getFieldErrors();
            for (FieldError error: fieldErrors){
                map.put(error.getField(),error.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        }else {
            employService.saveEmp(employee);
            return Msg.success();
        }
    }
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpWithJson(@RequestParam(value = "pn",defaultValue = "1")Integer pn, Model model){
        PageHelper.startPage(pn,5);
        //紧跟的查询就是分页
        List<Employee> emps = employService.getAll();
        PageInfo page = new PageInfo(emps,5);
        return Msg.success().add("pageInfo",page);
    }
    //@RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn",defaultValue = "1")Integer pn, Model model){
        //在查询之前调用pageHelper分页,传入页码和大小
        PageHelper.startPage(pn,5);
        //紧跟的查询就是分页
        List<Employee> emps = employService.getAll();
        PageInfo page = new PageInfo(emps,5);
        //使用pageInfo包装集合,查询结果
        model.addAttribute("pageInfo",page);
        return "list";
    }

    /**
     * 检查用户是否可用
     * @param empName
     * @return
     */
    @ResponseBody
    @RequestMapping("/checkUser")
    public Msg checkUser(@RequestParam("empName") String empName){
        String regx="(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u4e00-\\u9fa5]{2,5})";
        if(!empName.matches(regx)){
            return Msg.fail().add("va_msg","用户名必须是6-16位数字和字母组合");
        }
        boolean b = employService.checkUser(empName);
        if(b){
            return Msg.success();
        }else {
            return Msg.fail().add("va_msg","用户名不可用");
        }
    }
    @RequestMapping(value = "/emp/{ids}" ,method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteEmpByI(@PathVariable String ids){
        List <Integer> list = new ArrayList<>();
        if(ids.contains("-")){
            String[] str = ids.split("-");
            for(String string:str){
                list.add(Integer.parseInt(string));
            }
            employService.deleteBatch(list);
        }else {
            employService.delEmpById(Integer.parseInt(ids));
        }

        return  Msg.success();
    }
}
