package com.ict.project.mapper;

import java.util.List;

import com.ict.project.vo.SubjectVO;

public interface SubjectMapper {
    List<SubjectVO> list(String c_idx);
    
}