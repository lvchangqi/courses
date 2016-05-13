package com.qingtao.test;

import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.qingtao.pojo.User;
import com.qingtao.serviceI.UserServiceI;

@SuppressWarnings("all")
public class DataSourceTest {

	private ApplicationContext act;

	@Before
	public void getContext() {
		act = new ClassPathXmlApplicationContext("classpath:config/spring-mvc.xml",
				"classpath:config/spring-mybatis.xml");
	}

	@Test
	public void test() {
		UserServiceI userServiceI = act.getBean(UserServiceI.class);
		System.out.println(userServiceI.selectOneUser(new User()));
	}

}
