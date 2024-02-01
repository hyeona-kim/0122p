package com.ict.project.mapper;

import com.ict.project.vo.QcVO;

public interface QcMapper {

    QcVO list(String tr_idx);
    int edit(QcVO qvo);

}
