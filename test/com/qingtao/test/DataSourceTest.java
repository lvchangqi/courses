package com.qingtao.test;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.shiro.crypto.hash.Md5Hash;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.qingtao.dao.ImgMapper;
import com.qingtao.pojo.Design;
import com.qingtao.pojo.User;
import com.qingtao.serviceI.DesignServiceI;
import com.qingtao.serviceI.UserServiceI;
import com.qingtao.util.Mail;

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
		UserServiceI userService = act.getBean(UserServiceI.class);
		User user = new User();
		System.out.println(userService.selectOneUser(new User(null, new Long(2014116020312l))));
		
	}
	
	@Test
	public void MD5Test(){
		System.out.println("0a1ae6ac331001d701026132c2bcf790".length());
	}
	
	@Test
	public void designTest(){
		DesignServiceI ds = act.getBean(DesignServiceI.class);
		Map<String, String> map = new HashMap<>();
		map.put("tname", "王老师");
		System.out.println(ds.selectAll(map));
	}
	
	@Test
	public void seTest() throws JsonProcessingException{
		ObjectMapper om =new ObjectMapper();
		ImgMapper im = act.getBean(ImgMapper.class);
		System.out.println(om.writeValueAsString(im.selectRole("teacher")));
	}
	
	@Test
	public void mailTest() throws Exception{
		new Mail("xxx", "xxxx", "675812074@qq.com").sendMail();;
	}

}
