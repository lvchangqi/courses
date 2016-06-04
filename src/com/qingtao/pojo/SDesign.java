package com.qingtao.pojo;

public class SDesign {
    private Integer id;

    private String title;
    
    private String filename;

    private Long studentid;
    
    private String file;

    private String agree;
    
    private String ctitle;

    public String getCtitle() {
		return ctitle;
	}

	public void setCtitle(String ctitle) {
		this.ctitle = ctitle;
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

	public SDesign(Long studentid, String agree) {
		super();
		this.studentid = studentid;
		this.agree = agree;
	}

	public SDesign(String filename, Long studentid, String file, String agree) {
		super();
		this.filename = filename;
		this.studentid = studentid;
		this.file = file;
		this.agree = agree;
	}

	@Override
	public String toString() {
		return "SDesign [id=" + id + ", title=" + title + ", filename=" + filename + ", studentid=" + studentid
				+ ", file=" + file + ", agree=" + agree + "]";
	}
}