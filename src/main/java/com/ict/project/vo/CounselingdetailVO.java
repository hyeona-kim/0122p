package com.ict.project.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CounselingdetailVO {
	
	private String cd_idx, sf_idx, cd_date, cd_name, cd_phone, ct_idx, 
					c_idx, cd_status, cd_manageStatus, cd_cancel, ns_idx, 
					cd_subject, cd_status2, cd_personalNum, cd_card, cd_address, 
					id_idx, cd_result, cd_cardType;
	private CourseTypeVO ctvo;
	private CourseVO cvo;
	private StaffVO svo;
	private NextscheduledVO nsvo;
	private InflowPathVO idvo;

}
