package com.qingtao.dao;

import java.util.List;
import java.util.Map;

import com.qingtao.pojo.User;

public interface UserMapper {
	
	public User selectOneUser(User user);
	
	public void insertSelective(User user);
	
	public void updateSelective(User user);
	
	public List<Map<String, String>> selectByTitle(String title);
	
	public List<User> selectAll(Map<String, String> map);
	
}
