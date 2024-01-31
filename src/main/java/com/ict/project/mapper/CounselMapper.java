package com.ict.project.mapper;

import java.util.List;
import java.util.Map;

import com.ict.project.vo.CounselVO;

public interface CounselMapper {
    List<CounselVO> search(String select,String value,String year,String begin, String end);
    List<CounselVO> list(String begin,String end);
    int add(CounselVO vo);
    CounselVO getCounsel(String so_idx);
    int del(String so_idx);
	int edit(CounselVO vo);
    int count();
    int search_count(String select,String value,String year);
    List<CounselVO> counselList(String tr_idx);
    int counselCount(String tr_idx);
    List<CounselVO> clist(String c_idx);
    List<CounselVO> counsetr_idx(String tr_idx);
    int addCounselFile(Map<String,List<CounselVO>> map);

}
