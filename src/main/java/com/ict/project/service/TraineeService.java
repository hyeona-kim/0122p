package com.ict.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.mapper.TraineeMapper;
import com.ict.project.vo.TraineeVO;

@Service
public class TraineeService {
    @Autowired
    private TraineeMapper t_mapper;

    // 훈련생 목록을 배열로 반환하는 기능
    public TraineeVO[] getTraineeList(String begin, String end) {
        TraineeVO[] ar = null;

        List<TraineeVO> list = t_mapper.list();
        if(list != null && list.size() > 0) {
            ar = new TraineeVO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }

    public TraineeVO view(String tr_idx){
        return t_mapper.view(tr_idx);
    }

    public TraineeVO[] all(){
        TraineeVO[] aa = null;

        List<TraineeVO> list = t_mapper.all();
        if(list != null && !list.isEmpty()){
            aa = new TraineeVO[list.size()];
            list.toArray(aa);
        }
        return aa;
    }

    public int getCount(){
        return t_mapper.count();
    }

    public TraineeVO[] getCourseTraineeList(String c_idx, String begin, String end){
        TraineeVO[] ar = null;

        List<TraineeVO> list = t_mapper.course_list(c_idx, begin, end);
        if(list != null && list.size() > 0) {
            ar = new TraineeVO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }

    public TraineeVO[] getCourseTraineeSearchList(String select, String value, String year, String begin, String end){
        TraineeVO[] ar = null;

        List<TraineeVO> list = t_mapper.course_search(select, value, year, begin, end);
        if(list != null && list.size() > 0) {
            ar = new TraineeVO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }

    public TraineeVO[] getCourseTraineeSearchValueList(String c_idx, String select, String value, String year, String begin, String end){
        TraineeVO[] ar = null;

        List<TraineeVO> list = t_mapper.course_searchValue(c_idx, select, value, year, begin, end);
        if(list != null && list.size() > 0) {
            ar = new TraineeVO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }

    public int getCourseTraineeCount(String c_idx){
        return t_mapper.course_count(c_idx);
    }

    public int getCourseSearchCount(String select,String value,String year){
        return t_mapper.search_count(select,value,year);
    }

    public int getCourseSearchValueCount(String c_idx, String select,String value,String year){
        return t_mapper.searchValue_count(c_idx, select,value,year);
    }
}
