package com.ict.project.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SubjectVO {
	private String s_idx, s_title, us_name, s_type, sf_name, s_category_num, hour, r_name,c_idx,s_status;
	private SkillVO[] sk_ar;
	

}
