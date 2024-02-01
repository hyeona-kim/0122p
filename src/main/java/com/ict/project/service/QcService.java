package com.ict.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.mapper.QcMapper;
import com.ict.project.vo.QcVO;



@Service
public class QcService {
    @Autowired
    private QcMapper q_mapper;

    public QcVO list(String tr_idx){
        return q_mapper.list(tr_idx);
    }

    public int qedit(QcVO qvo){
        return q_mapper.edit(qvo);
    }
    public int qqedit(QcVO qvo){
        return q_mapper.qedit(qvo);
    }
    public int add(QcVO qvo){
        return q_mapper.add(qvo);
    }
    
}
