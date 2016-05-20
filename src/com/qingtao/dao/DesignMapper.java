package com.qingtao.dao;

import java.util.List;
import java.util.Map;

import com.qingtao.pojo.Design;

public interface DesignMapper {
	void insertSelective(Design record);
	
	List<Design> selectAll(Map<String, String> map);
}
