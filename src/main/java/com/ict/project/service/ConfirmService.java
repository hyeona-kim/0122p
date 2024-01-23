package com.ict.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.mapper.ConfirmMapper;
import com.ict.project.vo.TrainuploadVO;

@Service
public class ConfirmService {
    
    @Autowired
    private ConfirmMapper c_mapper;

    public TrainuploadVO[] searchConfirm() {
        TrainuploadVO[] ar = null;
        List<TrainuploadVO> list = c_mapper.search();
        if(list != null && list.size() > 0) {
            ar = new TrainuploadVO[list.size()];
            list.toArray(ar);
        }
        return ar;
    }

}
