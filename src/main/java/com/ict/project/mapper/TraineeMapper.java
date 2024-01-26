package com.ict.project.mapper;

import java.util.List;

import com.ict.project.vo.TraineeVO;

public interface TraineeMapper {
    List<TraineeVO> all();
    int count();
    List<TraineeVO> list();
    TraineeVO view(String tr_idx);
    int del(String tr_idx, String c_idx);
    List<TraineeVO> clist(String c_idx);

}
