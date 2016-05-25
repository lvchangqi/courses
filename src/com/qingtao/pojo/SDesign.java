package com.qingtao.pojo;

public class SDesign {
    private Integer id;

    private String title;
    
    private String filename;

    private Long studentid;
    
    private String file;

    private String agree;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename == null ? null : filename.trim();
	}

	public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public Long getStudentid() {
        return studentid;
    }

    public void setStudentid(Long studentid) {
        this.studentid = studentid;
    }

    public String getAgree() {
        return agree;
    }

    public void setAgree(String agree) {
        this.agree = agree == null ? null : agree.trim();
    }

	public String getFile() {
		return file;
	}

	public void setFile(String file) {
		this.file = file == null ? null : file.trim();
	}

	public SDesign() {
		super();
	}

	public SDesign(String filename, Long studentid, String file) {
		super();
		this.filename = filename;
		this.studentid = studentid;
		this.file = file;
	}

	@Override
	public String toString() {
		return "SDesign [id=" + id + ", title=" + title + ", filename=" + filename + ", studentid=" + studentid
				+ ", file=" + file + ", agree=" + agree + "]";
	}
}