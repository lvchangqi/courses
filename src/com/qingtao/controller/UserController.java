package com.qingtao.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qingtao.pojo.User;
import com.qingtao.serviceI.UserServiceI;

/**
 * @since 2016/5/10
 * @version 1.0
 * @author 吕长奇
 *
 */
@Controller
@RequestMapping("/user")
public class UserController {
	
	
//	private final String DEFAULT_PROMIESS = "true";
	
	@Autowired
	private UserServiceI userService;
	/**
	 * 用户输入检测
	 * @param username
	 * @param studentid
	 * @return
	 */

	@ResponseBody
	@RequestMapping(value = "/checkUser", method = RequestMethod.POST)
	public boolean checkUser(@RequestParam(value = "username", required = false) String username,
			@RequestParam(value = "studentid", required = false) Long studentid) {
		User user = new User(username,studentid);
		//学号存在时查询学号
		if(studentid != null){
			user.setUsername(null);
		}
		User resultUser = userService.selectOneUser(user);
		boolean flag = false;
		if(resultUser == null){
			flag = true;
		}
		return flag;
	}

	/**
	 * 
	 * @param user
	 */
	@RequestMapping(value = "/submit", method = RequestMethod.POST)
	public String submit(User user) {
		System.out.println(user);
		return "WEB-INF/goto";
	}
}
