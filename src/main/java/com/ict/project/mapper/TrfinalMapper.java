package com.ict.project.mapper;

import com.ict.project.vo.TrfinalVO;

public interface TrfinalMapper {

    TrfinalVO list(String tr_idx);
    int edit(TrfinalVO tfvo);
    int add(TrfinalVO tfvo);
    
}
