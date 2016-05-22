package com.qingtao.dao;

import java.util.List;
import java.util.Map;

import com.qingtao.pojo.Img;

public interface ImgMapper {

    void insert(Img img);

    void update(Img img);
    
    Img select(String username);
    
    List<Map<String, String>> selectRole(String role);
}