package com.qingtao.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.qingtao.pojo.Design;
import com.qingtao.pojo.SDesign;
import com.qingtao.pojo.User;
import com.qingtao.serviceI.DesignServiceI;
import com.qingtao.serviceI.UserServiceI;

@Controller
@RequestMapping("/design")
public class DesignController {

	@Autowired
	private DesignServiceI designService;

	@Autowired
	private UserServiceI userService;

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

	/**
	 * 学生选择课题
	 * 
	 * @param title
	 * @param studentid
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/select", method = RequestMethod.POST)
	public String select(@RequestParam("title") String title, @RequestParam("studentid") Long studentid,@RequestParam("tname") String tname) {
		SDesign sdesign = new SDesign();
		sdesign.setTitle(title);
		sdesign.setStudentid(studentid);
		sdesign.setTname(tname);
		Map<String, String> map = new HashMap<>();
		map.put("title", title);
		map.put("counter", "-1");

		SDesign sd = designService.selectOne(studentid);

		/**
		 * 选课,不存在时当前课题减一 存在时,当前课题加一
		 */
		if (sd == null) {
			designService.insertSDesign(sdesign);
		} else {
			designService.updateFile(sdesign);
			designService.updateCounter(map);
			map.put("title", sd.getTitle());
			map.put("counter", "+1");
		}

		designService.updateCounter(map);
		
		User u = new User(null, studentid);
		u.setTname(tname);
		userService.updateSelective(u);
		return "#upload";
	}

	/**
	 * 课程设计文件上传
	 * 
	 * @param file
	 * @param studentid
	 * @param session
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/updatefile", method = RequestMethod.POST)
	public String updateFile(MultipartFile file, Long studentid, HttpSession session) throws IOException {
		String path = session.getServletContext().getRealPath("/");
		String pathname = path + "/WEB-INF/file/";
		String[] fileName = file.getOriginalFilename().split("\\.");
		String name = fileName[fileName.length - 1];
		
		String redirect = null;
		
		if(name.equals("zip")||name.equals("rar")){
			String id = String.valueOf(studentid);
			int four = Integer.parseInt(id.substring(0, 4)) + 4;
			int b = Integer.parseInt(id.substring(4, 5));
			String nc = id.substring(5, 7) + id.substring(9);
			String up = "信息工程";
			if (b == 3) {
				up = "电子信息工程";
			}
			name = four + nc + "_" + up + "_" + userService.selectOneUser(new User(null, studentid)).getPromiss() + "."
					+ name;
			redirect = "redirect:/auth/iframe/three.jsp";
		} else if(name.equals("xls")){
			User user = new User(null, studentid);
			user.setTeacher("upload");
			userService.updateSelective(user);
			
			designService.insertSDesign((new SDesign(studentid, "true")));
			name = studentid + "_" + userService.selectOneUser(new User(null, studentid)).getPromiss() + "." + name;
			redirect = "redirect:/auth/iframe/t-three.jsp";
		}
		

		designService.updateFile(new SDesign(name, studentid, pathname + name, "true"));

		File dir = new File(pathname, name);
		if (!dir.exists()) {
			dir.mkdirs();
		}
		file.transferTo(dir);

		return redirect;
	}

	/**
	 * 文件下载
	 * 
	 * @param session
	 * @param fileName
	 *            文件名称
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/download/{studentid}", method = RequestMethod.GET)
	public ResponseEntity<byte[]> fileDownload(@PathVariable("studentid") Long studentid) throws IOException {

		// 得到工程真实路径
		SDesign realFile = designService.selectOne(studentid);
		String path = realFile.getFile();
		String name = realFile.getFilename();

		File file = new File(path);

		HttpHeaders headers = new HttpHeaders();
		headers.setContentDispositionFormData("attachment", new String(name.getBytes("UTF-8"), "iso-8859-1"));
		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
		return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file), headers, HttpStatus.CREATED);
	}
	
	

	/**
	 * 查询已选课程
	 * 
	 * @param studentid
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/selectOne/{studentid}", method = RequestMethod.GET)
	public Map<String, Object> selectOne(@PathVariable("studentid") Long studentid) {
		SDesign flag = designService.selectOne(studentid);
		if (flag == null) {
			return null;
		} else {
			String title = flag.getTitle();
			String agree = flag.getAgree();
			String ctitle = flag.getCtitle();

			Map<String, String> map = new HashMap<>();
			map.put("title", title);

			Design design = designService.selectAll(map).get(0);
			design.setTname(agree);
			
			Map<String, Object> resultMap = new HashMap<>();
			resultMap.put("obj", design);
			resultMap.put("ctitle", ctitle);
			
			return resultMap;
		}
	}

	/**
	 * 删除课题
	 * 
	 * @param title
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@ResponseBody
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String delete(@RequestParam("title") String title) throws UnsupportedEncodingException {
		title = new String(title.getBytes("ISO-8859-1"), "UTF-8");
		designService.delete(title);
		return "delete";
	}

	/**
	 * 修改课题
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/ctitle", method = RequestMethod.POST)
	public String updateTitle(@RequestParam("studentid") Long studentid, @RequestParam("ctitle") String ctitle) {
		SDesign sd = new SDesign();
		sd.setStudentid(studentid);
		sd.setCtitle(ctitle);
		sd.setAgree("false");
		designService.updateFile(sd);
		return "ctitle";
	}
}
