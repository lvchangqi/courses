package com.qingtao.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qingtao.dao.DesignMapper;
import com.qingtao.dao.SDesignMapper;
import com.qingtao.pojo.Design;
import com.qingtao.pojo.SDesign;
import com.qingtao.serviceI.DesignServiceI;

@Service
public class DesignService implements DesignServiceI {

	@Autowired
	private DesignMapper designMapper;
	
	@Autowired
	private SDesignMapper sDesignMapper;
	
	@Override
	public void insertSelective(Design record) {
		designMapper.insertSelective(record);
	}

	@Override
	public List<Design> selectAll(Map<String, String> map) {
		return designMapper.selectAll(map);
	}

	@Override
	public void insertSDesign(SDesign sdesign) {
		sDesignMapper.insertSelective(sdesign);
	}

	@Override
	public void delete(String title) {
		designMapper.delete(title);
	}

	@Override
	public void updateCounter(String title) {
		designMapper.updateCounter(title);
	}

	@Override
	public void updateFile(SDesign sdesign) {
		sDesignMapper.updateFile(sdesign);
	}

	@Override
	public SDesign selectOne(Long studentid) {
		return sDesignMapper.selectOne(studentid);
	}

}
