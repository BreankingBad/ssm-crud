package com.breaking.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.breaking.crud.bean.Employee;
import com.breaking.crud.bean.EmployeeExample;
import com.breaking.crud.bean.EmployeeExample.Criteria;
import com.breaking.crud.dao.EmployeeMapper;

import net.sf.jsqlparser.statement.create.index.CreateIndex;

@Service
public class EmployeeService {

	@Autowired
	EmployeeMapper employeeMapper;
	
	public List<Employee> getAll() {
		
		return employeeMapper.selectByExampleWithDept(null);
	}
	
	public void saveEmployee(Employee employee) {
		employeeMapper.insertSelective(employee);
	}

	/**
	 * 用户名是否可用
	 * @param empName 员工名
	 * @return
	 */
	public boolean isEmpAvailable(String empName) {
		EmployeeExample employeeExample = new EmployeeExample();
		Criteria criteria = employeeExample.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		long count = employeeMapper.countByExample(employeeExample);
		return count == 0;
	}

}
