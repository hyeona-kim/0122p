package com.ict.project.mapper;

import java.util.List;

import com.ict.project.vo.CourseTypeVO;
import com.ict.project.vo.CourseVO;

public interface CourseMapper {
    List<CourseVO> search(String select, String value, String year, String begin, String end);

    List<CourseVO> list(String begin, String end);

    int add(CourseVO vo);

    CourseVO getCourse(String c_idx);

    int del(String c_idx);

    int edit(CourseVO vo);

    int count();

    CourseVO getCourse2(String c_idx);

    int search_count(String select, String value, String year);

    int reg_count(String year);

    List<CourseVO> reg_search(String year);

    List<CourseVO> all();

    int tnAdd(String tn_idx, String c_idx);

    List<CourseVO> search_ct(String c_idx, String ct_idx);
}
