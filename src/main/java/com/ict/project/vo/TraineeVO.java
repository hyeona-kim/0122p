package com.ict.project.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class TraineeVO {
	
	/*private String tr_idx, tr_name, tr_rrn, tr_phone,
	 tr_hp, tr_pos_code, tr_addr, tr_status, memo, c_idx,
	  ct_code, tr_total_fee,tr_nowstatus;*/

//선우씨, 현아씨 합의
	private String tr_idx, tr_name, tr_rrn, tr_phone, tr_hp, tr_pos_code, tr_addr, status, memo, c_idx, ct_code, tr_total_fee, ss_end, c_img, tr_nowstatus, ss_num,s_code;

	private CourseVO cvo;



}
