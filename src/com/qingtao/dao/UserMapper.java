package com.qingtao.dao;

import java.util.List;

import com.qingtao.pojo.User;

public interface UserMapper {
	
	public User selectOneUser(User user);
	
	public void insertSelective(User user);
	
	public void updateSelective(User user);
	
	public List<User> selectByTitle(String title);
}
