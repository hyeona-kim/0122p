package com.ict.project.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class TimeVO {
	// 훈련일자.,훈련시작시간,훈련종료시간,방학여부,시작시간,시간구분,훈련강사코드,교육장소코드,교과목능력단위코드
	private String training_date, training_starttime, training_endtime, status, start_time, time_split, r_name, s_name,
			week;

}
