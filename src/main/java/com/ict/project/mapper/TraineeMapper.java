package com.ict.project.mapper;

import java.util.List;

import com.ict.project.vo.TraineeVO;

public interface TraineeMapper {
    List<TraineeVO> all();
    int count();
    List<TraineeVO> list();
    TraineeVO view(String tr_idx);
    
    // resultMap관련 추가
    int course_count(String c_idx);
    int search_count(String select,String value,String year);
    List<TraineeVO> course_search(String select,String value,String year,String begin, String end);
    List<TraineeVO> course_list(String c_idx, String begin,String end);




}
