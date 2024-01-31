package com.ict.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.mapper.BusinessMapper;
import com.ict.project.vo.BusinessVO;

@Service
public class BusinessService {
    @Autowired
    private BusinessMapper bs_mapper;

    public BusinessVO list(String tr_idx){
        
        return bs_mapper.list(tr_idx);
    }
    
}
