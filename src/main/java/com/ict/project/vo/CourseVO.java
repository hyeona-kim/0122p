package com.ict.project.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CourseVO {
	private String c_status, c_code, c_idx, c_name, start_date, end_date, course_fee, c_peo_num, c_round_num, sf_idx,
			ti_idx, r_idx, ct_idx, tn_idx, c_day, c_time, c_timeExel;
	private RoomVO rvo;
	private CourseTypeVO ctvo;
	private StaffVO svo;
	private TrainuploadVO tvo;
	private boolean c_reg;
	private int total_hour;
	private SubjectVO[] sb_ar;
	private TraineeVO[] tr_ar;// 취소된 인원 제외.
	private TraineeVO[] tr_ar2;// 제적된 인원
	private TraineeVO[] tr_ar3;// 현재 수강중인 인원
	private TraineeVO[] tr_ar4;
	private TraineeVO[] tr_ar5;
	private TraineeVO[] tr_ar6;
	private TraineeVO[] tr_ar7;
	private CounselVO[] cs_ar;
	private TrainingDiaryVO[] td_ar;

}
