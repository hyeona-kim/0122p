package com.ict.project.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class TrainingDiaryVO {
    private String td_idx, write_date, td_attend, td_tardy, td_earlyLeave, td_instruction, td_significant, c_idx,
            admin_check, ceo_check, attend_check, tardy_check, earlyLeave_check, classTime, s_name, sf_name, s_detail,td_status,td_sign;
}
