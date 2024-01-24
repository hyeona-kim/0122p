package com.ict.project.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CounselVO {

    private String so_idx, so_day, tr_idx, sf_idx, so_menu, so_pp, so_subject, so_pd, c_idx, so_status;
    
    private CourseVO cvo;
    private TraineeVO tvo;
    private StaffVO svo;
}