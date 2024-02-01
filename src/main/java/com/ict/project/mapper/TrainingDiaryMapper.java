package com.ict.project.mapper;

import java.util.List;

import com.ict.project.vo.TrainingDiaryVO;

public interface TrainingDiaryMapper {
    List<TrainingDiaryVO> search(String c_idx,String select,String value,String begin,String end);
    int search_count(String c_idx,String select,String value);
}
