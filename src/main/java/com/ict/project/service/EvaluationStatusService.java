package com.ict.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.mapper.EvaluationStatusMapper;
import com.ict.project.vo.EvaluationStatusVO;

@Service
public class EvaluationStatusService {
    @Autowired
    private EvaluationStatusMapper es_Mapper;

    public EvaluationStatusVO subone(String s_idx) {

        return es_Mapper.subone(s_idx);

    }

    public int edit(EvaluationStatusVO bvo) {
        return es_Mapper.edit(bvo);
    }

    public int add(EvaluationStatusVO bvo) {
        return es_Mapper.add(bvo);
    }

    public int del(String es_idx) {
        return es_Mapper.del(es_idx);
    }

    public EvaluationStatusVO getone(String es_idx) {
        return es_Mapper.getone(es_idx);
    }

    public int getSearchCount(String es_idx) {
        return es_Mapper.search_count(es_idx);
    }

}
