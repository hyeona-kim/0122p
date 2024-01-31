package com.ict.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.mapper.TrfinalMapper;
import com.ict.project.vo.TrfinalVO;

@Service
public class TrfinalService {
    @Autowired
    private TrfinalMapper tf_mapper;

    public TrfinalVO list(String tr_idx){
        return tf_mapper.list(tr_idx);
    }

    public int tfedit(TrfinalVO tfvo){
        return tf_mapper.edit(tfvo);
    }
    
}
