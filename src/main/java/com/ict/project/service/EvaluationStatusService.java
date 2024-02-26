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

    public EvaluationStatusVO[] list(String s_idx) {

        EvaluationStatusVO[] ar = null;

        List<EvaluationStatusVO> list = es_Mapper.list(s_idx);
        if (list != null && list.size() > 0) {
            ar = new EvaluationStatusVO[list.size()];
            list.toArray(ar);
        }

        return ar;
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

}
