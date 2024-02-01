package com.ict.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.mapper.QcMapper;
import com.ict.project.vo.QcVO;



@Service
public class QcService {
    @Autowired
    private QcMapper q_mapper;

    public QcVO[] list(String tr_idx){
        QcVO[] ar = null;

        List<QcVO> list = q_mapper.list(tr_idx);
        if(list != null && list.size() > 0) {
            ar = new QcVO[list.size()];
            list.toArray(ar);
        }
        
        return ar;
    }

    public int editWrite(QcVO qvo){
        return q_mapper.editWrite(qvo);
    }

    public int addWrite(QcVO qvo){
        return q_mapper.addWrite(qvo);
    }
    
}
