package com.ict.project.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class FileVO {
	
	private String f_idx, f_name, f_info, c_idx;
	MultipartFile file1,file2,file3,file4,file5,file6;
	MultipartFile[] file_ar;
}
