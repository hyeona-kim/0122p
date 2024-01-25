package com.ict.project.vo;

import org.springframework.web.multipart.MultipartFile;

public class TrainuploadVO {
	private String tn_idx, subject, content, file_name, ori_name, tn_name, status,ip;
	private MultipartFile file;
	

	public String getTn_idx() {
		return tn_idx;
	}

	public void setTn_idx(String tn_idx) {
		this.tn_idx = tn_idx;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getFile_name() {
		return file_name;
	}

	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}

	public String getOri_name() {
		return ori_name;
	}

	public void setOri_name(String ori_name) {
		this.ori_name = ori_name;
	}

	public String getTn_name() {
		return tn_name;
	}

	public void setTn_name(String tn_name) {
		this.tn_name = tn_name;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}
	
	
	
	

}
