package com.ict.project.mapper;

import com.ict.project.vo.BusinessVO;

public interface BusinessMapper {

    BusinessVO list(String tr_idx);
    int edit(BusinessVO bvo);
    int add(BusinessVO bvo);
    
}
