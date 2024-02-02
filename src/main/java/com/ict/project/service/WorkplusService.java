package com.ict.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.mapper.WorkplusMapper;
import com.ict.project.vo.WorkplusVO;

@Service
public class WorkplusService {
    
    @Autowired
    WorkplusMapper w_mapper;

    public WorkplusVO list(String tr_idx, String c_idx){
        return w_mapper.list(tr_idx, c_idx);
    }

    public int addwork(WorkplusVO wvo){
        return w_mapper.add(wvo);
    }

    public int editwork(WorkplusVO wvo){
        return w_mapper.edit(wvo);
    }

}
