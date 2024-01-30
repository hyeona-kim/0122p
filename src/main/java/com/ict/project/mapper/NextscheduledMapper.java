package com.ict.project.mapper;

import java.util.List;

import com.ict.project.vo.NextscheduledVO;

public interface NextscheduledMapper {
    List<NextscheduledVO> all();
    int key(String ns_idx);
    int add(NextscheduledVO vo);
    int update(NextscheduledVO vo);
    NextscheduledVO search(String ns_name);
    int del(String ns_idx);
}