package com.qingtao.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qingtao.dao.NoticeMapper;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private NoticeMapper noticeMapper;
	
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
}
