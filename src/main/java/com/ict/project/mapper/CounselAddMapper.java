package com.ict.project.mapper;

import java.util.List;

import com.ict.project.vo.CounselAddVO;

public interface CounselAddMapper {
    
    int add(CounselAddVO vo);
    
    List<CounselAddVO> list();

    
}
