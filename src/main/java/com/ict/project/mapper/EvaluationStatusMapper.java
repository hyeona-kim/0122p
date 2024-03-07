package com.ict.project.mapper;

import java.util.List;

import com.ict.project.vo.EvaluationStatusVO;

public interface EvaluationStatusMapper {

    EvaluationStatusVO subone(String s_idx);

    int edit(EvaluationStatusVO esvo);

    int add(EvaluationStatusVO esvo);

    int del(String es_idx);

    EvaluationStatusVO getone(String es_idx);

    int search_count(String es_idx);

    int on_off(String es_idx, String es_testStatus);
}
