package com.qingtao.service;

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

}
