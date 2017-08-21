package com.breaking.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.breaking.crud.bean.Department;
import com.breaking.crud.bean.ResponseBean;
import com.breaking.crud.service.DepartmentService;

@Controller
public class DepartmentController {

	@Autowired
	DepartmentService departmentService; 
	
	@RequestMapping("/depts")
	@ResponseBody
	public ResponseBean getDepts() {
		List<Department> list = departmentService.getAll();
		return ResponseBean.success().setData("depts", list);
	}
}
