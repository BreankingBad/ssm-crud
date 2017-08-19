package com.breaking.crud.test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MockMvcBuilder;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.breaking.crud.bean.Employee;
import com.github.pagehelper.PageInfo;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations= {"classpath:applicationContext.xml","classpath:springmvc-servlet.xml"})
public class MvcTest {

	@Autowired
	WebApplicationContext webApplicationContext;
	
	MockMvc mockMvc;
	
	@Before
	public void initMockMvc() {
		mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
	
	}
	
	@Test
	public void testPage() throws Exception {
		
		MvcResult mvcResult = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("page", "1")).andReturn();
		
		MockHttpServletRequest request = mvcResult.getRequest();
		PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
		
		System.out.println("当前页码 :"+pageInfo.getPageNum());
		System.out.println("总页码 :"+pageInfo.getPages());
		System.out.println("总记录数 :"+pageInfo.getTotal());
		
		int[] pages = pageInfo.getNavigatepageNums();
		for (int i = 0; i < pages.length; i++) {
			System.out.println("显示的页码： "+pages[i]);
		}
		List<Employee> list = pageInfo.getList();
		for (Employee employee : list) {
			System.out.println(employee.toString());
		}
		
	}
	
	
}
