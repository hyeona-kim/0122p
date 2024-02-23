package com.ict.project.mapper;

import java.util.List;

import com.ict.project.vo.EvaluationStatusVO;

public interface EvaluationStatusMapper {

    List<EvaluationStatusVO> list(String s_idx);

    int edit(EvaluationStatusVO esvo);

    int add(EvaluationStatusVO esvo);

}
