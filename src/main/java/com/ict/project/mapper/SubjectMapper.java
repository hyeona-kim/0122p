package com.ict.project.mapper;

import java.util.List;
import java.util.Map;

import com.ict.project.vo.SubjectVO;

public interface SubjectMapper {
    List<SubjectVO> list(int c_idx);

    int add(Map<String, List<SubjectVO>> map);

    int edit_sb(SubjectVO sfvo);

}