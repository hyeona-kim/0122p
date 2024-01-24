package com.ict.project.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UpSkillVO {
	
	private String us_idx, us_name, s_idx, us_ncs, sk_idx, t_idx, us_cnum;
	private SubjectVO sbo;
	private SkillVO sko;
	private StaffVO sfo;

	

}
