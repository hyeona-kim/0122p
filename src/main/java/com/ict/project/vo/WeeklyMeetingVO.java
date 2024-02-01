package com.ict.project.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class WeeklyMeetingVO {
    private String wk_idx, wk_deptname, wk_name, 
                    wk_date, wk_title, wk_attendance, wk_absentee,
                     wk_discussion, wk_announcement, wk_item, wk_image, wk_status;
    private String wk_file_name, wk_ori_name;
    private MultipartFile file;


}
