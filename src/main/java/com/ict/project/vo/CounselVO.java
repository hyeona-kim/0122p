package com.ict.project.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CounselVO {

    private String so_idx, ss_day, tr_idx, ss_menu, ss_pp, ss_subject, ss_pd, c_idx, status;
    
    private CourseVO cvo;

    private TraineeVO tvo;
}