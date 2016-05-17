package com.qingtao.controller;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

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
@SessionAttributes(types = { User.class })
public class UserController {

	private final String SALT = "andios";

	// private final String DEFAULT_PROMIESS = "true";

	@Autowired
	private UserServiceI userService;

	/**
	 * 用户输入检测
	 * 
	 * @param username
	 * @param studentid
	 * @return
	 */

	@ResponseBody
	@RequestMapping(value = "/checkUser", method = RequestMethod.POST)
	public boolean checkUser(@RequestParam(value = "username", required = false) String username,
			@RequestParam(value = "studentid", required = false) Long studentid) {
		User user = new User(username, studentid);
		// 学号存在时查询学号
		if (studentid != null) {
			user.setUsername(null);
		}
		User resultUser = userService.selectOneUser(user);
		boolean flag = false;
		if (resultUser == null) {
			flag = true;
		}
		return flag;
	}

	/**
	 * 用户注册
	 * 
	 * @param user
	 */
	@RequestMapping(value = "/submit", method = RequestMethod.POST)
	public String submit(User user) {
		user.setPassword(new Md5Hash(user.getPassword(), SALT).toString());
		userService.insertSelective(user);
		return "WEB-INF/goto";
	}

	/**
	 * 修改密码
	 * 
	 * @param inputpwd
	 * @param newpwd
	 * @param map
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/updatePwd", method = RequestMethod.GET)
	public String updatePwd(@RequestParam(value = "inputpwd", required = false) String inputpwd,
			@RequestParam(value = "newpwd", required = false) String newpwd, ModelMap map) {

		User user = (User) map.get("user");
		String result = null;
		String md5 = null;
		String pwd = user.getPassword();

		if (inputpwd != null) {
			md5 = new Md5Hash(inputpwd, SALT).toString();
		} else if (newpwd != null) {
			user.setPassword(new Md5Hash(newpwd, SALT).toString());
			userService.updateSelective(user);
			result = "success";
		}

		if (md5 != null && md5.equals(pwd)) {
			result = "success";
		}

		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/update",method=RequestMethod.POST)
	public String update(User user,ModelMap map){
		userService.updateSelective(user);
		map.addAttribute(user);
		return "success";
	}

	/**
	 * 登录
	 * 
	 * @param username
	 * @param password
	 * @param role
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(@RequestParam("username") String username, @RequestParam("password") String password,
			@RequestParam("role") String role, ModelMap model) {
		String resultStr = null;
		User user = userService.selectOneUser(new User(username, null));
		// 得到subject
		Subject subject = SecurityUtils.getSubject();
		// 密码加密
		password = new Md5Hash(password, SALT).toString();
		// 构造token
		UsernamePasswordToken token = new UsernamePasswordToken(username, password);
		// 验证开始
		try {
			if (user != null) {
				// 权限相同时登录token
				if (user.getRole().equals(role)) {
					subject.login(token);
					switch (user.getRole()) {
					case "student":
						user.setRole("学生");
						break;
					case "teacher":
						user.setRole("老师");
						break;
					case "admin":
						user.setRole("管理员");
						break;
					}
					model.addAttribute(user);
				} else {
					resultStr = "role";
				}
			} else {
				resultStr = "not";
			}
		} catch (IncorrectCredentialsException e) {
			e.printStackTrace();
			return "upass";
		} catch (AuthenticationException e) {
			e.printStackTrace();
			return "another wrong";
		}

		return resultStr;
	}

	/**
	 * 登出
	 * 
	 * @param map
	 *            session
	 * @return
	 */
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(ModelMap map) {
		map.clear();
		SecurityUtils.getSubject().logout();
		return "redirect:/login.jsp";
	}
}
