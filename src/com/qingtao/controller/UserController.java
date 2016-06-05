package com.qingtao.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

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
import org.springframework.web.multipart.MultipartFile;

import com.qingtao.pojo.Img;
import com.qingtao.pojo.User;
import com.qingtao.serviceI.ImgServiceI;
import com.qingtao.serviceI.UserServiceI;
import com.qingtao.util.Mail;
import com.qingtao.util.MailContent;

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

	@Autowired
	private ImgServiceI imgService;

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
	 * 找回密码
	 * 
	 * @param studentid
	 * @param inputpwd
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/found", method = RequestMethod.GET)
	public String found(@RequestParam(value = "studentid", required = false) Long studentid,
			@RequestParam(value = "inputpwd", required = false) String inputpwd) {
		User user = new User(null, studentid);
		user.setPassword(new Md5Hash(inputpwd, SALT).toString());
		userService.updateSelective(user);
		return "success";
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

	/**
	 * 修改用户信息
	 * 
	 * @param user
	 * @param map
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(User user, ModelMap map) {
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
						user.setRole("同学");
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
	 * 查询资源,头像
	 * 
	 * @param username
	 * @param role
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/res", method = RequestMethod.GET)
	public Object resouce(@RequestParam(value = "username", required = false) String username,
			@RequestParam(value = "role", required = false) String role) {

		if (username != null) {
			return imgService.select(username);
		}
		if (role != null) {
			return imgService.selectRole(role);
		}

		return "error";
	}

	/**
	 * 头像上传
	 * 
	 * @throws IOException
	 * @throws IllegalStateException
	 */
	@RequestMapping(value = "/imgUp", method = RequestMethod.POST)
	public String imgUpload(MultipartFile img, String imgName, String username, HttpServletRequest request)
			throws IllegalStateException, IOException {
		String path = request.getServletContext().getRealPath("/");

		String netPath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
				+ request.getContextPath() + "/images/";
		String storePath = path + "/images/";

		String fileType = img.getOriginalFilename().split("\\.")[1];
		// 用户名.类型
		String fileName = username + '.' + fileType;

		// 文件信息存入数据库
		if (imgService.select(username) != null) {
			imgService.update(new Img(username, netPath + fileName));
		} else {
			imgService.insert(new Img(username, netPath + fileName));
		}

		// 文件永久化
		File dir = new File(storePath, fileName);
		img.transferTo(dir);

		return "redirect:/auth/control.jsp";
	}

	/**
	 * admin查询所有用户
	 * 
	 * @param role
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/selectAll", method = RequestMethod.GET)
	public List<User> selectAll(@RequestParam("role") String role) {
		Map<String, String> map = new HashMap<>();
		map.put("role", role);

		return userService.selectAll(map);
	}


	/**
	 * 查询选择课题用户并返回
	 * 
	 * @param title
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@ResponseBody
	@RequestMapping(value = "/title", method = RequestMethod.POST)
	public List<Map<String, String>> selectByTitle(@RequestParam("tname") String tname)
			throws UnsupportedEncodingException {
		List<Map<String ,String>> list = userService.selectByTitle(tname);
		String major = "信息工程";
		String college = "教育信息与技术学院";
		List<Map<String ,String>> resultList = new ArrayList<>();
		
		Iterator<Map<String ,String>> it = list.iterator();
		while(it.hasNext()){
			Map<String, String> map = it.next();
			String id = String.valueOf(map.get("studentid"));
			int classes = Integer.parseInt(id.substring(2, 4) + id.substring(9, 11));
			if (Integer.parseInt(id.substring(4, 5)) == 3) {
				major = "电子信息工程";
				college = "文理学院";
			}
			map.put("major", major);
			map.put("classes",String.valueOf(classes));
			map.put("college", college);
			resultList.add(map);
		}
		
		return resultList;
	}

	/**
	 * 发送邮件
	 * 
	 * @param username
	 * @param studentid
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/mail", method = RequestMethod.GET)
	public String forMail(@RequestParam("name") String username, @RequestParam("studentid") long studentid)
			throws Exception {
		User user = new User(username, studentid);
		User cuser = userService.selectOneUser(user);
		if (cuser == null) {
			return "unmatch";
		}
		char[] ch = "abcdefghjkmnpqrstuvwxyz23456789".toCharArray(); // 随即产生的字符串
		int length = ch.length; // 随即字符串的长度
		String sRand = ""; // 保存随即产生的字符串
		Random random = new Random();
		for (int i = 0; i < 6; i++) {
			String rand = new Character(ch[random.nextInt(length)]).toString();
			sRand += rand;
		}
		Mail mail = new Mail("找回密码", MailContent.getContent(sRand), cuser.getQq() + "@qq.com");
		new Thread(mail).start();

		return sRand;
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
