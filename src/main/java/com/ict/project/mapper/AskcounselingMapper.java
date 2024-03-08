package com.ict.project.mapper;

import java.util.List;

import com.ict.project.vo.AskcounselingVO;

public interface AskcounselingMapper {
    List<AskcounselingVO> getASK(String beforedate,String enddate,String type,String c_idx);
    AskcounselingVO selectASK(String ac_idx);
    int updateASK(String ac_idx,String ac_answer_date,String ac_answer);
}
