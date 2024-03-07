package com.ict.project.vo;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class QuestionVO {
    private String qt_idx, es_idx, qt_name, qt_score, qt_correct, qt_type, qt_content, qt_select, qt_status;
    private EvaluationStatusVO esvo; // 평가에서 정보 가져오기
    private GradeCheckVO[] gc_list;
}
