package com.qingtao.pojo;

public class User {
    private Integer id;

    private String username;

    private String password;

    private Long studentid;

    private Long qq;

    private Long phone;

    private String role;
    
    private String teacher = "无";

    private String promiss;

    public String getTeacher() {
		return teacher;
	}

	public void setTeacher(String teacher) {
		this.teacher = teacher;
	}

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

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }

    public Long getStudentid() {
        return studentid;
    }

    public void setStudentid(Long studentid) {
        this.studentid = studentid;
    }

    public Long getQq() {
        return qq;
    }

    public void setQq(Long qq) {
        this.qq = qq;
    }

    public Long getPhone() {
        return phone;
    }

    public void setPhone(Long phone) {
        this.phone = phone;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role == null ? null : role.trim();
    }

    public String getPromiss() {
        return promiss;
    }

    public void setPromiss(String promiss) {
        this.promiss = promiss == null ? null : promiss.trim();
    }

	public User() {
		super();
	}

	public User(String username, Long studentid) {
		super();
		this.username = username;
		this.studentid = studentid;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", username=" + username + ", password=" + password + ", studentid=" + studentid
				+ ", qq=" + qq + ", phone=" + phone + ", role=" + role + ", promiss=" + promiss + "]";
	}
}