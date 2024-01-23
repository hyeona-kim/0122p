package com.ict.project.mapper;

import java.util.List;

import com.ict.project.vo.CounselAddVO;

public interface CounselAddMapper {
    
    List<CounselAddVO> list();

    int add(CounselAddVO vo);

}
