package com.ict.project.mapper;

import java.util.List;

import com.ict.project.vo.InflowPathVO;

public interface InflowPathMapper {
    List<InflowPathVO> all();
    int key(String id_idx);
    int add(InflowPathVO vo);
    int update(InflowPathVO vo);
    InflowPathVO search(String r_name);
}