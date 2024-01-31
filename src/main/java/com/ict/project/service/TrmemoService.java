package com.ict.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.mapper.TrmemoMapper;
import com.ict.project.vo.TrmemoVO;

@Service
public class TrmemoService {
    @Autowired
    private TrmemoMapper tm_mapper;

    public TrmemoVO list(String tr_idx){
        return tm_mapper.list(tr_idx);
    }
    
}
