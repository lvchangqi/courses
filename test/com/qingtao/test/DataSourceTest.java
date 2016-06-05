package com.qingtao.test;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.qingtao.dao.DesignMapper;
import com.qingtao.dao.ExcelMapper;
import com.qingtao.dao.ImgMapper;
import com.qingtao.dao.NoticeMapper;
import com.qingtao.dao.SDesignMapper;
import com.qingtao.dao.UserMapper;
import com.qingtao.pojo.Design;
import com.qingtao.pojo.Excel;
import com.qingtao.pojo.User;
import com.qingtao.serviceI.DesignServiceI;
import com.qingtao.serviceI.ImgServiceI;
import com.qingtao.serviceI.UserServiceI;
import com.qingtao.util.Mail;
import com.qingtao.util.MailContent;

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
		ExcelMapper em = act.getBean(ExcelMapper.class);
		System.out.println(em.excel(em.excelsup(17061l)));
	}

	@Test
	public void MD5Test() throws IOException {
		Long workid = 123123124l;
		String name ="严焰";
		File file = new File("E:\\" + workid + "_" + name + ".xls");
		if(!file.exists()){
			HSSFWorkbook workbook = new HSSFWorkbook();
			workbook.createSheet();
			workbook.write(new FileOutputStream(file));
		}
	}

	@Test
	public void designTest() {
		UserServiceI us = act.getBean(UserServiceI.class);
		Map<String ,String> m = new HashMap<>();
		m.put("role", "student");
		System.out.println(us.selectAll(m));
	}

	@Test
	public void seTest() throws JsonProcessingException {
		ObjectMapper om = new ObjectMapper();
		ImgMapper im = act.getBean(ImgMapper.class);
		System.out.println(om.writeValueAsString(im.selectRole("teacher")));
	}

	@Test
	public void mailTest() throws Exception {
		Mail mail = new Mail("找回密码", MailContent.getContent((int) (Math.random() * 1000) + ""), 675812074 + "@qq.com");
		Thread thread = new Thread(mail);
		thread.start();
	}

	@Test
	public void download() {
		SDesignMapper sd = act.getBean(SDesignMapper.class);
		System.out.println(sd.selectOne(new Long(2014116020312l)));
	}

	@Test
	public void Test() {
		ExcelMapper excelMapper = act.getBean(ExcelMapper.class);
		List<Excel> list = excelMapper.excel(excelMapper.excelsup(17061l));
		System.out.println(list);
	}

	@Test
	public void pagehelperTest() {
		UserMapper um = act.getBean(UserMapper.class);
		PageHelper.startPage(1, 2, true);
	}

	@Test
	public void JsonTest() throws IOException {
		ObjectMapper om = new ObjectMapper();
		User user = new User();
		user.setUsername("dsadas");
		user.setPassword("dsaaaaaaaaaaaaaaaaaaaaa");
		user.setStudentid(2131231231312l);
		user.setQq(21312312312312l);
		user.setPhone(1231231231231l);
		user.setPromiss("超级管理员");
		user.setRole("管理员");
		Map<String ,Object> m = new HashMap<>();
		m.put("obj", user);
		m.put("ctitle", "哈哈哈");
		System.out.println(om.writeValueAsString(m));
	}
}
