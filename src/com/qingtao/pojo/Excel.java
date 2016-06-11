package com.qingtao.pojo;

public class Excel {
	private Long studentid;// 学号

	private String promiss;// 姓名

	private String title;// 论文题目

	private String score;// 论文得分

	private Integer credit;// 学分

	private Long workid;// 老师工号

	private String tname;// 老师名字

	private String college;// 学院

	private String major;// 专业

	private Integer classes;// 班级
	
	private String ctitle;

	public String getCtitle() {
		return ctitle;
	}

	public void setCtitle(String ctitle) {
		this.ctitle = ctitle;
	}

	public Long getStudentid() {
		return studentid;
	}

	public void setStudentid(Long studentid) {
		this.studentid = studentid;
	}

	public String getPromiss() {
		return promiss;
	}

	public void setPromiss(String promiss) {
		this.promiss = promiss;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getScore() {
		return score;
	}

	public void setScore(String score) {
		this.score = score;
	}

	public Integer getCredit() {
		return credit;
	}

	public void setCredit(Integer credit) {
		this.credit = credit;
	}

	public Long getWorkid() {
		return workid;
	}

	public void setWorkid(Long workid) {
		this.workid = workid;
	}

	public String getTname() {
		return tname;
	}

	public void setTname(String tname) {
		this.tname = tname;
	}

	public String getCollege() {
		return college;
	}

	public void setCollege(String college) {
		this.college = college;
	}

	public String getMajor() {
		return major;
	}

	public void setMajor(String major) {
		this.major = major;
	}

	public Integer getClasses() {
		return classes;
	}

	public void setClasses(Integer classes) {
		this.classes = classes;
	}

	public Excel() {
		super();
	}

	public Excel(Long studentid, String promiss, String title, String score, Integer credit, Long workid, String tname,
			String college, String major, Integer classes) {
		super();
		this.studentid = studentid;
		this.promiss = promiss;
		this.title = title;
		this.score = score;
		this.credit = credit;
		this.workid = workid;
		this.tname = tname;
		this.college = college;
		this.major = major;
		this.classes = classes;
	}

	@Override
	public String toString() {
		return "Excel [studentid=" + studentid + ", promiss=" + promiss + ", title=" + title + ", score=" + score
				+ ", credit=" + credit + ", workid=" + workid + ", tname=" + tname + ", college=" + college + ", major="
				+ major + ", classes=" + classes + "]";
	}

}