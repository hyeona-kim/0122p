package com.ict.project.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CourseTypeVO {
	
	private String ct_idx, ct_name, ct_color;

	private CourseVO cvo;
	private CourseVO[] c_ar;

}
