package com.ict.project.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class BoardVO {
	private String bd_idx, bd_subject, bd_writer, bd_write_date, bd_hit, bd_content, bd_fname, bd_oname, bd_notice, bd_status, c_idx;
	private MultipartFile file;
	private String c_name;
}
