package com.ict.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.mapper.QuestionMapper;
import com.ict.project.vo.QuestionVO;

@Service
public class QuestionService {
    
    @Autowired
    private QuestionMapper qt_mapper;

    public QuestionVO[] list(){

        QuestionVO[] ar = null;

        List<QuestionVO> list = qt_mapper.list();
        if (list != null && list.size() > 0) {
            ar = new QuestionVO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }
    QuestionVO getOne(String qt_idx){
        return qt_mapper.getOne(qt_idx);
    }
    int add(QuestionVO vo){
        return qt_mapper.add(vo);
    }
    int edit(QuestionVO vo){
        return qt_mapper.edit(vo);
    }
}
