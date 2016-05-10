package com.qingtao.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.qingtao.pojo.User;

/**
 * @since 2016/5/10
 * @version 1.0
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/user")
public class UserController {
	
	@RequestMapping(value="/submit",method=RequestMethod.POST)
	public void submit(User user){
		System.out.println(user);
	}
}
