package com.ict.project.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class StaffVO {

	private String sf_idx, sf_code, sf_name, sf_phone, sf_email, sf_job, sf_hire_date, sf_fire_date, status, sf_id,
			sf_pwd, sf_tcr, sf_fname, sf_link, sf_mgr, sf_tmgr, sf_career, img_path;
	private String rt_name, c_name;
	private MultipartFile file;
}
