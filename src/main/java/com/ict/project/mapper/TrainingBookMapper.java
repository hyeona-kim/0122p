package com.ict.project.mapper;

import java.util.List;

import com.ict.project.vo.TrainingBookVO;

public interface TrainingBookMapper {
    List<TrainingBookVO> list(String begin, String end);

    int getTotalRecord();

    int delBook(String tb_idx);

    int addBook(TrainingBookVO vo);
}
