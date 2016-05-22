package com.qingtao.pojo;

public class Img {
    private Integer id;

    private String username;

    private String imgpath;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username == null ? null : username.trim();
    }

    public String getImgpath() {
        return imgpath;
    }

    public void setImgpath(String imgpath) {
        this.imgpath = imgpath == null ? null : imgpath.trim();
    }

	public Img() {
		super();
	}

	public Img(String username, String imgpath) {
		super();
		this.username = username;
		this.imgpath = imgpath;
	}
}