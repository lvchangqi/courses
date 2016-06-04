package com.qingtao.dao;

import java.util.List;

import com.qingtao.pojo.Excel;

public interface ExcelMapper {
	
	List<Excel> excel(String name);
	
	String excelsup(Long workid);
}
