package com.ict.project.mapper;

import java.util.List;

import com.ict.project.vo.GradeCheckVO;

public interface GradeCheckMapper {

    List<GradeCheckVO> list();
    GradeCheckVO getOne(String gc_idx);
    int add(GradeCheckVO vo);
    int staff_edit(String gc_idx, String gc_score, String gc_memo);
    int trainee_edit(String gc_idx, String gc_answer);
    int set_grade(String gc_idx); // 답안 제출 후 trainee_edit 호출 뒤에 바로 호출하면 자동으로 입력
    int all_grade(String es_idx, String tr_idx); // 성적 비교할 수 있으므로 int형으로 받음
}
