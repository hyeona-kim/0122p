package com.ict.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.mapper.CounselAddMapper;
import com.ict.project.vo.CounselAddVO;

@Service
public class CounselAddService {
    
    @Autowired
    private CounselAddMapper c_Mapper;
    
    public int add(CounselAddVO vo){
        return c_Mapper.add(vo);
    }

    public CounselAddVO[] list(String c_idx){
        CounselAddVO[] ar  = null;
        List<CounselAddVO> list = c_Mapper.list(c_idx);
        
        if( list != null && list.size() >0){
            ar = new CounselAddVO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }
    
}

