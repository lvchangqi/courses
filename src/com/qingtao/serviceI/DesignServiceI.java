package com.qingtao.serviceI;

import java.util.List;
import java.util.Map;

import com.qingtao.pojo.Design;

public interface DesignServiceI {
	
	/**
	 * 插入课程设计
	 * @param record
	 * @return
	 */
	void insertSelective(Design record);
	
	/**
	 * 查询课题
	 * @param map
	 * @return
	 */
	List<Design> selectAll(Map<String, String> map);
}
