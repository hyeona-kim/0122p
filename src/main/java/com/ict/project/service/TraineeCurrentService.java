package com.ict.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.mapper.TraineeCurrentMapper;
import com.ict.project.vo.CourseVO;

@Service
public class TraineeCurrentService {
    @Autowired
    private TraineeCurrentMapper tc_mapper;

    // 과정(course)의 전체 수를 반환하는 기능
    public int getCount() {
        return tc_mapper.count();
    }

    // 과정 목록을 배열로 반환하는 기능
    public CourseVO[] getList(String begin, String end) {
        CourseVO[] ar = null;

        List<CourseVO> list = tc_mapper.list(begin, end);
        if(list != null && list.size() > 0) {
            ar = new CourseVO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }
}
