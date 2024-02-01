package com.ict.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.mapper.TrainingDiaryMapper;
import com.ict.project.vo.TrainingDiaryVO;

@Service
public class TrainingDiaryService {
    @Autowired
    TrainingDiaryMapper td_mapper;

    public TrainingDiaryVO[] searchList(String c_idx,String select,String value,String begin,String end){
        TrainingDiaryVO[] ar = null;
        List<TrainingDiaryVO> list = td_mapper.search(c_idx, select, value, begin, end);
        if(list != null && !list.isEmpty()){
            ar = new TrainingDiaryVO[list.size()];
            list.toArray(ar);
        }
        return ar;
    }
    public int searchCount(String c_idx,String select,String value){
        return td_mapper.search_count(c_idx, select, value);
    }
}
