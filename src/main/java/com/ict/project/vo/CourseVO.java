package com.ict.project.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CourseVO {
	private String c_status, c_code, c_idx, c_name, start_date, end_date, course_fee, c_peo_num, c_round_num, sf_idx, ti_idx, s_idx, r_idx, ct_idx, tn_idx,c_day,c_time;
	private RoomVO rvo;
	private CourseTypeVO ctvo;
	private StaffVO svo;
	private TrainuploadVO tvo;
	private boolean c_reg;
	private int total_hour;
	private SubjectVO[] sb_ar;

}
