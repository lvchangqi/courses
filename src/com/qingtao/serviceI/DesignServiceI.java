package com.qingtao.serviceI;

import java.util.List;
import java.util.Map;

import com.qingtao.pojo.Design;
import com.qingtao.pojo.SDesign;

public interface DesignServiceI {

	/**
	 * 插入课程设计
	 * 
	 * @param record
	 * @return
	 */
	void insertSelective(Design record);

	/**
	 * 查询课题
	 * 
	 * @param map
	 * @return
	 */
	List<Design> selectAll(Map<String, String> map);

	/**
	 * 选择课题
	 * 
	 * @param sdesign
	 */
	void insertSDesign(SDesign sdesign);

	/**
	 * 课题文件上传
	 * 
	 * @param sdesign
	 */
	void updateFile(SDesign sdesign);
	
	/**
	 * 课题文件下载
	 * 
	 * @param studentid
	 * @return
	 */
	SDesign selectOne(Long studentid);

	/**
	 * 删除课题
	 * 
	 * @param title
	 */
	void delete(String title);

	/**
	 * 更新课题数量
	 * 
	 * @param title
	 */
	void updateCounter(Map<String, String> map);
}
