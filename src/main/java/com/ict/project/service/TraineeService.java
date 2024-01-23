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
    public TraineeVO[] getTraineeList() {
        TraineeVO[] ar = null;

        List<TraineeVO> list = t_mapper.all();
        if(list != null && list.size() > 0) {
            ar = new TraineeVO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }
}
