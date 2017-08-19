package com.breaking.crud.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.breaking.crud.bean.Department;
import com.breaking.crud.dao.DepartmentMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"classpath:applicationContext.xml"})
public class MapperTest {

	@Autowired
	DepartmentMapper departmentMapper;
	
	@Test
	public void testCRUD() {
		System.out.println(departmentMapper);
		
		departmentMapper.insertSelective(new Department(null, "研发部"));
		departmentMapper.insertSelective(new Department(null, "测试部"));
		
	}

}
