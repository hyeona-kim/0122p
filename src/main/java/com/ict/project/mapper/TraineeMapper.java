package com.ict.project.mapper;

import java.util.List;

import com.ict.project.vo.TraineeVO;

public interface TraineeMapper {
    List<TraineeVO> all();
    int count();
    List<TraineeVO> list();

}
