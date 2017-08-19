package com.breaking.crud.test;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.forwardedUrl;

import java.util.Random;
import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.breaking.crud.bean.Department;
import com.breaking.crud.bean.Employee;
import com.breaking.crud.dao.DepartmentMapper;
import com.breaking.crud.dao.EmployeeMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"classpath:applicationContext.xml"})
public class MapperTest {

	@Autowired
	DepartmentMapper departmentMapper;
	
	@Autowired
	EmployeeMapper employeeMapper;
	
	@Autowired
	SqlSession sqlSession;
	
	@Test
	public void testCRUD() {
		System.out.println(departmentMapper);
		
	/*	departmentMapper.insertSelective(new Department(null, "研发部"));
		departmentMapper.insertSelective(new Department(null, "测试部"));
		*/
		
		EmployeeMapper employeeMapper = sqlSession.getMapper(EmployeeMapper.class);
		for (int i = 0; i < 1000; i++) {
			String empName = i +UUID.randomUUID().toString().substring(0,6);
			employeeMapper.insertSelective(new Employee(null, empName, "M", empName+"breaking@163.com", 25));
		}
		
	}

}
