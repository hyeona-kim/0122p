package com.ict.project.mapper;

import java.util.List;

import com.ict.project.vo.CourseTypeVO;
import com.ict.project.vo.TraineeVO;

public interface TraineeMapper {
    List<TraineeVO> all();
    int count();
    List<TraineeVO> list();
    
    //ha
    int del(String tr_idx, String c_idx);
    List<TraineeVO> clist(String c_idx);
    TraineeVO view(String tr_idx);
    TraineeVO tlist(String tr_idx, String c_idx);
    int trainedit(TraineeVO tvo);
    TraineeVO getcard(String tr_idx);
    int nowstatus(String tr_idx, String tr_nowstatus);
    
    
    //sw
    // resultMap관련 추가
    int course_count(String c_idx);
    int search_count(String select,String value,String year);
    int searchValue_count(String c_idx, String select,String value,String year);
    List<TraineeVO> course_list(String c_idx, String begin,String end);
    List<TraineeVO> course_search(String select,String value,String year,String begin, String end);
    List<TraineeVO> course_searchValue(String c_idx, String select,String value,String year,String begin, String end);

    int counsel_date(String tr_idx, String ss_end, String ss_num);
   
    List<TraineeVO> traineeReg(String begin,String end);
    int traineeReg_count();
    List<CourseTypeVO> courseType(String ct_idx);



}
