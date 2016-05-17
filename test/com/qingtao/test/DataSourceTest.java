package com.qingtao.test;

import org.apache.shiro.crypto.hash.Md5Hash;
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
		User user = new User();
		user.setStudentid(2014116020312l);
		user.setPromiss("true");
		userServiceI.updateSelective(user);
		
	}
	
	@Test
	public void MD5Test(){
		System.out.println("0a1ae6ac331001d701026132c2bcf790".length());
	}

}
