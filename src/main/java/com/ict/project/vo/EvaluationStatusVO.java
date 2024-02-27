package com.ict.project.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class EvaluationStatusVO {
    private String es_idx, es_name, es_type, es_examStatus, es_gradingStatus,
            sf_idx, es_date, es_time, es_totalScore, es_level, es_num_question,
            sk_idx, s_idx, es_status;
    private QuestionVO[] qt_ar;
}
