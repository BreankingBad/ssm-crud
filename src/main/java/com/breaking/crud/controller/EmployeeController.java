package com.breaking.crud.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.forwardedUrl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.breaking.crud.bean.Employee;
import com.breaking.crud.bean.ResponseBean;
import com.breaking.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
public class EmployeeController {
	
	@Autowired
	EmployeeService employeeService;
	
	@RequestMapping("/emps")
	@ResponseBody
	public ResponseBean getEmps(@RequestParam(value="page",defaultValue="1")Integer page,
			Model model) {
		// 开始的页码，和每页的大小
		PageHelper.startPage(page, 5);
		List<Employee> list = employeeService.getAll();
		
		PageInfo pageInfo = new PageInfo(list,5);
		return ResponseBean.success().setData("pageInfo", pageInfo);
	}
	
	@RequestMapping(value="/emp",method=RequestMethod.POST)
	@ResponseBody
	public ResponseBean getEmps(@Valid Employee employee,BindingResult result) {
		if(result.hasErrors()) {
			Map<String, String> errorMap = new HashMap<>();
			List<FieldError> fieldErrors = result.getFieldErrors();
			for (FieldError fieldError : fieldErrors) {
				errorMap.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return ResponseBean.fail().setData("error_msg", errorMap);
		}else {
			employeeService.saveEmployee(employee);
			return ResponseBean.success();
		}
	}
	
	@RequestMapping(value="/checkEmp",method=RequestMethod.POST)
	@ResponseBody
	public ResponseBean checkEmpAvailable(@RequestParam("empName")String empName) {
		String nameReg = "(^[a-z0-9_-]{3,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
		if(!empName.matches(nameReg)) {
			return ResponseBean.fail().setMsg("用户名正则不匹配！");
		}
		
		boolean available = employeeService.isEmpAvailable(empName);
		if(available) {
			return ResponseBean.success();
		}else {
			return ResponseBean.fail().setMsg("用户名已存在！");
		}
	}
/*	@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="page",defaultValue="1")Integer page,
			Model model) {
		// 开始的页码，和每页的大小
		PageHelper.startPage(page, 5);
		List<Employee> list = employeeService.getAll();
		
		PageInfo pageInfo = new PageInfo(list,5);
		model.addAttribute("pageInfo", pageInfo);
		
		return "list";
	}*/
}
