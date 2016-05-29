package com.qingtao.dao;

import com.qingtao.pojo.Notice;

public interface NoticeMapper {

	void insert(String content);
	
	Notice select();
	
}