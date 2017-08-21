package com.breaking.crud.service;

import static org.hamcrest.CoreMatchers.nullValue;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.breaking.crud.bean.Department;
import com.breaking.crud.dao.DepartmentMapper;

@Service
public class DepartmentService {

	@Autowired
	DepartmentMapper departmentMapper;
	
	public List<Department> getAll() {
		// TODO Auto-generated method stub
		return departmentMapper.selectByExample(null);
	}

}
