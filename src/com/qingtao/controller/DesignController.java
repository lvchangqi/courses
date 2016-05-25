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

	/**
	 * 学生选择课题
	 * 
	 * @param title
	 * @param studentid
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/select", method = RequestMethod.POST)
	public String select(@RequestParam("title") String title, @RequestParam("studentid") Long studentid) {
		SDesign sdesign = new SDesign();
		sdesign.setTitle(title);
		sdesign.setStudentid(studentid);
		designService.insertSDesign(sdesign);
		designService.updateCounter(title);
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
	@ResponseBody
	@RequestMapping(value="/updatefile", method=RequestMethod.POST)
	public String updateFile(MultipartFile file,Long studentid,HttpSession session) throws IOException{
		String path = session.getServletContext().getRealPath("/");
		String pathname = path + "/WEB-INF/file/";
		String fileName = file.getOriginalFilename();
		
		designService.updateFile(new SDesign(fileName, studentid, pathname+fileName));
		
		File dir = new File(pathname, fileName);
		if (!dir.exists()) {
			dir.mkdirs();
		}
		file.transferTo(dir);
		
		return "update";
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
	 * 删除课题
	 * 
	 * @param title
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@ResponseBody
	@RequestMapping(value = "delete", method = RequestMethod.GET)
	public String delete(@RequestParam("title") String title) throws UnsupportedEncodingException {
		title = new String(title.getBytes("ISO-8859-1"), "UTF-8");
		designService.delete(title);
		return "delete";
	}
}
