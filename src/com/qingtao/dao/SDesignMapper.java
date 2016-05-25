package com.qingtao.dao;

import com.qingtao.pojo.SDesign;

public interface SDesignMapper {

	void insertSelective(SDesign record);

	void updateFile(SDesign record);
	
	SDesign selectOne(Long studentid);
}