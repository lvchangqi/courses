package com.qingtao.serviceI;

import java.util.List;

import com.qingtao.pojo.User;

public interface UserServiceI {

	/**
	 * 得到某个用户的全部信息
	 * @return
	 */
	public User selectOneUser(User user);
	
	/**
	 * 插入用户
	 * @param user
	 */
	public void insertSelective(User user);
	
	/**
	 * 更新用户
	 * @param user
	 */
	public void updateSelective(User user);
	
	/**
	 * 根据标题查询用户
	 * @param title
	 * @return
	 */
	public List<User> selectByTitle(String title);
}
