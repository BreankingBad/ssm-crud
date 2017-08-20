package com.breaking.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
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
