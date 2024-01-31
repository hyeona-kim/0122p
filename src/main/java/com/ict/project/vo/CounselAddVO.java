package com.ict.project.vo;


import lombok.Getter;
import lombok.Setter;

@Getter@Setter
public class CounselAddVO {
  
    private String ss_idx, ss_tname, ss_time,  ss_name, ss_msg, ss_msubject, ss_img, ss_member, ss_mday, ss_pa,
    ss_cnt,ss_day, c_idx,sf_idx,ss_p, ss_status;

    private CounselVO co_vo;
}
