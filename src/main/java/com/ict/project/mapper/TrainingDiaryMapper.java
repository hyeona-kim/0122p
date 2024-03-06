package com.ict.project.mapper;

import java.util.List;

import com.ict.project.vo.TrainingDiaryVO;

public interface TrainingDiaryMapper {
    List<TrainingDiaryVO> search(String c_idx,String select,String value,String begin,String end);
    List<TrainingDiaryVO> main_td(String begin,String end);
    int main_td_count();
    int search_count(String c_idx,String select,String value);
    List<TrainingDiaryVO> course_list(String c_idx, String begin, String end);
    int list_count(String c_idx);
    int add_td(TrainingDiaryVO tdvo);
    int del_td(String td_idx);
    int edit_td(TrainingDiaryVO tdvo);
    TrainingDiaryVO get_td(String td_idx);
    int sign_td(String td_idx,String td_sign,String sf_tmgr);
}
