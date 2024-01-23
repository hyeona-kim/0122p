package com.ict.project.mapper;

import java.util.List;

import com.ict.project.vo.CourseTypeVO;

public interface CourseTypeMapper {

    int key(String ct_idx);
    int add(CourseTypeVO vo);
    int update(CourseTypeVO vo);
    List<CourseTypeVO> all();
    CourseTypeVO search(String ct_name);
}
