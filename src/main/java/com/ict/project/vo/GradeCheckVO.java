package com.ict.project.vo;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class GradeCheckVO {
    private String gc_idx, qt_idx, gc_answer, gc_score, gc_memo, gc_status, tr_idx;
    private QuestionVO qvo; // 문제에서 타입과 배점 등을 받아와야 함
    private TraineeVO tvo; // 답안 작성한 인원 확인용
}
