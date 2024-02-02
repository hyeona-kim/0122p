package com.ict.project.mapper;

import com.ict.project.vo.WorkplusVO;

public interface WorkplusMapper {

    WorkplusVO list(String tr_idx, String c_idx);
    int add(WorkplusVO wvo);
    
}
