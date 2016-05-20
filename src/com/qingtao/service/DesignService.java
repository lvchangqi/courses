package com.qingtao.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qingtao.dao.DesignMapper;
import com.qingtao.pojo.Design;
import com.qingtao.serviceI.DesignServiceI;

@Service
public class DesignService implements DesignServiceI {

	@Autowired
	private DesignMapper designMapper;
	
	@Override
	public void insertSelective(Design record) {
		designMapper.insertSelective(record);
	}

	@Override
	public List<Design> selectAll(Map<String, String> map) {
		return designMapper.selectAll(map);
	}

}
