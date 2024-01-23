package com.ict.project.vo;

public class SuggestionVO {
	
	private String sg_idx, sg_writer, sg_write_date, sg_hit, sg_content, c_code, sg_subject, sg_file, notice, status;

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getNotice() {
		return notice;
	}

	public void setNotice(String notice) {
		this.notice = notice;
	}

	public String getSg_file() {
		return sg_file;
	}

	public void setSg_file(String sg_file) {
		this.sg_file = sg_file;
	}

	public String getSg_subject() {
		return sg_subject;
	}

	public void setSg_subject(String sg_subject) {
		this.sg_subject = sg_subject;
	}

	public String getSg_idx() {
		return sg_idx;
	}

	public void setSg_idx(String sg_idx) {
		this.sg_idx = sg_idx;
	}

	public String getSg_writer() {
		return sg_writer;
	}

	public void setSg_writer(String sg_writer) {
		this.sg_writer = sg_writer;
	}

	public String getSg_write_date() {
		return sg_write_date;
	}

	public void setSg_write_date(String sg_write_date) {
		this.sg_write_date = sg_write_date;
	}

	public String getSg_hit() {
		return sg_hit;
	}

	public void setSg_hit(String sg_hit) {
		this.sg_hit = sg_hit;
	}

	public String getSg_content() {
		return sg_content;
	}

	public void setSg_content(String sg_content) {
		this.sg_content = sg_content;
	}

	public String getC_code() {
		return c_code;
	}

	public void setC_code(String c_code) {
		this.c_code = c_code;
	}

}
