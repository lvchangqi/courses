package com.qingtao.serviceI;

import java.util.List;
import java.util.Map;

import com.qingtao.pojo.Img;

public interface ImgServiceI {
	
	/**
	 * 上传图片
	 * @param record
	 */
    public void insert(Img img);
    
    /**
     * 更新图片
     * @param record
     */
    public void update(Img img);
    
    /**
     * 查找图片
     * @param username
     * @return
     */
    public Img select(String username);
    
    /**
     * 查找资源集合
     * @param role
     * @return
     */
    public List<Map<String, String>> selectRole(String role);
}
