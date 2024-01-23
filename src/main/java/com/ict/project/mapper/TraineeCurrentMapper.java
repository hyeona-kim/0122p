package com.ict.project.mapper;

import java.util.List;

import com.ict.project.vo.CourseVO;

public interface TraineeCurrentMapper {
    int count();
    List<CourseVO> list(String begin, String end);

}
