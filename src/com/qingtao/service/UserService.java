package com.qingtao.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qingtao.dao.UserMapper;
import com.qingtao.pojo.User;
import com.qingtao.serviceI.UserServiceI;

@Service
public class UserService implements UserServiceI {

	@Autowired
	private UserMapper userMapper;
	
	@Override
	public User selectOneUser(User user) {
		return userMapper.selectOneUser(user);
	}

	@Override
	public void insertSelective(User user) {
		userMapper.insertSelective(user);
	}

	@Override
	public void updateSelective(User user) {
		userMapper.updateSelective(user);
	}

	@Override
	public List<Map<String, String>> selectByTitle(String title) {
		return userMapper.selectByTitle(title);
	}

	@Override
	public List<User> selectAll(Map<String, String> map) {
		return userMapper.selectAll(map);
	}

}
