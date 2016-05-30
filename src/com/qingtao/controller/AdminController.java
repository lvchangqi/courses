package com.qingtao.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.qingtao.dao.NoticeMapper;
import com.qingtao.serviceI.UserServiceI;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private NoticeMapper noticeMapper;
	
	@Autowired
	private UserServiceI userService;
	
	/**
	 * 发布公告
	 * @param notice
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/notice", method=RequestMethod.POST)
	public Object notice(@RequestParam(value="notice",required=false) String notice){
		if(notice != null){
			noticeMapper.insert(notice);
			return "notice";
		} else {
			return noticeMapper.select();
		}
	}
	
	/**
	 * 删除用户
	 * @param people
	 * @return
	 * @throws JsonParseException
	 * @throws JsonMappingException
	 * @throws IOException
	 */
	@ResponseBody
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String deleteUser(@RequestParam("people") String people) throws JsonParseException, JsonMappingException, IOException {
		ObjectMapper om = new ObjectMapper();
		String[] peoples = om.readValue(people, String[].class);
		userService.delete(peoples);
		return "delete";
	}
}
