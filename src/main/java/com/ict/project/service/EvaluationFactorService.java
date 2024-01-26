package com.ict.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.mapper.EvaluationFactorMapper;
import com.ict.project.vo.EvaluationFactorVO;


@Service
public class EvaluationFactorService {

    @Autowired
    private EvaluationFactorMapper ef_mapper;

    public EvaluationFactorVO[] getEvaluationFactorList() {
        EvaluationFactorVO[] ar = null;

        List<EvaluationFactorVO> list = ef_mapper.all();
        if(list != null && list.size() > 0) {
            ar = new EvaluationFactorVO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }
}
