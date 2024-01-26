package com.ict.project.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class SuggestionVO {
	
	private String sg_idx, sg_writer, sg_write_date, sg_hit, sg_content, c_code, sg_subject, notice, status;
	private String sg_file_name, sg_ori_name;
	private MultipartFile file;
}
