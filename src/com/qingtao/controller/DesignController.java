package com.qingtao.controller;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qingtao.pojo.Design;
import com.qingtao.serviceI.DesignServiceI;

@Controller
@RequestMapping("/design")
public class DesignController {

	@Autowired
	private DesignServiceI designService;

	/**
	 * 创建课题
	 * 
	 * @param design
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/create", method = RequestMethod.POST)
	public String create(Design design) {
		designService.insertSelective(design);
		return "ok";
	}

	/**
	 * 查询课题
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/getAll", method = RequestMethod.POST)
	public Collection<Design> getAll(@RequestParam("tname") String tname) {
		Map<String, String> smap = new HashMap<>();
		smap.put("tname", tname);
		return designService.selectAll(smap);
	}
}
