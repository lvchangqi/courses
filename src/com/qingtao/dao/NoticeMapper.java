package com.qingtao.dao;

import java.util.Map;

import com.qingtao.pojo.Notice;

public interface NoticeMapper {

	void insert(Map<String ,String> map);
	
	Notice select(String name);
	
}