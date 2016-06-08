package com.qingtao.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.qingtao.dao.ExcelMapper;
import com.qingtao.dao.NoticeMapper;
import com.qingtao.pojo.Excel;
import com.qingtao.pojo.SDesign;
import com.qingtao.pojo.User;
import com.qingtao.serviceI.DesignServiceI;
import com.qingtao.serviceI.UserServiceI;
import com.qingtao.util.ExcelExport;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private DesignServiceI designService;

	@Autowired
	private ExcelMapper excelMapper;

	@Autowired
	private NoticeMapper noticeMapper;

	@Autowired
	private UserServiceI userService;

	/**
	 * 发布公告
	 * 
	 * @param notice
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/notice", method = RequestMethod.POST)
	public Object notice(@RequestParam(value = "notice", required = false) String notice,
			@RequestParam(value = "name") String name) {
		if (notice != null) {
			Map<String ,String> map = new HashMap<>();
			map.put("name", name);
			map.put("content", notice);
			noticeMapper.insert(map);
			return "notice";
		} else {
			return noticeMapper.select(name);
		}
	}

	/**
	 * 删除用户
	 * 
	 * @param people
	 * @return
	 * @throws JsonParseException
	 * @throws JsonMappingException
	 * @throws IOException
	 */
	@ResponseBody
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String deleteUser(@RequestParam("people") String people)
			throws JsonParseException, JsonMappingException, IOException {
		ObjectMapper om = new ObjectMapper();
		String[] peoples = om.readValue(people, String[].class);
		userService.delete(peoples);
		return "delete";
	}

	/**
	 * admin修改指导老师
	 * 
	 * @param tname
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/changeT", method = RequestMethod.POST)
	public String changeT(@RequestParam("tname") String tname, @RequestParam("studentid") Long studentid) {
		User u = new User(null, studentid);
		u.setTname(tname);
		userService.updateSelective(u);
		SDesign s = new SDesign(studentid, null);
		s.setTname(tname);
		designService.updateFile(s);

		return "change";
	}

	/**
	 * 到出excel表
	 * 
	 * @param workid
	 * @param session
	 * @throws Exception
	 */
	@RequestMapping(value = "/export/{workid}", method = RequestMethod.GET)
	public void exportExcel(@PathVariable("workid") Long workid, HttpSession session) throws Exception {
		String name = excelMapper.excelsup(workid);
		List<Excel> list = excelMapper.excel(name);
		Iterator<Excel> it = list.iterator();
		while (it.hasNext()) {
			Excel e = it.next();
			e.setWorkid(workid);
			e.setCredit(4);
			e.setScore("");
			String id = String.valueOf(e.getStudentid());
			// 2014116020312
			if (Integer.parseInt(id.substring(4, 5)) == 3) {
				e.setCollege("文理学院");
				e.setMajor("电子信息工程");
			} else if (Integer.parseInt(id.substring(4, 5)) == 1) {
				e.setCollege("教育信息与技术学院");
				e.setMajor("信息工程");
			}
			e.setClasses(Integer.parseInt(id.substring(2, 4) + id.substring(9, 11)));
		}
		File file = new File("C:\\" + workid + "_" + name + ".xls");
		if (!file.exists()) {
			HSSFWorkbook workbook = new HSSFWorkbook();
			workbook.createSheet("Sheet1");
			OutputStream out = new FileOutputStream(file);
			workbook.write(out);
			out.close();
			workbook.close();
		}
		new ExcelExport().excel(list, file, session);
	}
}
