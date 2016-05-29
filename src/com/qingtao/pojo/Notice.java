package com.qingtao.pojo;

import java.util.Date;

public class Notice {
    private Integer id;

    private String content;

    private Date time;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

	public Notice() {
		super();
	}

	public Notice(String content) {
		super();
		this.content = content;
	}

	@Override
	public String toString() {
		return "Notice [id=" + id + ", content=" + content + ", time=" + time + "]";
	}
}