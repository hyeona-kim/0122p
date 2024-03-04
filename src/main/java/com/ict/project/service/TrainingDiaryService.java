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

    public TrainingDiaryVO[] course_list(String c_idx, String begin, String end){
        TrainingDiaryVO[] ar = null;
        List<TrainingDiaryVO> list = td_mapper.course_list(c_idx, begin, end);
        if(list != null && !list.isEmpty()){
            ar = new TrainingDiaryVO[list.size()];
            list.toArray(ar);
        }
        return ar;
    }
    public int list_count(String c_idx){
        return td_mapper.list_count(c_idx);
    }
    public int td_add(TrainingDiaryVO tdvo){
        return td_mapper.add_td(tdvo);
    }
    public int del_td(String td_idx){
        return td_mapper.del_td(td_idx);
    }
    public TrainingDiaryVO get_td(String td_idx){
        return td_mapper.get_td(td_idx);
    }
    public int edit_td(TrainingDiaryVO tdvo){
        return td_mapper.edit_td(tdvo);
    }
}
