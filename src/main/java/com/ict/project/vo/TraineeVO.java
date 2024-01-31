package com.ict.project.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class TraineeVO {


	//private String tr_idx, tr_name, tr_rrn, tr_phone, tr_hp, tr_pos_code, tr_addr, status, memo, c_idx, ct_code, tr_total_fee, ss_end, c_img, tr_nowstatus, ss_num,s_code,tr_card,tr_cancel_date,
					tr_cancel_text,tr_hrd,t_path,ori_name,file_name,tr_payment_date,tr_bc;

	private String tr_idx, tr_name, tr_rrn, tr_phone, tr_hp, tr_pos_code, tr_addr,
	 status, memo, c_idx, ct_code, tr_total_fee, ss_end, c_img, tr_nowstatus,
	  tr_cancel_date,tr_cancel_text, t_path, file_name, ori_name, s_code,ss_num, tr_hrd, tr_refund, tr_bc, tr_card, tr_charge ;


	private MultipartFile file; 
	private CourseVO cvo;
}
