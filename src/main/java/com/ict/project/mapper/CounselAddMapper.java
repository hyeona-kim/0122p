package com.ict.project.mapper;

import java.util.List;

import com.ict.project.vo.CounselAddVO;

public interface CounselAddMapper {
    
    int add(CounselAddVO vo);
    
    List<CounselAddVO> list(String c_idx);

    CounselAddVO one(String ss_idx);
    
    int edit(CounselAddVO vo);

    int del(String ss_idx);
}
