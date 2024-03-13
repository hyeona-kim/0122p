package com.ict.project.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class TrainuploadVO {
	private String tn_idx, subject, content, file_name, ori_name, status,ip;
	private MultipartFile file;
	private boolean flag;
	

}
