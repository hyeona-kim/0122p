package com.ict.project.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PaymentDTO {
    
    private String p_idx, p_id, p_date, tr_idx, tb_idx;
    private TraineeVO tvo;
    private TrainingBookVO tbvo;
}
