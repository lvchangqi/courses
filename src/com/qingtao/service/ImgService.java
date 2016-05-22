package com.qingtao.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qingtao.dao.ImgMapper;
import com.qingtao.pojo.Img;
import com.qingtao.serviceI.ImgServiceI;

@Service
public class ImgService implements ImgServiceI {

	@Autowired
	private ImgMapper imgMapper;
	
	@Override
	public void insert(Img img) {
		imgMapper.insert(img);
	}

	@Override
	public void update(Img img) {
		imgMapper.update(img);
	}

	@Override
	public Img select(String username) {
		return imgMapper.select(username);
	}

	@Override
	public  List<Map<String, String>> selectRole(String role) {
		return imgMapper.selectRole(role);
	}

}
