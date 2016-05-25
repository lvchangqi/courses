package com.qingtao.pojo;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Design {
	private Integer id;

	private String title;

	private String other;

	private String tname;

	private Date time = new Date();

	private String content;
	
	private Integer counter;

	public Integer getCounter() {
		return counter;
	}

	public void setCounter(Integer counter) {
		this.counter = counter;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title == null ? null : title.trim();
	}

	public String getOther() {
		return other;
	}

	public void setOther(String other) {
		this.other = other == null ? null : other.trim();
	}

	public String getTname() {
		return tname;
	}

	public void setTname(String tname) {
		this.tname = tname == null ? null : tname.trim();
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content == null ? null : content.trim();
	}

	public Design() {
		super();
	}

	public Design(String title, String tname, String content) {
		super();
		this.title = title;
		this.tname = tname;
		this.content = content;
	}

	@Override
	public String toString() {
		return "Design [id=" + id + ", title=" + title + ", other=" + other + ", tname=" + tname + ", time="
				+ new SimpleDateFormat("yyyy-mm-dd").format(time) + ", content=" + content + "]";
	}

}